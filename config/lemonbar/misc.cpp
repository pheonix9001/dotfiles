#include <stdio.h>
#include <time.h>

#include <string.h>
#include <unistd.h>
#include <iostream>
#include <alsa/asoundlib.h>
#include <alsa/mixer.h>
#include <string>

#include "redraw.h"

int temperature_fd;

void tempModule() {
	char buf[16];
	long temp;
	bool fg_isblack;
	const char* bg = "#3b4252";

  lseek(temperature_fd, 0, SEEK_SET);
	read(temperature_fd, buf, 16);
	temp = atol(buf);

	if(temp >= 45000) {
		bg = "#ebcb8b";
		fg_isblack = true;
	} else if(temp >= 65000) {
		bg = "#bf616a";
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
	const char * fg = fg_isblack ? "%{F#2e3440}" : "%{F-}";
	std::cout << fg;

	std::cout << temp / 1000;

	std::cout << "\xc2\xb0 C %{A}%{F-}";
}

time_t rawtime;
tm timestruct;
void timeModule() {
  rawtime = time(0);
  timestruct = *localtime(&rawtime);

  printf("%%{A:st -e calcurse:}" "%02d:%02d:%02d" "%%{A}",
      timestruct.tm_hour ,
      timestruct.tm_min,
      timestruct.tm_sec
      );
}

void audioModule() {
	long min, max;
	snd_mixer_t* mixer;
	snd_mixer_selem_id_t* sid;

	const char* const card = "default";
	const char* const selem_name = "Master";

	snd_mixer_open(&mixer, 0);
	snd_mixer_attach(mixer, card);
	snd_mixer_selem_register(mixer, 0, 0);

	snd_mixer_selem_id_alloca(&sid);
	snd_mixer_selem_id_set_index(sid, 0);
	snd_mixer_selem_id_set_name(sid, selem_name);

	auto* elem = snd_mixer_find_selem(mixer, sid);

	snd_mixer_selem_get_playback_volume_range(elem, &min, &max);

	snd_mixer_close(mixer);
}
