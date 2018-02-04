#include <iostream>

namespace cellsim {

struct KernelRunHelper {
  struct AgnosticKernel {
    virtual ~AgnosticKernel() { }
    virtual void run(WorldState* world, Protein* p) { }
  };
  
  template <typename T>
  struct Kernel : public AgnosticKernel {
    virtual ~Kernel() { }
    virtual void run(WorldState* world, Protein* p);
  };
  
  KernelRunHelper() { }
  ~KernelRunHelper() {
    if (kernel) {
      delete kernel;
    }
  }
  
  template <typename T>
  void create_kernel() {
    kernel = new Kernel<T>;
  }
  
  AgnosticKernel* kernel;
  
  void operator()(WorldState* world, Protein* arg);
};

}