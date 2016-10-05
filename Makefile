NN: NN.o
	g++ NN.o -o NN.exe

NN.o:
	g++ -c NN.cpp -o NN.o -std=c++11

clean:
	rm *.o
	rm *.exe

gpull:
	git pull https://github.com/microchips-n-dip/NeuralNets
