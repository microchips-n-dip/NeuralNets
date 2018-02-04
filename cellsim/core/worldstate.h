#ifndef CELLSIM_WORLDSTATE_H
#define CELLSIM_WORLDSTATE_H

#include <vector>
#include <iostream>
#include <functional>
#include <queue>
//#include <boost/thread/thread.hpp>

#include "cellsim/core/status.h"
#include "cellsim/core/valid_iterator.h"
#include "cellsim/dna/dna.h"
#include "cellsim/rna/rna.h"
#include "cellsim/proteins/protein_base.h"
#include "cellsim/proteins/dnapolymerase.h"
#include "cellsim/proteins/rnapolymerase.h"
#include "cellsim/proteins/ribosome.h"

namespace cellsim {

struct WorldState
{
  void Run();
  void reset();
  WorldState();
  
  void AddDNA(DNA* dna);
  void AddRNA(RNA* rna);
  void AddProtein(Protein* protein);
  
  unsigned int GetDNASize() { return dna_.size(); }
  unsigned int GetRNASize() { return rna_.size(); }  
  unsigned int GetProteinsSize() { return proteins_.size(); }
  
  void EnqueueDNA(DNA* dna);
  void EnqueueRNA(RNA* rna);
  void EnqueueProtein(Protein* protein);
  void FlushQueues();
  
  void PrintDNA();
  
  std::vector<DNA*> dna_;
  ValidIterator<DNA*> active_dna_it;
  std::vector<RNA*> rna_;
  ValidIterator<RNA*> active_rna_it;
  std::vector<Protein*> proteins_;
  
  std::queue<DNA*> dna_queue_;
  std::queue<RNA*> rna_queue_;
  std::queue<Protein*> protein_queue_;
};

}

#endif
