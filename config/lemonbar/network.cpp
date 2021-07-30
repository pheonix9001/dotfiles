#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include <iostream>

int rx_bytes_fd, tx_bytes_fd;

static int rx_bytes, tx_bytes;
static int rx_prev_bytes, tx_prev_bytes;
static char rx_bytes_str[32], tx_bytes_str[32];

void NetworkModule(){
  lseek(rx_bytes_fd, 0, SEEK_SET);
  lseek(tx_bytes_fd, 0, SEEK_SET);

  read(rx_bytes_fd, rx_bytes_str, 32);
  read(tx_bytes_fd, tx_bytes_str, 32);

  rx_bytes = atoi(rx_bytes_str);
  tx_bytes = atoi(tx_bytes_str);

	std::cout << "%{F#81a1c1}" "\ue0b2" "%{B-}" "%{R}";
  printf("\uf544 %.2fK", (rx_bytes - rx_prev_bytes) / 1000.0);
	std::cout << "\ue0b3"
	<< "%{B#81a1c1}";
  printf("\uf55c %.2fK", (tx_bytes - tx_prev_bytes) / 1000.0);

  rx_prev_bytes = rx_bytes;
  tx_prev_bytes = tx_bytes;

	std::cout << " " "%{B-}" "%{F-}";
}
