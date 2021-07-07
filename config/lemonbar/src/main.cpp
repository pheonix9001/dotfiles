#include <fcntl.h>
#include <signal.h>
#include <sys/types.h>
#include <unistd.h>
#include <xcb/xcb.h>
#include <string.h>
#include <thread>

#include <iostream>

#include "network.h"
#include "misc.h"
#include "asyncmodules.h"
#include "x.h"
#include "helpers.h"

extern char * desktops;
extern char * windowname;
extern xcb_connection_t * dpy;
extern xcb_window_t root;

extern int rx_bytes_fd, tx_bytes_fd;
extern int temperature_fd;

// on exit function
void onExit(int, void *) {
  write(2, "ending", 6);
	xcb_disconnect(dpy);
}

int main(){
	// xcb stuff
	dpy = xcb_connect(0, 0);
	root = xcb_setup_roots_iterator(xcb_get_setup(dpy)).data->root;

  // register signal handlers
  on_exit(onExit, 0);

	// open some file descriptors
  rx_bytes_fd = open("/sys/class/net/wlp2s0/statistics/rx_bytes", O_RDONLY);
  tx_bytes_fd = open("/sys/class/net/wlp2s0/statistics/tx_bytes", O_RDONLY);
	temperature_fd = open("/sys/class/thermal/thermal_zone1/temp", O_RDONLY);

  // async modules
	bzero(windowname, 64);
	bzero(desktops, 1024);

	// handles X events
	std::thread eventHandler{eventHandlerFunc};

	WindowModule();
	DesktopModule();

	for(;;) {
		redraw();
		sleep(1);
	}
}
