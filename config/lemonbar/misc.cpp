#include <stdio.h>
#include <time.h>

#include <string.h>
#include <unistd.h>
#include <iostream>
#include <string>

#include "redraw.h"

time_t rawtime;
tm timestruct;
int temperature_fd;

void TempModule() {
	char buf[16];
	long temp;
	bool fg_isblack;
	std::string bg = "#3B4252";

  lseek(temperature_fd, 0, SEEK_SET);
	read(temperature_fd, buf, 16);
	temp = atol(buf);

	if(temp >= 45000) {
		bg = "#EBCB8B";
		fg_isblack = true;
	} else if(temp > 65000) {
		bg = "#BF616A";
	}
	

	std::cout << "%{F" << bg << '}'
		<< "\ue0b2" 
		<< "%{B" << bg << '}' <<
		"%{F-}" " "
	<< "%{A:st -e htop:}";

	// set foreground
	const char * fg = fg_isblack ? "%{F#2E3440" : "%{F-}";
	std::cout << fg;

	std::cout << "%{B" << bg << '}' << temp / 1000;

	std::cout << "\xc2\xb0 C" " " "%{A}" "%{F-}";
}
void TimeModule(){
  rawtime = time(0);
  timestruct = *localtime(&rawtime);

  printf("%%{A:st -e calcurse:}" "%02d:%02d:%02d" "%%{A}",
      timestruct.tm_hour ,
      timestruct.tm_min,
      timestruct.tm_sec
      );
}
