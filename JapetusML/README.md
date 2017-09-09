# JapetusML
TensorFlow-like machine learning and general modular mathematics library.

Breakdown of internals:
Graph: Stores modular mathematical model
Scope: Contains a graph and additional data
Functor: Object oriented operations
FunctorImpl: Implementation of functions for creating functors and adding nodes to graphs
Functions: Functions for manipulating numerical data while running
Session: Evaluates output of a model at some node
