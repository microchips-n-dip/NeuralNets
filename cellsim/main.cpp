#include <vector>
#include <iostream>

#include "cellsim/core/status.h"
#include "cellsim/core/worldstate.h"
#include "cellsim/dna/dna.h"
#include "cellsim/rna/rna.h"
#include "cellsim/proteins/dnapolymerase.h"
#include "cellsim/proteins/rnapolymerase.h"
#include "cellsim/proteins/ribosome.h"

using namespace cellsim;

int main(void)
{
	std::vector<DNAStrand*> strands;
  strands.push_back(new DNAStrand(RNA_POLYMERASE_GENE, {}));
  strands.push_back(new DNAStrand(RIBOSOME_COMPLEX_GENE, {}));
	
  WorldState world;
	world.AddProtein(new RNAPolymerase());
	world.AddProtein(new RibosomeComplex());
  world.AddProtein(new RibosomeComplex());
	world.AddProtein(new RibosomeComplex());
  world.AddProtein(new RibosomeComplex());
	world.AddDNA(new DNA(strands));
  world.reset();
	
  world.PrintDNA();
  
  
	while (true) {
		world.Run();
    std::cout << "Cell contains " << world.GetRNASize() << " floating RNA strands\n";
		std::cout << "Cell contains " << world.GetProteinsSize() << " proteins\n";
	}
}