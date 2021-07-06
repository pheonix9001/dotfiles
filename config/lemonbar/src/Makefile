CC=g++ 
LIBS=-lxcb -lxcb-util -lxcb-icccm

%.o: %.cpp
	$(CC) -O3 -c $<

all: main.o asyncmodules.o helpers.o misc.o network.o
	$(CC) $^ $(LIBS) -o ../controllemonbar

clean:
	rm -rf *.o
