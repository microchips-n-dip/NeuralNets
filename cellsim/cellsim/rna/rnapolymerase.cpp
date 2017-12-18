#include "cellsim/core/status.h"
#include "cellsim/core/worldstate.h"
#include "cellsim/rna/rnapolymerase.h"

namespace cellsim {

RNAPolymerase::RNAPolymerase(WorldState* world)
{
  ws = world;
  strand_id = 0;
}

Status RNAPolymerase::Bind()
{
  DNA* dna = ws->FetchDNA();
  strand = dna->FetchStrand(strand_id);
  std::vector<Promoter*>& promoters = strand->FetchPromoters();
  for (auto p* : promoters) {
    if (p->is_repressed()) {
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

void RNAPolymerase::TranscribeRNA()
{
  rna = new RNA;
  Status s = Bind();
  if (s.ok()) {
    rna->SetCode(strand->FetchCode());
    ws->ReleaseNewRNA(rna);
  }
  Unbind();
  strand_id++;
}

}
