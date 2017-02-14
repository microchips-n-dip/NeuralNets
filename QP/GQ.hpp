#ifndef __GQ_HPP

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <vector>
#include <complex>
#include <iostream>

// INCLUDE LIBRARIES IN C++ FILES WHEN USED (requires stdinclude) //
using namespace std;

double P(unsigned n, double x) {
    vector<double> p;
    p.resize(n+1);

    unsigned i;

    if(n >= 0) {
        p[0] = 1;
    }
    if(n >= 1) {
        p[1] = x;
    }

    for(i = 1; i < n; i++) {
        p[i+1] = (((2*i)+1)*x*p[i] - i*p[i-1]) / (i+1);
    }

    return(p[n]);
}

double Pprime(unsigned n, double x) {
    double h = 1e-4;
    return((P(n, x+h)-P(n, x-h))/(2*h));
}

double J(unsigned n, double x) {
    return(sqrt(pow(P(n, x), 2)));
}

double Jprime(unsigned n, double x) {
    double h = 1e-4;
    return((J(n, x+h)-J(n, x-h))/(2*h));
}

double Joptmin(unsigned n, double x) {
    double g = 0, Rg = 0, Eg = 0, dx = 0, Rdx = 0, Edx = 0;
    double rho = 0.95, epsilon = 1e-6, tol = 5e-8;

    unsigned t, maxiter = 100;
    while(J(n, x) > tol) {
        g = Jprime(n, x);

        Eg = rho * Eg + (1-rho) * pow(g, 2);
        Edx = rho * Edx + (1-rho) * pow(dx, 2);

        Rg = sqrt(Eg + epsilon);
        Rdx = sqrt(Edx + epsilon);

        dx = -(Rdx/Rg) * g;
        x += dx;
    }

    return(x);
}

vector<double> rootP(unsigned n) {
    vector<double> x;
    x.resize(n);

    unsigned i, o1, o2;

    if(n % 2 != 0) {
        x[0] = 0;
        o1 = 0; o2 = 1;
    } else {
        o1 = 1; o2 = 0;
    }

    for(i = 1; i < n+o1; i += 2) {
        x[i-o1] = -Joptmin(n, ((double)(i+o2)/(double)n)+0.1);
        x[i+1-o1] = -x[i-o1];
    }

    return(x);
}

std::vector<double> wGen(std::vector<double> x, int n)
{
	std::vector<double> w;
	for (int i = 0; i < n; i++)
		w.push_back(2/((1-pow(x[i], 2)) * pow(Pprime(n, x[i]), 2)));
	return w;
}

double GLQ(double (*f)(double), unsigned n, double a, double b) {
    vector<double> x = rootP(n);
    unsigned i;

	std::vector<double> w = wGen(x, n);
    double r = 0;

    for(i = 0; i < n; i++) {
        r += w[i]*f(0.5*(b-a)*x[i] + 0.5*(b+a));
    }

    return(0.5*(b-a)*r);
}

void vectout(vector<double> x) {
    unsigned i;
    cout << "{ ";
    for(i = 0; i < x.size(); i++) {
        (i == x.size()-1) ? (cout << x[i] << " }\n") : (cout << x[i] << ", ");
    }
}

std::complex<double> cplxGLQ(std::complex<double> (*f)(std::complex<double>), unsigned n, double a, double b)
{
    vector<double> x = rootP(n);

    double w;
    double r = 0;
    double r1 = 0;
    double r2 = 0;

    for(int i = 0; i < n; i++)
    {
        w = 2/((1-pow(x[i], 2)) * pow(Pprime(n, x[i]), 2));
        r += w*f(std::complex<double>(0.5*(b-a)*x[i] + 0.5*(b+a), 0)).real();
    }

    r1 = 0.5 * (b - a) * r;
    r = 0;

    for(int i = 0; i < n; i++)
    {
        w = 2/((1-pow(x[i], 2)) * pow(Pprime(n, x[i]), 2));
        r += w*f(std::complex<double>(0.5*(b-a)*x[i] + 0.5*(b+a), 0)).imag();
    }

    r2 = 0.5 * (b - a) * r;
    r = 0;

    return std::complex<double>(r1, r2);
}

#define __GQ_HPP
#endif