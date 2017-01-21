#include "xnet.hpp"

#define c 299792458.0
#define G 6.67408e-11

std::vector<double> cplxE(double m, double r, double a, double sr)
{
    double v = sqrt(G * m * ((2.0 / r) - (1.0 / a)));
    double p = (m * v) / sqrt(1 - pow(v / c, 2));
    return {c * sqrt(pow(m * c, 2) + pow(p, 2)), p, sr};
}

std::vector<std::vector<double>> sampleX()
{
    std::vector<std::vector<double>> R;
  
    // Mercury sample
    
    // Venus sample
    
    // Earth sample
    R.push_back();
    
    // Mars sample
    
    // Jupiter sample
    
    // Saturn sample
    
    // Uranus sample
    
    // Neptune sample
    
}

std::vector<std::vector<double>> sampleY()
{
    std::vector<std::vector<double>> R;
    
    // Mercury sample
    
    // Venus sample
    
    // Earth sample
    
    // Mars sample
    
    // Jupiter sample
    
    // Saturn sample
    
    // Uranus sample
    
    // Neptune sample
    
}

int main(void)
{
    std::vector<int> = {5, 6, 7, 7, 7, 7, 7, 4};
    XNET net = XNET(config, );
}
