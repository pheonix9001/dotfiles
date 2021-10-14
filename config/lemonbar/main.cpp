#include <fcntl.h>
#include <sys/types.h>
#include <unistd.h>
#include <xcb/xcb.h>
#include <string.h>
#include <thread>

#include <iostream>

#include "x.h"
#include "redraw.h"
#include "moduledefs.h"
#include "modules.h"

extern xcb_connection_t* dpy;
extern xcb_window_t root;

extern int rx_bytes_fd, tx_bytes_fd;
extern int temperature_fd;

extern AsyncModule windowModule;
extern AsyncModule desktopModule;
extern FunctionModule timeModule;

Bar mainbar{};

// on exit function
void onExit(int, void *) {
	write(2, "ending", 6);
	xcb_disconnect(dpy);
}

int main(){
	// register signal handlers
	on_exit(onExit, 0);

	// open some file descriptors
	rx_bytes_fd = open("/sys/class/net/wlan0/statistics/rx_bytes", O_RDONLY);
	tx_bytes_fd = open("/sys/class/net/wlan0/statistics/tx_bytes", O_RDONLY);
	temperature_fd = open("/sys/class/thermal/thermal_zone1/temp", O_RDONLY);

	// handles X events
	std::thread eventHandler{eventHandlerFunc};

	windowModule.update();
	desktopModule.update();

	TextModule space{" "};
	TextModule center{"%{c}"};

	mainbar.modules = {
		(Module*)&space, (Module*)&desktopModule, (Module*)&space, (Module*)&windowModule,
		(Module*)&center, (Module*)&timeModule
	};

	while(true) {
		mainbar.redraw();

		std::this_thread::sleep_for(std::chrono::seconds{1});
	}

	return 0;
}
