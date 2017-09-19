japetus_test.exe: japetus_test.o Graph.o Scope.o Functor.o FunctorImpl.o Session.o
	g++ build/Graph.o build/Scope.o build/Functor.o build/FunctorImpl.o build/Session.o build/japetus_test.o -o japetus_test.exe

japetus_test.o: dir_build
	g++ -fdiagnostics-color -c -g src/japetus_test.cpp -o build/japetus_test.o -std=c++11

Graph.o: dir_build
	g++ -fdiagnostics-color -c -g src/Graph.cpp -o build/Graph.o -std=c++11

Scope.o: dir_build
	g++ -fdiagnostics-color -c -g src/Scope.cpp -o build/Scope.o -std=c++11

Functor.o: dir_build
	g++ -fdiagnostics-color -c -g src/Functor.cpp -o build/Functor.o -std=c++11

FunctorImpl.o: dir_build
	g++ -fdiagnostics-color -c -g src/FunctorImpl.cpp -o build/FunctorImpl.o -std=c++11

Session.o: dir_build
	g++ -fdiagnostics-color -c -g src/Session.cpp -o build/Session.o -std=c++11

dir_build:
	mkdir -p build

clean:
	rm build/*.o
	rm *.exe
