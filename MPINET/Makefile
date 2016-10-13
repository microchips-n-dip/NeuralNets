### Parallel neural net makefile ###

### Defaults
CPP=g++
# parallel_src=./MPINET
CFLAGS=-std=c++11 -Wall

### Optional settings based on MAKECMDGOALS
.PHONY: mpi
mpi:  mpinet
ifneq ($(filter mpi, $(MAKECMDGOALS) ),)
CPP:=mpiCC
LD:=mpiCC
CFLAGS += -Denv_mpi
endif

### Rules
mpinet: mpinet.hpp parallel.hpp
	$(CPP) $(CFLAGS) -c mpinet.cpp -o mpinet.o
	$(CPP) $(CFLAGS) mpinet.o -o mpinet
	@echo "Compiled successfully"

mpidistrib: parallel.hpp
	$(CPP) $(CFLAGS) -c mpidistrib.cpp -o mpidistrib.o
	$(CPP) $(CFLAGS) mpidistrib.o -o mpidistrib.exe

clean:
	rm *.o
	rm mpinet
