tensor_test.exe: tensor_test.o
	g++ tensor_test.o -o tensor_test.exe

tensor_test.o:
	g++ -fdiagnostics-color -c -g tensor_test.cpp -o tensor_test.o -std=c++11

clean:
	rm *.o
	rm *.exe
