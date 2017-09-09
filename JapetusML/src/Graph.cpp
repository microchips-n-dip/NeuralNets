#include "../inc/util.h"
#include "../inc/Graph.h"

namespace Japetus {

// Construct uninitialized node
Node::Node() :
  id_(-1), cost_id_(-1),
  func_(nullptr)
{ }

// Initialize node with settings
void Node::initialize(int id, int cost_id,
  std::shared_ptr<Functor> func)
{
  id_ = id;
  cost_id_ = cost_id;

  func_ = std::move(func);
}

// Clear node configuration
void Node::clear()
{
  in_edges_.clear();
  out_edges_.clear();

  id_ = -1;
  cost_id_ = -1;

  func_.reset();
  func_ = nullptr;
}

// Clear edge configuration
void Edge::clear()
{
  id_ = -1;
  src_ = nullptr;
  src_output_ = -1;
  dst_ = nullptr;
  dst_input_ = -1;
}

// Dynamic allocation of nodes

// Allocate memory for a node
// Checks available nodes to prevent memory tearing
Node* Graph::allocate_node(
  std::shared_ptr<Functor> func,
  const Node* cost_node)
{
  Node* node = nullptr;

  if (av_nodes_.empty()) {
    node = new Node;
  } else {
    node = av_nodes_.back();
    av_nodes_.pop_back();
  }

  node->graph_ = this;
  const int id = nodes_.size();
  int cost_id = cost_node ? cost_node->cost_id() : id;
  node->initialize(id, cost_id, std::move(func));

  nodes_.push_back(node);
  return node;
}

// Release node and mark as available
void Graph::release_node(Node* node)
{
  nodes_[node->id()] = nullptr;
  av_nodes_.push_back(node);
  node->clear();
}

// Addition/removal of nodes

/*template <typename FunctorType>
Node* Graph::add_node(
  FunctorType func,
  Status* status)
{
  Node* node = nullptr;

  node = allocate_node(
    std::make_shared<typename remove_all<FunctorType>::type>(func), nullptr);
  return node;
}*/

// Remove node from graph and mark as available
void Graph::remove_node(Node* node)
{
  release_node(node);
}

// Dynamic allocation of edges

// Allocate an edge
// Checks available edges to prevent memory tearing
Edge* Graph::allocate_edge(
  Node* src_node, int src_out,
  Node* dst_node, int dst_in)
{
  Edge* edge = nullptr;

  if (av_edges_.empty()) {
    edge = new Edge;
  } else {
    edge = av_edges_.back();
    av_edges_.pop_back();
  }

  edge->id_ = edges_.size();
  edge->src_ = src_node;
  edge->src_output_ = src_out;
  edge->dst_ = dst_node;
  edge->dst_input_ = dst_in;

  edges_.push_back(edge);
  return edge;
}

// Releae edge and mark as available
void Graph::release_edge(Edge* edge)
{
  edges_[edge->id()] = nullptr;
  av_edges_.push_back(edge);
  edge->clear();
}

// Addition/removal of edges

// Add edge to graph
Edge* Graph::add_edge(
  Node* src_node,
  int src_out,
  Node* dst_node,
  int dst_in)
{
  Edge* edge = allocate_edge(
    src_node, src_out,
    dst_node, dst_in);

  src_node->out_edges_.push_back(edge);
  dst_node->in_edges_.push_back(edge);

  return edge;
}

// Mark edge as avaiable and remove from graph
void Graph::remove_edge(Edge* edge)
{
  release_edge(edge);
}

}
