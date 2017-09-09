japetus_test.exe: japetus_test.o Graph.o Scope.o Functor.o FunctorImpl.o Functions.o Session.o
	g++ build/Graph.o build/Scope.o build/Functor.o build/FunctorImpl.o build/Functions.o build/Session.o build/japetus_test.o -o japetus_test.exe

japetus_test.o:
	g++ -c -g src/japetus_test.cpp -o build/japetus_test.o -std=c++11

Graph.o:
	g++ -c -g src/Graph.cpp -o build/Graph.o -std=c++11

Scope.o:
	g++ -c -g src/Scope.cpp -o build/Scope.o -std=c++11

Functor.o:
	g++ -c -g src/Functor.cpp -o build/Functor.o -std=c++11

FunctorImpl.o:
	g++ -c -g src/FunctorImpl.cpp -o build/FunctorImpl.o -std=c++11

Functions.o:
	g++ -c -g src/Functions.cpp -o build/Functions.o -std=c++11

Session.o:
	g++ -c -g src/Session.cpp -o build/Session.o -std=c++11

clean:
	rm build/*.o
	rm *.exe
