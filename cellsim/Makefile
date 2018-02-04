CC = g++
IFLAGS = -I/c/local/boost_1_66_0
LFLAGS = -L/c/local/boost_1_66_0/stage/lib -lboost_system-mgw72-x64-1_66
CFLAGS = -iquote../ -std=c++11 -g -static-libgcc -static-libstdc++
GFLAGS = -static-libgcc -static-libstdc++


main.exe: main.o status.o worldstate.o dna.o rnapolymerase.o dnapolymerase.o ribosome.o kernel.o
	$(CC) $(GFLAGS) build/main.o build/status.o build/worldstate.o build/dna.o build/dnapolymerase.o build/rnapolymerase.o build/ribosome.o build/kernel.o -o main.exe

main.o:
	$(CC) $(CFLAGS) -c main.cpp -o build/main.o

status.o:
	$(CC) $(CFLAGS) -c core/status.cpp -o build/status.o

worldstate.o:
	$(CC) $(CFLAGS) -c core/worldstate.cpp -o build/worldstate.o

dna.o:
	$(CC) $(CFLAGS) -c dna/dna.cpp -o build/dna.o
	
rnapolymerase.o:
	$(CC) $(CFLAGS) -c proteins/rnapolymerase.cpp -o build/rnapolymerase.o
	
dnapolymerase.o:
	$(CC) $(CFLAGS) -c proteins/dnapolymerase.cpp -o build/dnapolymerase.o
	
ribosome.o:
	$(CC) $(CFLAGS) -c proteins/ribosome.cpp -o build/ribosome.o
  
kernel.o:
	$(CC) $(CFLAGS) -c kernel/kernel.cpp -o build/kernel.o

clean:
	rm build/*.o
	rm *.exe
	
