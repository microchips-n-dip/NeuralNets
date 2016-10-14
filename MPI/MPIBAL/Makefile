### Parallel neural net makefile ###

### Defaults
CPP=g++
# parallel_src=./MPI/MPIBAL
CFLAGS=-std=c++11 -Wall

### Optional settings based on MAKECMDGOALS
.PHONY: mpi
mpi:  mpibal
ifneq ($(filter mpi, $(MAKECMDGOALS) ),)
CPP:=mpiCC
LD:=mpiCC
CFLAGS += -Denv_mpi
endif

### Rules
mpibal: parallel.hpp toroid.hpp
	$(CPP) $(CFLAGS) -c mpibal.cpp -o mpibal.o
	$(CPP) $(CFLAGS) mpibal.o -o mpibal
	@echo "Compiled successfully"

clean:
	rm *.o
	rm mpibal
