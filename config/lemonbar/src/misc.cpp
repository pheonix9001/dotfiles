#include <stdio.h>
#include <time.h>

#include <string.h>
#include <unistd.h>
#include <iostream>

#include "helpers.h"

time_t rawtime;
tm timestruct;
int temperature_fd;

void TempModule() {
	char buf[16];
	long temp;

  lseek(temperature_fd, 0, SEEK_SET);
	read(temperature_fd, buf, 16);
	temp = atol(buf);

	MODULE_START;
	if(temp >= 45000) {
		std::cout << "%{F#EBCB8B}";
	} else if(temp > 65000) {
		std::cout << "%{F#BF616A}";
	}
	

	std::cout << temp / 1000.0;

	std::cout << "\xc2\xb0" "C" "%{F-}";
	MODULE_END;
}
void TimeModule(){
  rawtime = time(0);
  timestruct = *localtime(&rawtime);

  printf("%02d:%02d:%02d",
      timestruct.tm_hour ,
      timestruct.tm_min,
      timestruct.tm_sec
      );
}
