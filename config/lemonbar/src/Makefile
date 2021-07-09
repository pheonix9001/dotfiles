CC=g++ 
LIBS=-lxcb -lxcb-util -lxcb-icccm -lpthread -std=c++14

%.o: %.cpp
	$(CC) -O3 -c $<

all: main.o asyncmodules.o helpers.o misc.o network.o x.o
	$(CC) $^ $(LIBS) -o ../controllemonbar

clean:
	rm -rf *.o
