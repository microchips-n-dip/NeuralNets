#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <complex>
#include <vector>
#include <iostream>

#include "GQ.hpp"
#include "wavefunction.hpp"

int main(void)
{
	Wave1D y1 = Wave1D(1.0 / hbar, 1.0 / (c * hbar), 0.0);
	printf("P = %f\n", y1.P(-10.0, 10.0, 0));
}