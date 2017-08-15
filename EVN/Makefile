evn.exe: nodeon.o connecton.o network.o evn.o
	g++ Network/nodeon.o Network/connecton.o Network/network.o evn.o -o evn.exe -std=c++11

nodeon.o:
	g++ -c Network/nodeon.cpp -o Network/nodeon.o -std=c++11

connecton.o:
	g++ -c Network/connecton.cpp -o Network/connecton.o -std=c++11

network.o:
	g++ -c Network/network.cpp -o Network/network.o -std=c++11

evn.o:
	g++ -c evn.cpp -o evn.o -std=c++11

clean:
	rm *.o
	rm Network/*.o
	rm *.exe
