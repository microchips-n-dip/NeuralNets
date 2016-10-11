### Neural net makefile ###

### Defaults
CPP=g++
parallel_src=./MPINET
CFLAGS=-std=c++11 -Wall

### Optional settings based on MAKECMDGOALS
.PHONY: mpi
mpi:  mpinet NN
ifneq ($(filter mpi, $(MAKECMDGOALS) ),)
CPP:=mpiCC
LD:=mpiCC
CFLAGS += -Denv_mpi
endif

### Rules
mpinet: $(parallel_src)/mpinet.hpp
	$(CPP) $(CFLAGS) -c $(parallel_src)/mpinet.cpp -o mpinet.o

NN: NN.o
	$(CPP) NN.o -o NN.exe
	@echo "Compiled successfully."

NN.o:
	$(CPP) $(CFLAGS) -c NN.cpp -o NN.o

clean:
	rm *.o
	rm *.exe

gpull:
	git pull https://github.com/microchips-n-dip/NeuralNets
