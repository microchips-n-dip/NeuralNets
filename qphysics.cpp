// Start with includes
// Standard includes
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// C-prefixed includes
#include <cmath>

// C++ specific includes
#include <vector>
#include <iostream>


// Constants
// Mathematical constants
#define pi 3.14159265358979323 // Pi
#define e 2.7182818284590452353602874713527 // Euler's number

// Physical constants
#define ph 6.62607004e-34 // Planck constant


// Delta-x given delta-p
double dx$(double dp)
{
    return ph / (4 * pi * dp);
}

// Main
int main(void)
{
    std::cout << "The uncertainty in position is greater than or equal to " << dx$(1) << " given that there is a momentum of 1\n";
}
