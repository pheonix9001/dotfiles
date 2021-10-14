#include <string>
#include <vector>
#include <chrono>

class Module;
using Module_cb = void(*)(Module* self);

class Module {
private:
public:
	virtual void draw()=0;
	Module(){};
};

class FunctionModule: Module {
	private:
	Module_cb call;

	public:
	void draw();
	FunctionModule(Module_cb);
};

class AsyncModule: protected Module {
	private:
	Module_cb call;

	public:
	size_t size;
	char * buf;

	virtual void draw();
	virtual void update();

	AsyncModule(void (*callback)(AsyncModule*), size_t size);
	~AsyncModule();
};

class TextModule: protected Module {
	private:
	char * const text;

	public:
	virtual void draw();
	TextModule(const char* text) : text((char* const)text) {};
};

class Bar {
	public:
	std::vector<Module*> modules;
	void redraw();

	Bar();
};
