#include <functional>
#include <iostream>

#include <boost/thread/thread.hpp>

void _kernel()
{
	std::cout << "Kernel thread running\n";
}

int main(void)
{
	std::function<void()> kernel(_kernel);
	boost::thread kernel_thread(kernel);
}