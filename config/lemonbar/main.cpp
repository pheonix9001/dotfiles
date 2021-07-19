#include <fcntl.h>
#include <sys/types.h>
#include <unistd.h>
#include <xcb/xcb.h>
#include <string.h>
#include <thread>
#include <uv.h>

#include <iostream>

#include "x.h"
#include "redraw.h"
#include "asyncmodules.h"

extern char* windowname;
extern char* desktops;
extern xcb_connection_t* dpy;
extern xcb_window_t root;

extern int rx_bytes_fd, tx_bytes_fd;
extern int temperature_fd;

extern AsyncModule windowModule;
extern AsyncModule desktopModule;

uv_loop_t* defloop;
uv_timer_t drawtimer;

// on exit function
void onExit(int, void *) {
  write(2, "ending", 6);
	xcb_disconnect(dpy);
}

int main(){
	// xcb stuff
	dpy = xcb_connect(0, 0);
	root = xcb_setup_roots_iterator(xcb_get_setup(dpy)).data->root;

	// libuv stuff
	defloop = uv_default_loop();

  // register signal handlers
  on_exit(onExit, 0);

	// open some file descriptors
  rx_bytes_fd = open("/sys/class/net/wlp2s0/statistics/rx_bytes", O_RDONLY);
  tx_bytes_fd = open("/sys/class/net/wlp2s0/statistics/tx_bytes", O_RDONLY);
	temperature_fd = open("/sys/class/thermal/thermal_zone1/temp", O_RDONLY);

	// async modules
	uv_async_send(&windowModule.async);
	uv_async_send(&desktopModule.async);

	// handles X events
	std::thread eventHandler{eventHandlerFunc};

	// setup default timer
	// uv_timer_init(defloop, &drawtimer);
	uv_timer_init(defloop, &drawtimer);
	uv_timer_start(&drawtimer, redraw, 0, 1000);

	return uv_run(defloop, UV_RUN_DEFAULT);
}
