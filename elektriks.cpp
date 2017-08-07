// Start with includes
// Standard headers
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// C-prefixed headers
#include <cmath>

// C++ specific headers
#include <vector>
#include <iostream>


// Now for constant values
// Mathematical constants
#define pi 3.14159265658979323 // Pi
#define e 2.7182818284590452353602874713527 // Euler's number

// Physical constants
#define ec 1.60217662e-19 // Elementaryu charge
#define na 6.022140857e+23 // Avogadro's constant (mol)
#define gR 8.3144598 // Gas constant (kg m^2 mol^-1 K^-1 s^-2)
#define bk 1.38064852e-23 // Boltzmann constant (J K^-1)


// Some calculations
// Diffusion coefficient
// The arguments:
// cDnaut is the diffusion coefficient at infinite temperature
// Ea is the activation energy
// T is the absolute temperature
double cDiff(double cDnaut, double Ea, double T)
{ return cDnaut * pow(e, -Ea/(bk*T)); }

// Saturation current
// The arguments:
// cDp is the diffusion coefficient for holes
// cDn is the diffusion coefficient for electrons
// ND is the donor concentration
// NA is the acceptor concentration
// ni is the intrinsic carrier concentration
// tp is the carrier lifetime of holes
// tn is the carrier lifetime of electrons
double _Is_(double cDp, double cDn, double ND, double NA, double ni, double tp, double tn, double A)
{
    // The first half for holes
    double Is_H = sqrt(cDp / tp) * (pow(ni, 2) / ND);
    
    // The second half for electrons
    // (This is the same as the first half :P)
    double Is_E = sqrt(cDn / tn) * (pow(ni, 2) / NA);
    
    // Now we return the sum of the two halves multiplied by the elementary charge and the cross sectional area
    return ec * A * (Is_H + Is_E);
}

double Is(double I, double V, double T)
{
    double VT = bk * (T / ec);
    std::cout << "Voltage temperature: " << VT << std::endl;
    
    
    // Calculating the intrinsic carrier concentration
    // Ns is a rough estimate of the number of states available per cubic centimeter
    double Ns = 1e+19;
    double Eg = 0.67; // Energy gap of germanium (in eV) at 273K
    long double ni = Ns * exp(-Eg / (2 * bk * T));
    std::cout << "Intrinsic carrier concentration: " << ni << std::endl;
    
    // Ideality factor
    double n = ni * exp((ec * V) / (2 * bk * T));
    std::cout << "Ideality: " << n << std::endl;
    
    
    double _Is = I / (exp(V / (n * VT)) - 1);
    return _Is;
}


// Main
int main(void)
{
    std::cout << "Boltzmann constant: " << bk << std::endl;

    // This test is to find the voltage output of a circuit
    // The test circuit uses and Op-Amp to calculate an exponent
    
    
    // The final voltage
    double R = 100;
    double T = 300000000000000001000.0;
    double Vout = -R * Is(0.1, 3.3, T);
    std::cout << Vout << std::endl;
}
