#ifndef JAPETUS_GRAPH_H
#define JAPETUS_GRAPH_H

#include <vector>
#include <functional>
#include <memory>

#include "../inc/util.h"
#include "../inc/Functor.h"

namespace Japetus {

struct Status { };

class Node;
class Edge;
class Graph;

class Node
{
 public:
  int id() const { return id_; }
  int cost_id() const { return cost_id_; }

  void initialize(int id, int cost_id,
    std::shared_ptr<Functor> func);
  void clear();

  std::vector<Edge*> in_edges() const { return in_edges_; }
  std::vector<Edge*> out_edges() const { return out_edges_; }

  std::shared_ptr<Functor> func() const { return func_; }

 private:
  Node();

  friend class Graph;

  Graph* graph_;

  std::shared_ptr<Functor> func_;

  std::vector<Edge*> in_edges_;
  std::vector<Edge*> out_edges_;

  int id_;
  int cost_id_;
};

class Edge
{
 public:
  Node* src() const { return src_; }
  Node* dst() const { return dst_; }
  int id() const { return id_; }

  int src_output() const { return src_output_; }

  int dst_input() const { return dst_input_; }

  void clear();

 private:
  Edge() { }

  friend class Graph;

  Node* src_;
  Node* dst_;

  int id_;
  int src_output_;
  int dst_input_;
};

class Graph
{
 public:
  template <typename FunctorType>
  Node* add_node(
    FunctorType func,
    Status* status);
  void remove_node(Node* node);

  Edge* add_edge(
    Node* src_node, int src_out,
    Node* dst_node, int dst_in);
  void remove_edge(Edge* edge);

 private:
  Node* allocate_node(
    std::shared_ptr<Functor> func,
    const Node* cost_node);
  void release_node(Node* node);

  Edge* allocate_edge(
    Node* src_node, int src_out,
    Node* dst_node, int dst_in);
  void release_edge(Edge* edge);

  std::vector<Node*> nodes_;
  std::vector<Node*> av_nodes_;

  std::vector<Edge*> edges_;
  std::vector<Edge*> av_edges_;
};

template <typename FunctorType>
Node* Graph::add_node(
  FunctorType func,
  Status* status)
{
  typedef typename remove_all<FunctorType>::type ftype;

  Node* node = nullptr;

  node = allocate_node(
    std::static_pointer_cast<Functor>(
      std::make_shared<ftype>
      (*func)), nullptr);
  return node;
}

}

#endif
