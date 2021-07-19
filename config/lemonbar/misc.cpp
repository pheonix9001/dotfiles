#include <stdio.h>
#include <time.h>

#include <string.h>
#include <unistd.h>
#include <iostream>
#include <string>

#include "redraw.h"

int temperature_fd;

void TempModule() {
	char buf[16];
	long temp;
	bool fg_isblack;
	const char* bg = "#3B4252";

  lseek(temperature_fd, 0, SEEK_SET);
	read(temperature_fd, buf, 16);
	temp = atol(buf);

	if(temp >= 45000) {
		bg = "#EBCB8B";
		fg_isblack = true;
	} else if(temp >= 65000) {
		bg = "#BF616A";
		fg_isblack = true;
	} else {
		fg_isblack = false;
	}
	

	// Powerline is cool
	std::cout << "%{F" << bg << '}'
		<< "\ue0b2" <<
		"%{R}"
	<< "%{A:st -e htop:}" << ' ';

	// set foreground
	const char * fg = fg_isblack ? "%{F#2E3440}" : "%{F-}";
	std::cout << fg;

	std::cout << temp / 1000;

	std::cout << "\xc2\xb0 C %{A}%{F-}";
}

time_t rawtime;
tm timestruct;
void TimeModule(){
  rawtime = time(0);
  timestruct = *localtime(&rawtime);

  printf("%%{A:st -e calcurse:}" "%02d:%02d:%02d" "%%{A}",
      timestruct.tm_hour ,
      timestruct.tm_min,
      timestruct.tm_sec
      );
}
