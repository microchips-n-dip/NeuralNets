#include "xnet.hpp"

#define c 299792458.0
#define G 6.67408e-11

std::vector<double> cplxE(double m, double r, double a)
{
    double v = sqrt(G * m * ((2.0 / r) - (1.0 / a)));
    double p = (m * v) / sqrt(1 - pow(v / c, 2));
    return {c * sqrt(pow(m * c, 2) + pow(p, 2)), p};
}

std::vector<std::vector<double>> sampleX()
{
    std::vector<std::vector<double>> R;
  
    
    R.push_back();
}

int main(void)
{
    std::vector<int> = {5, 6, 7, 7, 7, 7, 7, 4};
    XNET net = XNET(config, );
}
