#include "cellsim/core/status.h"
#include "cellsim/core/worldstate.h"

namespace cellsim {

enum DNACode {
  DNA_POLYMERASE_GENE,
  RNA_POLYMERASE_GENE
};

struct DNAStrand
{
  DNACode FetchCode() { return code; }
  
  std::vector<Promoter*>& FetchPromoters()
  { return promoters; }
  
  DNACode code;
  std::vector<Promoter*> promoters;
};

struct DNA
{
  DNAStrand* FetchStrand(unsigned int strand_id)
  { return strands.at(strand_id); }
  
  std::vector<DNAStrand*> strands;
}

}