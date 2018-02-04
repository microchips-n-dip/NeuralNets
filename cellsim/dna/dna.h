#ifndef CELLSIM_DNA_H
#define CELLSIM_DNA_H

#include <vector>

#include "cellsim/core/status.h"
#include "cellsim/core/valid_iterator.h"

namespace cellsim {

enum Bindable {
  LACTOSE_REPRESSOR
};

struct Promoter;

struct Repressor
{
  virtual Status Bind(Promoter* p);
  virtual Status Unbind();
  
  Promoter* promoter;
};

struct LactoseRepressor :
  public Repressor
{
  Status Bind(Promoter* p);
  Status Unbind();
};

struct Promoter
{
  bool is_repressed() { return repressor != nullptr; }
  
  std::vector<Bindable>& FetchBindables() { return b; }
  
  Repressor* repressor;
  std::vector<Bindable> b;
};

enum DNACode {
  DNA_POLYMERASE_GENE,
  RNA_POLYMERASE_GENE,
  RIBOSOME_COMPLEX_GENE
};

struct DNAStrand
{
  void AddPromoter(Promoter* p)
  { promoters.push_back(p); }
  
  DNACode FetchCode() { return code; }
  
  std::vector<Promoter*>& FetchPromoters()
  { return promoters; }
  
  DNAStrand() { }
  DNAStrand(DNACode c, std::vector<Promoter*> p);
  
  DNACode code;
  std::vector<Promoter*> promoters;
};

struct DNA
{
  void AddStrand(DNAStrand* strand)
  { strands.push_back(strand); }
  
  DNAStrand* FetchStrand(unsigned int strand_id)
  { return strands.at(strand_id); }
  
  std::vector<DNAStrand*>& FetchStrands()
  { return strands; }
  
  ValidIterator<DNAStrand*> FetchStrandsIterator()
  { return strands; }
  
  std::vector<DNAStrand*>::iterator begin()
  { return strands.begin(); }
  
  std::vector<DNAStrand*>::iterator end()
  { return strands.end(); }
  
  DNA() { }
  DNA(std::vector<DNAStrand*> s);
  
  std::vector<DNAStrand*> strands;
};

}

#endif
