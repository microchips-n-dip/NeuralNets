NN: NN.o
	g++ NN_main.o -o NN.exe

NN.o:
	g++ -c NN_main.cpp -o NN_main.o -std=c++11

clean:
	rm *.o
	rm *.exe
