#include "cellsim/proteins/dnapolymerase.h"

namespace cellsim {

Status DNAPolymerase::Bind(DNA* bdna)
{
  src = bdna;
  return Status::OK();
}

Status DNAPolymerase::Unbind()
{
  src = nullptr;
  return Status::OK();
}

Status DNAPolymerase::CopyDNA()
{
  Status s = Bind(working_dna);
  if (s.ok()) {
    transcribed_dna = new DNA();
    for (auto* strand : src->FetchStrands()) {
      DNAStrand* dst_strand = new DNAStrand();
      for (auto* p : strand->FetchPromoters()) {
        dst_strand->AddPromoter(new Promoter(*p));
      }
      dst_strand->code = strand->code;
      transcribed_dna->AddStrand(dst_strand);
    }
    Unbind();
    return Status::OK();
  }
  else {
    return Status::TranscriptionFailure();
  }
}

void DNAPolymerase::ResetWorkingDNA(DNA* w_dna)
{
  working_dna = w_dna;
}

DNA* DNAPolymerase::ReleaseDNA()
{ return transcribed_dna; }

}
