#include "../inc/util.h"
#include "../inc/Graph.h"

namespace Japetus {

Node::Node() :
  id_(-1), cost_id_(-1),
  func_(nullptr)
{ }

void Node::initialize(int id, int cost_id,
  std::shared_ptr<Functor> func)
{
  id_ = id;
  cost_id_ = cost_id;

  func_ = std::move(func);
}

void Node::clear()
{
  in_edges_.clear();
  out_edges_.clear();

  id_ = -1;
  cost_id_ = -1;

  func_.reset();
  func_ = nullptr;
}

void Edge::clear()
{
  id_ = -1;
  src_ = nullptr;
  src_output_ = -1;
  dst_ = nullptr;
  dst_input_ = -1;
}

// Dynamic allocation of nodes

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

void Graph::release_node(Node* node)
{
  nodes_[node->id()] = nullptr;
  av_nodes_.push_back(node);
  node->clear();
}

// Addition/removal of nodes

template <typename FunctorType>
Node* Graph::add_node(
  FunctorType func,
  Status* status)
{
  Node* node = nullptr;

  node = allocate_node(
    std::make_shared<typename remove_all<FunctorType>::type>(func), nullptr);
  return node;
}

void Graph::remove_node(Node* node)
{
  release_node(node);
}

// Dynamic allocation of edges

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

void Graph::release_edge(Edge* edge)
{
  edges_[edge->id()] = nullptr;
  av_edges_.push_back(edge);
  edge->clear();
}

// Addition/removal of edges

Edge* Graph::add_edge(
  Node* src_node,
  int src_out,
  Node* dst_node,
  int dst_in)
{
  Edge* edge = allocate_edge(
    src_node, src_out,
    dst_node, dst_in);

  return edge;
}

void Graph::remove_edge(Edge* edge)
{
  release_edge(edge);
}

}
