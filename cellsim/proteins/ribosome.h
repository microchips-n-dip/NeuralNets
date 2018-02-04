#ifndef CELLSIM_RIBOSOME_H
#define CELLSIM_RIBOSOME_H

#include <vector>

#include "cellsim/core/status.h"
#include "cellsim/core/valid_iterator.h"
#include "cellsim/dna/dna.h"
#include "cellsim/rna/rna.h"
#include "cellsim/proteins/protein_base.h"
#include "cellsim/proteins/dnapolymerase.h"
#include "cellsim/proteins/rnapolymerase.h"
#include "cellsim/proteins/ribosome.h"

namespace cellsim {

struct RibosomeComplex :
  public Protein
{
  Status Bind();
  Status Unbind();
  void ResetWorkingRNA(RNA* w_rna);
  Protein* ReleaseProtein();
  
  const DNACode FetchCode() const
	{ return code; }
  Status Translate();
  
  RibosomeComplex();
  
  Protein* translated_protein;
  
  RNA* working_rna;
  DNACode code;
	
	virtual void FetchKernelRunner(KernelRunHelper** kernel_runner);
};

}

#endif
