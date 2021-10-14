#include <unistd.h>
#include <signal.h>
#include <cstring>
#include <cstdio>
#include <xcb/xcb.h>
#include <xcb/xcb_icccm.h>

#include "redraw.h"
#include "modules.h"

extern xcb_connection_t * dpy;
extern xcb_window_t root;

extern Bar mainbar;

AsyncModule windowModule{[](AsyncModule* self) {
	xcb_get_input_focus_reply_t* focused;
	xcb_icccm_get_text_property_reply_t itr;

	// zero out the windowname
	bzero(self->buf, self->size);

	// get focused window
	auto focusedcookie = xcb_get_input_focus(dpy);
	focused = xcb_get_input_focus_reply(dpy, focusedcookie, 0);

	// get window title
	xcb_generic_error_t * e;
	itr.name = 0;
	xcb_icccm_get_wm_name_reply(dpy, xcb_icccm_get_wm_name(dpy, focused->focus), &itr, &e);

	bzero(self->buf, 64);
	if(itr.name != 0) {
		snprintf(self->buf,
		itr.name_len < 64 ? itr.name_len + 1: 64
		, "%s", itr.name); 
	}

	// cleanup
	delete focused;
}, 64};

AsyncModule desktopModule{[](AsyncModule* self) {
	loadModuleFromFile("/home/asdf/.scripts/lemonbar/desktopmodule" , self->buf, 256);
	mainbar.redraw();
}, 256};
