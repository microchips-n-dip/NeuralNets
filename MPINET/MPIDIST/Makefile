### Parallel neural net makefile ###

### Defaults
CPP=g++
# parallel_src=./MPINET/MPIDIST
CFLAGS=-std=c++11 -Wall

### Optional settings based on MAKECMDGOALS
.PHONY: mpi
mpi:  mpidistrib
ifneq ($(filter mpi, $(MAKECMDGOALS) ),)
CPP:=mpiCC
LD:=mpiCC
CFLAGS += -Denv_mpi
endif

### Rules
mpidistrib: ../parallel.hpp
	$(CPP) $(CFLAGS) -c mpidistrib.cpp -o mpidistrib.o
	$(CPP) $(CFLAGS) mpidistrib.o -o mpidistrib
	@echo "Compiled successfully"

clean:
	rm *.o
	rm mpidistrib
