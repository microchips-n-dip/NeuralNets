#include "cellsim/proteins/ribosome.h"

namespace cellsim {

//template <DNACode _code>
struct __ribosome_translate
{
  static void run(DNACode _code, Protein*& p);
};

void __ribosome_translate::run(DNACode _code, Protein*& p)
{
  switch (_code) {
    case DNA_POLYMERASE_GENE:
      p = new DNAPolymerase();
      break;
    case RNA_POLYMERASE_GENE:
      p = new RNAPolymerase();
      break;
    case RIBOSOME_COMPLEX_GENE:
      p = new RibosomeComplex();
      break;
    default:
      break;
  }
}

/*template <>
void __ribosome_translate<DNA_POLYMERASE_GENE>::run(Protein*& p)
{ p = new DNAPolymerase(); }

template <>
void __ribosome_translate<RNA_POLYMERASE_GENE>::run(Protein*& p)
{ p = new RNAPolymerase(); }

template <>
void __ribosome_translate<RIBOSOME_COMPLEX_GENE>::run(Protein*& p)
{ p = new RibosomeComplex(); }*/

RibosomeComplex::RibosomeComplex()
{
  working_rna = nullptr;
}

Status RibosomeComplex::Bind()
{
  if (working_rna == nullptr) {
    return Status::BindFailure();
  }
  code = working_rna->FetchCode();
  return Status::OK();
}

Status RibosomeComplex::Unbind()
{
  working_rna = nullptr;
  return Status::OK();
}

Status RibosomeComplex::Translate()
{
  Status s = Bind();
  if (s.ok()) {
    __ribosome_translate/*<FetchCode()>*/::run(code, translated_protein);
    Unbind();
    return Status::OK();
  }
  else {
    return Status::TranslationFailure();
  }
}

void RibosomeComplex::ResetWorkingRNA(RNA* w_rna)
{
  working_rna = w_rna;
}

Protein* RibosomeComplex::ReleaseProtein()
{ return translated_protein; }

}
