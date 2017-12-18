#include "cellsim/core/status.h"
#include "cellsim/core/worldstate.h"

namespace cellsim {

struct RNAPolymerase
{
  Status Bind();
  Status Unbind();
  void TranscribeRNAStep();
  
  RNAPolymerase(WorldState* world);
  
  WorldState* ws;
  DNAStrand* strand;
  RNA* rna;
  unsigned int strand_id;
};

}
