#include <unistd.h>
#include <sys/wait.h>
#include <string.h>
#include <iostream>
#include <vector>

#include "network.h"
#include "misc.h"
#include "asyncmodules.h"
#include "helpers.h"

extern char * desktops;
extern char * windowname;

std::vector<Module> rmodules = {
	{TempModule}, {NetworkModule}
};

Module::Module(void (*callback)()) {
	this->draw = callback;
}

void loadModuleFromFile(const char * modulepath, char * buffer, int size){
  int output[2];
  pipe(output);

  int pid = fork();
  if(pid == 0){
    dup2(output[1], 1);
    execlp("bash", "bash", modulepath);
  }
  wait(0);

  memset(buffer, 0, size);
  read(output[0], buffer, size);
  close(output[0]);
  close(output[1]);
  return;
}

void redraw() {
	std::cout <<
		"%{A:dmenu_run -p 'run\\:' -i -F:} %{F#88C0D0}\uf303%{F-}%{A} "
		<< desktops << " " << windowname;

	// center aligned modules
	std::cout << "%{c}";
	TimeModule();

	// right aligned modules
	std::cout << "%{r}";
	for(Module mod: rmodules) {
		mod.draw();
	}
	std::cout << "\n";
	std::cout.flush();
};
