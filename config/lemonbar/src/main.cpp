#include <fcntl.h>
#include <signal.h>
#include <sys/types.h>
#include <unistd.h>
#include <xcb/xcb.h>
#include <string.h>

#include <iostream>

#include "network.h"
#include "misc.h"
#include "asyncmodules.h"

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

	// Desktop Module calls window module with a signal
	signal(SIGUSR2, WindowModule);
	DesktopModule(0); 

	signal(SIGUSR1, DesktopModule);

	for(;;) {
		std::cout << " "
			// "\xef\x8c\x9a" tux: 
			"\xef\x8c\x83" // arch logo: 
			" "
			<< desktops << " " << windowname;

		// center aligned modules
		std::cout << "%{c}";
		TimeModule();

		// right aligned modules
		std::cout << "%{r}";
		TempModule();
		std::cout << " ";
		NetworkModule();

		std::cout << " \n";
		std::cout.flush();
		sleep(1);
	}
}
