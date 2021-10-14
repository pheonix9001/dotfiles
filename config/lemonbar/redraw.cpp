#include <unistd.h>
#include <sys/wait.h>
#include <string.h>
#include <iostream>
#include <vector>

#include "network.h"
#include "misc.h"
#include "moduledefs.h"
#include "redraw.h"

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
