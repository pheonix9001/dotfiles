#include <unistd.h>
#include <signal.h>
#include <cstring>
#include <cstdio>
#include <xcb/xcb.h>
#include <xcb/xcb_icccm.h>
#include <uv.h>

#include "redraw.h"

char * desktops = new char[1024];
extern char* windowname;

extern xcb_connection_t * dpy;
extern xcb_window_t root;

void windowModuleFunc(uv_async_t* handle) {
	xcb_get_input_focus_reply_t * focused;
	xcb_icccm_get_text_property_reply_t itr;

	// zero out the windowname
	memset(windowname, 0, 64);

	// get focused window
	auto focusedcookie = xcb_get_input_focus(dpy);
	focused = xcb_get_input_focus_reply(dpy, focusedcookie, 0);

	// check if window is root
	if(focused->focus == root) {
		snprintf(windowname, 64, "Root");
		redraw(0);
		return;
	}

	// get window title
	xcb_icccm_get_wm_name_reply(dpy, xcb_icccm_get_wm_name(dpy, focused->focus), &itr, NULL);

	bzero(windowname, 64);
	snprintf(windowname, MIN(64, itr.name_len + 1), "%s", itr.name); 

	// cleanup
	delete focused;

	redraw(0);
}

AsyncModule windowModule{windowModuleFunc};

void desktopModuleFunc(uv_async_t* handle) {
	loadModuleFromFile("/home/asdf/.scripts/lemonbar/desktopmodule" , desktops, 1024);
	redraw(0);
}

AsyncModule desktopModule{desktopModuleFunc};
