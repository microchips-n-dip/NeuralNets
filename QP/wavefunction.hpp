#ifndef __WAVEFUNCTION_HPP

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <vector>
#include <complex>
#include <limits>

#include "GQ.hpp"

#define N 5
#define c 299792458.0
#define hbar 1.0545718e-34

const std::vector<double> u = rootP(N);
const std::vector<double> w = wGen(u, N);
const std::complex<double> imaginary = std::complex<double>(0, 1);

class Wave1D
{
  private:
	// Wave information
	double omega;
	double k;
	double norm = 1;
	// Position information
	double x;
	double x0;
	double t;
	
	std::complex<double> Q;
	
  public:
	std::complex<double> semiwave(double kprime)
	{
		return exp(std::complex<double>(0, kprime * (x - x0)));
	}
	
	void wave()
	{
		// K is supposed to be infinite, but we need to use a limit
		double K = 1e+250;
		/*double b = K;
		double a = -K;
		
		// Integration
		double r1 = 0;
		double r2 = 0;
		double R = 0;
		
		for(int i = 0; i < N; i++)
		{
			r1 += w[i]*semiwave(0.5*(b-a)*u[i] + 0.5*(b+a)).real();
			r2 += w[i]*semiwave(0.5*(b-a)*u[i] + 0.5*(b+a)).imag();
		}

		R = 0.125 * acos(-1) * (r1 + r2);*/
		
		// Final wave at (x - x0)
		double R = sin(K * (x - x0)) / (acos(-1) * (x - x0));
		Q = norm * R * exp(std::complex<double>(0, -omega * t));
	}
	
	void schrodingerCheck()
	{
		// Momentum calculation
		
		double perturb = 1e-4;
		double init = x0;
		x = init + perturb;
		wave();
		std::complex<double> loss1 = Q;
		x = init - perturb;
		wave();
		std::complex<double> loss2 = Q;
		std::complex<double> deriv = (loss1 - loss2) / (2 * perturb);
		x = init;
		wave();
		printf("Derivative is %f + %fi\n", Q.real(), Q.imag());
		double p = -(imaginary * hbar * deriv / Q).real();
		
		//double p = hbar * k;
		printf("Found momentum to be %f*10^(-50) for Schrodinger check\n", p*pow(10, 50));
		
		// Energy calculation
		double E = hbar * omega;
		printf("Found energy to be %f for Schrodinger check\n", E);
		
		if (p * c > E)
		{
			printf("Fatal error: Schrodinger equation not respected by a wavefunction!\n");
			printf("Please go back and carefully review your waves...\n");
			printf("Terminating...\n");
			exit(-1);
		}
	}
	
	double P(double a, double b, double _t)
	{
		t = _t;
		
		double r = 0;
		double R = 0;
		
		for(int i = 0; i < N; i++) {
			x = 0.5*(b-a)*u[i] + 0.5*(b+a);
			wave();
			r += w[i] * (Q*std::conj(Q)).real();
		}

		R = 0.5*(b-a)*r;
		
		return R;
	}
	
	Wave1D(double _omega, double _k, double _x0)
	{
		omega = _omega;
		k = _k;
		x0 = _x0;
		
		schrodingerCheck();
		
		double a = P(-1e+250, 1e+250, 0);
		norm = sqrt(1 / a);
	}
};

#define __WAVEFUNCTION_HPP
#endif
