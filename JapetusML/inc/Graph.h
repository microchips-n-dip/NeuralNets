#ifndef JAPETUS_GRAPH_H
#define JAPETUS_GRAPH_H

#include <vector>
#include <functional>
#include <memory>

#include "../inc/util.h"
#include "../inc/Functor.h"

namespace Japetus {

struct Status { };

// Forward declaration
class Node;
class Edge;
class Graph;

// Node class
class Node
{
 public:
  int id() const { return id_; } // Get node's in-graph id
  int cost_id() const { return cost_id_; } // Get node's cost id

  // Initialize nodes
  void initialize(int id, int cost_id,
    std::shared_ptr<Functor> func);
  // Clear node settings
  void clear();

  std::vector<Edge*> in_edges() const { return in_edges_; } // Get input edges
  std::vector<Edge*> out_edges() const { return out_edges_; } // Get output edges

  std::shared_ptr<Functor> func() const { return func_; } // Get functor

 private:
  Node(); // Uninitialized node

  friend class Graph;

  Graph* graph_; // Back reference to graph

  std::shared_ptr<Functor> func_; // Functor

  std::vector<Edge*> in_edges_; // Input edges
  std::vector<Edge*> out_edges_; // Output edges

  int id_; // In-graph id
  int cost_id_; // Cost id
};

// Edge class
class Edge
{
 public:
  Node* src() const { return src_; } // Get source node
  Node* dst() const { return dst_; } // Get destination node
  int id() const { return id_; } // Get id in graph

  int src_output() const { return src_output_; } // Get source output id

  int dst_input() const { return dst_input_; } // Get destination input id

  void clear(); // Clear configuration

 private:
  Edge() { }

  friend class Graph;

  Node* src_; // Source node
  Node* dst_; // Destination node

  int id_; // In-graph id
  int src_output_; // Source output id
  int dst_input_; // Destination input id
};

// Geaph class
class Graph
{
 public:
  // Add node
  template <typename FunctorType>
  Node* add_node(
    FunctorType func,
    Status* status);
  // Remove node
  void remove_node(Node* node);

  // Add edge
  Edge* add_edge(
    Node* src_node, int src_out,
    Node* dst_node, int dst_in);
  // Remove edge
  void remove_edge(Edge* edge);

 private:
  // Allocate for node
  Node* allocate_node(
    std::shared_ptr<Functor> func,
    const Node* cost_node);
  // Release node
  void release_node(Node* node);

  // Allocate edge
  Edge* allocate_edge(
    Node* src_node, int src_out,
    Node* dst_node, int dst_in);
  // Release edge
  void release_edge(Edge* edge);

  std::vector<Node*> nodes_; // Graph nodes
  std::vector<Node*> av_nodes_; // Available nodes

  std::vector<Edge*> edges_; // Graph edges
  std::vector<Edge*> av_edges_; // Available edges
};

// Add node to graph
template <typename FunctorType>
Node* Graph::add_node(
  FunctorType func,
  Status* status)
{
  // This is for properly making shared pointer
  typedef typename remove_all<FunctorType>::type ftype;

  Node* node = nullptr;

  // Allocate node
  node = allocate_node(
    std::static_pointer_cast<Functor>(
      std::make_shared<ftype>
      (*func)), nullptr);
  return node;
}

}

#endif
