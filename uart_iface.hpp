#include <unistd.h>
#include <fcntl.h>
#include <termios.h>


int uart0_filestream = -1;
uart0_filestream = open("/dev/ttyAMA0", O_RDWR | O_NOCTTY | O_NDELAY);
if(uart0_filestream == -1) printf("Error: UART interface failed!\n");

struct termios options;
tcattr(uart0_filestream, &options);
options.c_cflag = B9600 | CS8 | CLOCAL | CREAD;
options.c_iflag = IGNPAR;
options.c_oflag = 0;
options.c_lflag = 0;
tcflush(uart0_filestream, TCIFLUSH);
tcsetattr(uart0_filestream, TCSANOW, &options);


void tx(void *tx_buffer, unsigned int tx_buffer_size)
{
    if(uart0_filestream != -1) {
	int count = write(uart0_filestream, tx_buffer, tx_buffer_size);
	if(count < 0) printf("Error writing to stream! UART TX error!\n");
    }
}

void rx()
