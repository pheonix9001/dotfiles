#include "modules.h"

#include <iostream>
#include <vector>

extern Bar mainbar;

//
// FunctionModule
//
FunctionModule::FunctionModule(Module_cb _call) {
	this->call = _call;
}

void FunctionModule::draw() {
	this->call(this);
}

//
// AsyncModules
//
AsyncModule::AsyncModule(void (*callback)(AsyncModule*), size_t size) {
	this->call = (Module_cb)callback;
	this->size = size;
	this->buf = new char[size];
}

AsyncModule::~AsyncModule() {
	delete[] buf;
}

void AsyncModule::update() {
	this->call(this);

	mainbar.redraw();
}

void AsyncModule::draw() {
	std::cout << this->buf;
}

//
// TextModule
//
void TextModule::draw() {
	std::cout << this->text;
}

//
// Bar
//

Bar::Bar() {}

void Bar::redraw() {
	for(Module* mod: modules) {
		mod->draw();
	}
	std::cout << "\n";
	std::cout.flush();
}
