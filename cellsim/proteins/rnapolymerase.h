#ifndef CELLSIM_RNA_POLYMERASE_H
#define CELLSIM_RNA_POLYMERASE_H

#include <vector>

#include "cellsim/core/status.h"
#include "cellsim/core/valid_iterator.h"
#include "cellsim/proteins/protein_base.h"
#include "cellsim/proteins/dnapolymerase.h"
#include "cellsim/proteins/rnapolymerase.h"
#include "cellsim/proteins/ribosome.h"

namespace cellsim {

struct RNAPolymerase :
  public Protein
{
  Status Bind();
  Status Unbind();
  void ResetWorkingDNA(DNA* w_dna);
  RNA* ReleaseRNA();
  
  Status TranscribeRNA();
  
  RNAPolymerase();
  
  RNA* transcribed_rna;
  
  DNA* working_dna;
  ValidIterator<DNAStrand*> strand_it;
  DNAStrand* strand;
	
	virtual void FetchKernelRunner(KernelRunHelper** kernel_runner);
};

}

#endif
