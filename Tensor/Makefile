CPP := g++
CFLAGS := "-std=c++11"


tensor: tensor.o
	$(CPP) tensor.o -o tensor
	@echo "Compiled successfully."

tensor.o: tensor.hpp
	$(CPP) $(CFLAGS) -c tensor.cpp -o tensor.o

ca:
	rm *.o
	rm tensor

clean:
	rm *.o
