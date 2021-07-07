#include <unistd.h>
#include <sys/wait.h>
#include <string.h>
#include <iostream>

#include "network.h"
#include "misc.h"
#include "asyncmodules.h"

extern char * desktops;
extern char * windowname;

void loadModule(const char * modulepath, char * buffer, int size){
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
};
