#include <unistd.h>
#include <signal.h>
#include <cstring>
#include <cstdio>
#include <xcb/xcb.h>
#include <xcb/xcb_icccm.h>
#include <math.h>

#include "helpers.h"

char * desktops = new char[1024];
char * windowname = new char[64];

xcb_connection_t * dpy;

void WindowModule(int) {
	// get focused window
	auto focused = xcb_get_input_focus_reply(dpy, xcb_get_input_focus(dpy), 0);
	
	size_t len;

	xcb_icccm_get_text_property_reply_t itr;
	xcb_icccm_get_wm_name_reply(dpy, xcb_icccm_get_wm_name(dpy, focused->focus), &itr, NULL);

	snprintf(windowname, itr.name_len + 1, "%s", itr.name); 

	// cleanup
	delete focused;
}

void DesktopModule(int) {
	LoadModule("/home/sundaran/.scripts/lemonbar/desktopmodule" , desktops, 1024);
	kill(getpid(), SIGUSR2);
}
