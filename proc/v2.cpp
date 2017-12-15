#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <unordered_map>

struct CompilerState
{
  unsigned int base0 = 0;
  unsigned int base1 = 0;
  unsigned int base2 = 0;
  std::unordered_map<std::string, unsigned int> variables;
  std::vector<uint64_t> raw;
  unsigned int regA;
  unsigned int regB;
};

struct Instruction
{
  Instruction() { }
  virtual void _decl_pass(CompilerState& cstate) { }
  virtual void _construct(CompilerState& cstate) { }
};

struct TensorDecl : public Instruction
{
  std::vector<std::string> args;
  
  unsigned int n_dims;
  std::vector<unsigned int> dims;
  
  TensorDecl(const std::vector<std::string>& _args)
  {
    args = _args;
  }
  
  void _decl_pass(CompilerState& cstate)
  {
    n_dims = std::stoi(args[0]) + 1;
    dims.resize(n_dims);
    unsigned int n_desc = 1;
    unsigned int n_var = 1;
    dims[0] = 1;
    unsigned int i;
    for (i = 1; i < n_dims; ++i) {
      dims[i] = std::stoi(args[i]);
      if (i < n_dims - 1) {
        n_desc += dims[i];
      }
      n_var *= dims[i];
    }
    std::string name = args[n_dims];
    auto search = cstate.variables.find(name);
    if (search != cstate.variables.end()) {
      std::cout << "Error: Redeclaration of variable " << name << std::endl;
      exit(-1);
    }
    cstate.variables[name] = cstate.base1;
    cstate.base1 += 4 * n_desc + n_var;
  }
  
  void _construct(CompilerState& cstate)
  {
    unsigned int i;
    unsigned int j;
    unsigned int parent;
    for (i = 0; i < n_dims - 1; ++i) {
      uint64_t link;
      uint64_t stride;
      uint64_t length;
      // Stride and link states are known depending on whether the block is another descriptor or a vector
      if (i < n_dims - 2) {
        link = 1;
        stride = 4;
      }
      else {
        link = 0;
        stride = 1;
      }
      length = dims[i + 1]; // Get length
      parent = cstate.base2; // Reset the parent for tree structure
      for (j = 0; j < dims[i]; ++j) {
        cstate.base2 += dims[i] * stride;
        uint64_t desc = 0; // Descriptor
        desc += link         << 63; // Set link flag
        desc += length       << 48; // Set length field
        desc += (uint64_t)1  << 47; // Set valid flag (subject to removal)
        desc += stride       << 32; // Set stride field
        desc += cstate.base2 << 16; // Set base field
        desc += parent       << 0;  // Set parent field
        // Print to output file
        cstate.raw.push_back(desc);
      }
    }
  }
};

struct Matadd : public Instruction
{
  std::vector<std::string> args;
  
  Matadd(const std::vector<std::string>& _args)
  {
    args = _args;
  }
  
  void _decl_pass(CompilerState& cstate)
  {
    cstate.base0 += 5;
  }
  
  void _construct(CompilerState& cstate)
  {
    auto search0 = cstate.variables.find(args[0]);
    if (search0 == cstate.variables.end()) {
      std::cout << "Error: Use of undeclared variable " << args[0] << std::endl;
      exit(-1);
    }
    unsigned int op0_ptr = cstate.variables[args[0]];
    auto search1 = cstate.variables.find(args[1]);
    if (search1 == cstate.variables.end()) {
      std::cout << "Error: Use of undeclared variable " << args[1] << std::endl;
      exit(-1);
    }
    unsigned int op1_ptr = cstate.variables[args[1]];
    uint16_t load0_instr = 0;
    load0_instr += 12          << 11;
    load0_instr += 0           << 10;
    load0_instr += 0           << 8;
    load0_instr += cstate.regA << 4;
    load0_instr += 0           << 0;
    uint16_t load0_imm = op0_ptr;
    cstate.raw.push_back(load0_instr);
    cstate.raw.push_back(load0_imm);
    unsigned int maa_regA = cstate.regA;
    ++cstate.regA;
    uint16_t load1_instr = 0;
    load1_instr += 12          << 11;
    load1_instr += 0           << 10;
    load1_instr += 0           << 8;
    load1_instr += cstate.regA << 4;
    load1_instr += 0           << 0;
    uint16_t load1_imm = op1_ptr;
    cstate.raw.push_back(load1_instr);
    cstate.raw.push_back(load1_imm);
    unsigned int maa_regB = cstate.regA;
    ++cstate.regA;
    uint16_t maa0_instr = 0;
    maa0_instr += 5        << 11;
    maa0_instr += 0        << 10;
    maa0_instr += 0        << 9;
    maa0_instr += 1        << 8;
    maa0_instr += maa_regA << 4;
    maa0_instr += maa_regB << 0;
    cstate.raw.push_back(maa0_instr);
  }
};

struct Matsub : public Instruction
{
  std::vector<std::string> args;
  
  Matsub(const std::vector<std::string>& _args)
  {
    args = _args;
  }
  
  void _decl_pass(CompilerState& cstate)
  {
    cstate.base0 += 5;
  }
  
  void _construct(CompilerState& cstate)
  {
    auto search0 = cstate.variables.find(args[0]);
    if (search0 == cstate.variables.end()) {
      std::cout << "Error: Use of undeclared variable " << args[0] << std::endl;
      exit(-1);
    }
    unsigned int op0_ptr = cstate.variables[args[0]];
    auto search1 = cstate.variables.find(args[1]);
    if (search1 == cstate.variables.end()) {
      std::cout << "Error: Use of undeclared variable " << args[1] << std::endl;
      exit(-1);
    }
    unsigned int op1_ptr = cstate.variables[args[1]];
    uint16_t load0_instr = 0;
    load0_instr += 12          << 11;
    load0_instr += 0           << 10;
    load0_instr += 0           << 8;
    load0_instr += cstate.regA << 4;
    load0_instr += 0           << 0;
    uint16_t load0_imm = op0_ptr;
    cstate.raw.push_back(load0_instr);
    cstate.raw.push_back(load0_imm);
    unsigned int msa_regA = cstate.regA;
    ++cstate.regA;
    uint16_t load1_instr = 0;
    load1_instr += 12          << 11;
    load1_instr += 0           << 10;
    load1_instr += 0           << 8;
    load1_instr += cstate.regA << 4;
    load1_instr += 0           << 0;
    uint16_t load1_imm = op1_ptr;
    cstate.raw.push_back(load1_instr);
    cstate.raw.push_back(load1_imm);
    unsigned int msa_regB = cstate.regA;
    ++cstate.regA;
    uint16_t msa0_instr = 0;
    msa0_instr += 7        << 11;
    msa0_instr += 0        << 10;
    msa0_instr += 0        << 9;
    msa0_instr += 1        << 8;
    msa0_instr += msa_regA << 4;
    msa0_instr += msa_regB << 0;
    cstate.raw.push_back(msa0_instr);
  }
};

struct Matmul : public Instruction
{
  std::vector<std::string> args;
  
  Matmul(const std::vector<std::string>& _args)
  {
    args = _args;
  }
  
  void _decl_pass(CompilerState& cstate)
  {
    cstate.base0 += 5;
  }
  
  void _construct(CompilerState& cstate)
  {
    auto search0 = cstate.variables.find(args[0]);
    if (search0 == cstate.variables.end()) {
      std::cout << "Error: Use of undeclared variable " << args[0] << std::endl;
      exit(-1);
    }
    unsigned int op0_ptr = cstate.variables[args[0]];
    auto search1 = cstate.variables.find(args[1]);
    if (search1 == cstate.variables.end()) {
      std::cout << "Error: Use of undeclared variable " << args[1] << std::endl;
      exit(-1);
    }
    unsigned int op1_ptr = cstate.variables[args[1]];
    uint16_t load0_instr = 0;
    load0_instr += 12          << 11;
    load0_instr += 0           << 10;
    load0_instr += 0           << 8;
    load0_instr += cstate.regA << 4;
    load0_instr += 0           << 0;
    uint16_t load0_imm = op0_ptr;
    cstate.raw.push_back(load0_instr);
    cstate.raw.push_back(load0_imm);
    unsigned int mma_regA = cstate.regA;
    ++cstate.regA;
    uint16_t load1_instr = 0;
    load1_instr += 12          << 11;
    load1_instr += 0           << 10;
    load1_instr += 0           << 8;
    load1_instr += cstate.regA << 4;
    load1_instr += 0           << 0;
    uint16_t load1_imm = op1_ptr;
    cstate.raw.push_back(load1_instr);
    cstate.raw.push_back(load1_imm);
    unsigned int mma_regB = cstate.regA;
    ++cstate.regA;
    uint16_t mma0_instr = 0;
    mma0_instr += 1        << 11;
    mma0_instr += 1        << 10;
    mma0_instr += 0        << 9;
    mma0_instr += 1        << 8;
    mma0_instr += mma_regA << 4;
    mma0_instr += mma_regB << 0;
    cstate.raw.push_back(mma0_instr);
  }
};

struct CompilerObj
{
  const std::string tensor_decl = "tensor";
  const std::string matadd = "matadd";
  const std::string matsub = "matsub";
  const std::string matmul = "matmul";
  const std::string delim = " ";

  std::fstream input_file;
  std::fstream output_file;
  
  CompilerState cstate;
  
  std::vector<Instruction*> _decls;
  std::vector<Instruction*> _ops;
  
  void _gen_internal()
  {
    enum INSTR_TYPE {
      TENSOR_DECL = 1,
      MATADD      = 2,
      MATSUB      = 3,
      MATMUL      = 4
    };
    
    std::string line;
    std::string segm;
    INSTR_TYPE op;
    
    while (!input_file.eof()){
      size_t pos0 = 0;
      size_t pos1 = 0;
      std::getline(input_file, line);
      std::vector<std::string> args;
      while (pos1 != std::string::npos) {
        pos1 = line.find(delim, pos0);
        segm = line.substr(pos0, pos1 - pos0);
        pos0 = pos1 + delim.length();
        if (tensor_decl.compare(segm) == 0) {
          op = TENSOR_DECL;
        }
        else if (matadd.compare(segm) == 0) {
          op = MATADD;
        }
        else if (matsub.compare(segm) == 0) {
          op = MATSUB;
        }
        else if (matmul.compare(segm) == 0) {
          op = MATMUL;
        }
        else {
          args.push_back(segm);
        }
      }
      switch (op) {
        case TENSOR_DECL:
          _decls.push_back(new TensorDecl(args));
          break;
        case MATADD:
          _ops.push_back(new Matadd(args));
          break;
        case MATSUB:
          _ops.push_back(new Matsub(args));
          break;
        case MATMUL:
          _ops.push_back(new Matmul(args));
          break;
      }
    }
  }
  
  void _decl_pass()
  {
    unsigned int i;
    for (i = 0; i < _ops.size(); ++i) {
      (*_ops.at(i))._decl_pass(cstate);
    }
    cstate.base1 = cstate.base0;
    for (i = 0; i < _decls.size(); ++i) {
      (*_decls.at(i))._decl_pass(cstate);
    }
  }
  
  void _construct()
  {
    unsigned int i;
    for (i = 0; i < _ops.size(); ++i) {
      (*_ops.at(i))._construct(cstate);
    }
    cstate.base2 = cstate.base0;
    for (i = 0; i < _decls.size(); ++i) {
      (*_decls.at(i))._construct(cstate);
    }
  }
  
  void _compile(int argc, const char** argv)
  {
    input_file.open(argv[1], std::ios::in);
    output_file.open(argv[2], std::ios::out | std::ios::trunc);
    _gen_internal();
    _decl_pass();
    _construct();
    unsigned int i;
    for (i = 0; i < cstate.raw.size(); ++i) {
      output_file << std::hex << cstate.raw.at(i) << std::endl;
    }
  }
};

int main(int argc, const char** argv)
{
  CompilerObj compiler;
  compiler._compile(argc, argv);
}