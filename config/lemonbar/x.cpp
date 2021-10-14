#include <cstring>
#include <iostream>
#include <memory>
#include <xcb/xcb.h>
#include <stdio.h>

#include "moduledefs.h"
#include "redraw.h"
#include "modules.h"

xcb_connection_t *dpy = xcb_connect(0, 0);
xcb_window_t root = xcb_setup_roots_iterator(xcb_get_setup(dpy)).data->root;

extern AsyncModule windowModule;
extern AsyncModule desktopModule;

// gets atom from atom name
static xcb_atom_t my_intern_atom(const char *name) {
  xcb_atom_t result{0};
  xcb_intern_atom_reply_t *reply;

  reply = xcb_intern_atom_reply(
      dpy, xcb_intern_atom(dpy, false, strlen(name), name), 0);

  if (!reply) {
    delete reply;
    return -1;
  }

  result = reply->atom;
  delete reply;
  return result;
}

// TODO: fix this
static void *
get_atom_value(xcb_window_t win, xcb_atom_t prop,
                            int& len) {
  void *ret;
	xcb_generic_error_t * err;

  auto cookie = xcb_get_property(dpy, false, win, prop, XCB_ATOM_ANY, 0, 0);
  auto *reply = xcb_get_property_reply(dpy, cookie, &err);

	if (!reply) return 0;
	xcb_flush(dpy);

  len = xcb_get_property_value_length(reply);
  if (len == 0) {
    std::cerr << "controllemonbar: Error retrieving value in atom " << prop
              << std::endl;
		delete reply;
    return 0;
  }

  ret = xcb_get_property_value(reply);

	delete reply;
  return ret;
}

// handles X events
void eventHandlerFunc() {
  uint32_t values[] = {XCB_EVENT_MASK_PROPERTY_CHANGE};

  // listen for property change events
  xcb_change_window_attributes(dpy, root, XCB_CW_EVENT_MASK, values);
  xcb_flush(dpy);

  // get atoms
  xcb_atom_t active_win = my_intern_atom("_NET_ACTIVE_WINDOW");
  xcb_atom_t active_desktop = my_intern_atom("_NET_CURRENT_DESKTOP");

  xcb_generic_event_t *ev;
  while ((ev = xcb_wait_for_event(dpy))) {
    switch (ev->response_type & 0x7f) {
    case XCB_PROPERTY_NOTIFY: {
      auto e = (xcb_property_notify_event_t *)ev;

				if (e->atom == active_win) {
					windowModule.update();
				} else if (e->atom == active_desktop) {
					desktopModule.update();
				}
				break;
			}
			default:
				// do nothing
				break;
		}

		delete ev;
	}
}
