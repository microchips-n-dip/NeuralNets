#include "cellsim/core/worldstate.h"
#include "cellsim/kernel/kernel.h"

namespace cellsim {

void KernelRunHelper::operator()(WorldState* world, Protein* arg)
{
  kernel->run(world, arg);
}

template <>
void KernelRunHelper::Kernel<Protein>::run(WorldState* world, Protein* p)
{ std::cout << "Void protein kernel called\n"; }

void Protein::FetchKernelRunner(KernelRunHelper** kernel_runner)
{
  *kernel_runner = new KernelRunHelper();
  (*kernel_runner)->create_kernel<Protein>();
}

// Kernel for DNA Polymerase
template <>
void KernelRunHelper::Kernel<DNAPolymerase>::run(WorldState* world, Protein* p)
{
  DNAPolymerase& dnap = *reinterpret_cast<DNAPolymerase*>(p);
  Status s = dnap.CopyDNA();
  if (s.ok()) {
    world->EnqueueDNA(dnap.ReleaseDNA());
  }
  if (world->active_dna_it.at_end()) {
    world->active_dna_it.reset();
  }
  if (world->active_dna_it.valid()) {
    dnap.ResetWorkingDNA(*(world->active_dna_it));
  }
  ++world->active_dna_it;
}

// Kernel runner for DNA Polymerase
void DNAPolymerase::FetchKernelRunner(KernelRunHelper** kernel_runner)
{
  *kernel_runner = new KernelRunHelper();
  (*kernel_runner)->create_kernel<DNAPolymerase>();
}

template <>
void KernelRunHelper::Kernel<RNAPolymerase>::run(WorldState* world, Protein* p)
{
  RNAPolymerase& rnap = *reinterpret_cast<RNAPolymerase*>(p);
  Status s = rnap.TranscribeRNA();
  if (s.ok()) {
    world->EnqueueRNA(rnap.ReleaseRNA());
  }
  if (s.FetchNext()) {
    if (world->active_dna_it.at_end()) {
      world->active_dna_it.reset();
    }
    if (world->active_dna_it.valid()) {
      rnap.ResetWorkingDNA(*(world->active_dna_it));
    }
    ++world->active_dna_it;
  }
}

void RNAPolymerase::FetchKernelRunner(KernelRunHelper** kernel_runner)
{
  *kernel_runner = new KernelRunHelper();
  (*kernel_runner)->create_kernel<RNAPolymerase>();
}

template <>
void KernelRunHelper::Kernel<RibosomeComplex>::run(WorldState* world, Protein* p)
{
  if (world->active_rna_it.at_end()) {
    world->active_rna_it.reset();
  }
  RibosomeComplex& ribosome = *reinterpret_cast<RibosomeComplex*>(p);
  Status s = ribosome.Translate();
  if (s.ok()) {
    world->EnqueueProtein(ribosome.ReleaseProtein());
  }
  if (world->active_rna_it.valid()) {
    ribosome.ResetWorkingRNA(*(world->active_rna_it));
    world->active_rna_it.erase_current();
  }
  ++world->active_rna_it;
}

void RibosomeComplex::FetchKernelRunner(KernelRunHelper** kernel_runner)
{
  *kernel_runner = new KernelRunHelper();
  (*kernel_runner)->create_kernel<RibosomeComplex>();
}

}
