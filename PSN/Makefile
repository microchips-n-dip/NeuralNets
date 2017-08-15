psn.exe: nodeon.o connecton.o network.o particle_swarm.o psn.o
	g++ Network/nodeon.o Network/connecton.o Network/network.o Network/particle_swarm.o psn.o -o psn.exe -std=c++11

nodeon.o:
	g++ -c Network/nodeon.cpp -o Network/nodeon.o -std=c++11

connecton.o:
	g++ -c Network/connecton.cpp -o Network/connecton.o -std=c++11

network.o:
	g++ -c Network/network.cpp -o Network/network.o -std=c++11

particle_swarm.o:
	g++ -c Network/particle_swarm.cpp -o Network/particle_swarm.o -std=c++11

psn.o:
	g++ -c psn.cpp -o psn.o -std=c++11

clean:
	rm *.o
	rm Network/*.o
	rm *.exe
