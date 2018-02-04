#ifndef CELLSIM_RNA_H
#define CELLSIM_RNA_H

#include <vector>

#include "cellsim/core/status.h"
#include "cellsim/dna/dna.h"

namespace cellsim {

struct RNA
{
  void SetCode(DNACode d) { code = d; }
  DNACode FetchCode() { return code; }
  
  DNACode code;
};

}

#endif
