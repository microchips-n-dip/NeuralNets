# ### Neural net makefile ###

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
