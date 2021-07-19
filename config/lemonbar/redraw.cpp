#include <unistd.h>
#include <sys/wait.h>
#include <string.h>
#include <iostream>
#include <vector>

#include "network.h"
#include "misc.h"
#include "asyncmodules.h"
#include "redraw.h"

extern AsyncModule windowModule;
extern AsyncModule desktopModule;

std::vector<Module> rmodules = {
	{TempModule}, {NetworkModule}
};

void loadModuleFromFile(const char* modulepath, char* buffer, int size) {
  int output[2];
  pipe(output);

  int pid = fork();
  if(pid == 0){
    dup2(output[1], 1);
    execlp("sh", "sh", modulepath);
  }
  wait(0);

  bzero(buffer, size);
  read(output[0], buffer, size);
  close(output[0]);
  close(output[1]);
}

void redraw(uv_timer_t* handle) {
	std::cout << " " << desktopModule.buf << " " << windowModule.buf;

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
