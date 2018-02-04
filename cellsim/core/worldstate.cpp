#include "cellsim/core/worldstate.h"
#include "cellsim/kernel/kernel.h"

namespace cellsim {

struct Executor
{
  template <typename ListType>
  static void run(WorldState* world, ListType& list);
};

template <typename ListType>
void Executor::run(WorldState* world, ListType& list)
{
  ValidIterator<Protein*> item;
  for (item = list; item.valid(); ++item) {
    KernelRunHelper* kernel_runner;
    (*item)->FetchKernelRunner(&kernel_runner);
    kernel_runner->operator()(world, *item);
    if (kernel_runner) {
      delete kernel_runner;
    }
  }
}

void WorldState::Run()
{
  Executor::run(this, proteins_);
  FlushQueues();
}

void WorldState::reset()
{
  active_dna_it = dna_;
  active_rna_it = rna_;
}

WorldState::WorldState()
{
  active_dna_it = dna_;
  active_rna_it = rna_;
}

void WorldState::AddDNA(DNA* dna) {
  dna_.push_back(dna);
}

void WorldState::AddRNA(RNA* rna) {
  rna_.push_back(rna);
}

void WorldState::AddProtein(Protein* protein) {
  proteins_.push_back(protein); 
}

void WorldState::EnqueueDNA(DNA* dna) {
  dna_queue_.push(dna);
}

void WorldState::EnqueueRNA(RNA* rna) {
  rna_queue_.push(rna);
}

void WorldState::EnqueueProtein(Protein* protein) {
  protein_queue_.push(protein);
}

void WorldState::FlushQueues() {
  while (!dna_queue_.empty()) {
    dna_.push_back(dna_queue_.front());
    dna_queue_.pop();
  }
  while (!rna_queue_.empty()) {
    rna_.push_back(rna_queue_.front());
    rna_queue_.pop();
  }
  while (!protein_queue_.empty()) {
    proteins_.push_back(protein_queue_.front());
    protein_queue_.pop();
  }
}

void WorldState::PrintDNA() {
  ValidIterator<DNA*> item;
  ValidIterator<DNAStrand*> strand;
  for (item = dna_; item.valid(); ++item) {
    std::cout << "DNA Sequence...\n";
    for (strand = (*item)->FetchStrandsIterator(); strand.valid(); ++strand) {
      DNACode code = (*strand)->FetchCode();
      switch (code) {
        case DNA_POLYMERASE_GENE:
          std::cout << "DNA_POLYMERASE_GENE\n";
          break;
        case RNA_POLYMERASE_GENE:
          std::cout << "RNA_POLYMERASE_GENE\n";
          break;
        case RIBOSOME_COMPLEX_GENE:
          std::cout << "RIBOSOME_COMPLEX_GENE\n";
          break;
      }
    }
  }
}

}
