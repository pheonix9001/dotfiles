#ifndef REDRAW_H
#define REDRAW_H

#include <iostream>
#include <uv.h>

void loadModuleFromFile(const char *, char *, int);
void redraw(uv_timer_t *handle);

// struct to store modules
class Module {
	public:
		void (*draw)();
		Module(void (*_draw)()) : draw(_draw){};
};

// struct to store async modules
class AsyncModule {
	protected:
		void (*draw)(uv_async_t *);

	public:
		char *buf;
		uv_async_t async;

		AsyncModule(void (*draw)(uv_async_t *), size_t size) {
			this->draw = draw;
			buf = new char[size];

			uv_async_init(uv_default_loop(), &async, this->draw);
		}

		~AsyncModule() {
			delete buf;
		}
};

#endif /* ifndef REDRAW_H */
