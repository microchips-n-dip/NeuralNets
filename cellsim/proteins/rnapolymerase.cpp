#include "cellsim/proteins/rnapolymerase.h"

namespace cellsim {

RNAPolymerase::RNAPolymerase()
{
  working_dna = nullptr;
}

Status RNAPolymerase::Bind()
{
  if (working_dna == nullptr) {
    return Status::PlzFetchNext();
  }
  if (strand_it.at_end()) {
    return Status::PlzFetchNext();
  }
  strand = *strand_it;
  std::vector<Promoter*>& promoters = strand->FetchPromoters();
  for (auto* p : promoters) {
    if (p->is_repressed()) {
      Unbind();
      return Status::BindFailure();
    }
  }
  return Status::OK();
}

Status RNAPolymerase::Unbind()
{
  strand = nullptr;
  return Status::OK();
}

Status RNAPolymerase::TranscribeRNA()
{
  Status s = Bind();
  if (s.ok()) {
    transcribed_rna = new RNA;
    transcribed_rna->SetCode(strand->FetchCode());
    Unbind();
    ++strand_it;
    return Status::OK();
  }
  else if (s.FetchNext()) {
    return Status::PlzFetchNext();
  }
  else {
    return Status::TranscriptionFailure();
  }
}

void RNAPolymerase::ResetWorkingDNA(DNA* w_dna)
{
  working_dna = w_dna;
  strand_it = working_dna->FetchStrandsIterator();
}

RNA* RNAPolymerase::ReleaseRNA()
{ return transcribed_rna; }

}
