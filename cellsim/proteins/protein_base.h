#ifndef CELLSIM_PROTEIN_BASE_H
#define CELLSIM_PROTEIN_BASE_H

#include <exception>

#include "cellsim/dna/dna.h"

namespace cellsim {

struct KernelRunHelper;

struct Protein {
  virtual void FetchKernelRunner(KernelRunHelper** kernel_runner);
};

}

#endif