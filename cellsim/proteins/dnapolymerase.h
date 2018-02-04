#ifndef CELLSIM_DNA_POLYMERASE_H
#define CELLSIM_DNA_POLYMERASE_H

#include <vector>

#include "cellsim/core/status.h"
#include "cellsim/core/valid_iterator.h"
#include "cellsim/dna/dna.h"
#include "cellsim/proteins/protein_base.h"

namespace cellsim {

struct DNAPolymerase :
  public Protein
{
  Status Bind(DNA* bdna);
  Status Unbind();
  void ResetWorkingDNA(DNA* w_dna);
  DNA* ReleaseDNA();
  
  Status CopyDNA();
  
  DNA* transcribed_dna;
  
  DNA* working_dna;
  DNA* src;
	
	virtual void FetchKernelRunner(KernelRunHelper** kernel_runner);
};

}

#endif
