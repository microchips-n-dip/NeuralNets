#include "cellsim/dna/dna.h"
#include "cellsim/rna/rna.h"

namespace cellsim {

struct WorldState
{
  DNA* dna;
  std::vector<RNA*> rnas;
  unsigned int rna_transcription_seq;
  
  DNA* getDNA() const
  {
    return dna;
  }
  
  unsigned int getRNAPTransriptionSequence()
  {
    if (rna_transcription_seq >= dna->getSequenceCount()) {
      rna_transcription_seq = 0;
    }
    ++rna_transcription_seq;
    return rna_transcription_seq - 1;
  }
  
  void addRNA(RNA* rna)
  {
    rnas.push_back(new RNA());
    RNA::copyRNAs(rnas.back(), rna);
  }
};

}