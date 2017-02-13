//

#include "tensor.hpp"

int main(void)
{
    // Create a new tensor
    Tensor<double> A(3, 5, 5, 2);
    Tensor<double> B(4, 5, 5, 2, 6);
    
    printf("A.data[%i,%i,%i] = %lf\n",1,2,0,A.at(1,2,0));
    printf("B.data[%i,%i,%i,%i] = %lf\n",3,1,4,1,B.at({3,4,1,1}));
    
    A.assign({1,2,1},9.9);
    printf("A.data[%i,%i,%i] = %lf\n",1,2,1,A.at(1,2,1));
}
