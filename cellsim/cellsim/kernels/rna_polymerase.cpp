#include "cellsim/world/world_state.h"
#include "cellsim/genes/gene.h"
#include "cellsim/genes/gene_sequence.h"
#include "cellsim/dna/dna.h"
#include "cellsim/rna/rna.h"

namespace cellsim {

struct LaunchRNAPolymerase
{
  void launch(DNA* dna, RNA* rna, unsigned int seq)
  {
    GeneSequence& gs = dna->fetchGeneSequence(seq);
    unsigned int i;
    for (i = 0; i < gs.size(); ++i) {
      rna->transcribeGene(gs.at(i));
    }
  }
};

void RNAPolymerase::Compute(WorldState* ws)
{
  RNA* rna = new RNA();
  DNA* dna = ws->getDNA();
  unsigned int seq = ws->getRNAPTranscriptionSequence();
  LaunchRNAPolymerase::lauch(dna, rna, seq);
  ws->addRNA(rna);
}

}