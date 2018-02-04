#include "cellsim/dna/dna.h"

namespace cellsim {

Status LactoseRepressor::Bind(Promoter* p)
{
  for (auto b : p->FetchBindables()) {
    if (b == LACTOSE_REPRESSOR) {
      p->repressor = this;
      promoter = p;
      return Status::OK();
    }
  }
  return Status::BindFailure();
}

Status LactoseRepressor::Unbind()
{
  promoter->repressor = nullptr;
  promoter = nullptr;
  return Status::OK();
}

DNAStrand::DNAStrand(DNACode c, std::vector<Promoter*> p) {
  code = c;
  promoters = p;
}

DNA::DNA(std::vector<DNAStrand*> s) {
  strands = s;
}

}