#ifndef VEX_NN_H
#define VEX_NN_H

#include <stdlib.h>
#include <string.h>

#include "matrix.h"
#include "nn_math.h"

typedef struct {
  matrix_double zct;
  matrix_double act;
  matrix_double weight;
  matrix_double dJdW;
} NeuralLayer;
void nl_init(NeuralLayer* nl, unsigned int sz0, unsigned int sz1) {
  md_init(&nl->zct, sz0, 1);
  md_init(&nl->act, sz0 + 1, 1);
  md_init(&nl->weight, sz0, sz1 + 1);
  nl->act.data[sz0][0] = 1;
}

matrix_double* nl_forward(NeuralLayer* nl, matrix_double x) {
  unsigned int i;
  dot(&nl->weight, &x, &nl->zct);
  for (i = 0; i < nl->weight.rows; ++i) {
    nl->act.data[i][0] = sigmoid(nl->zct.data[i][0]);
  }
  return &nl->act;
}

typedef struct {
  unsigned int nlr;
  matrix_int sz;
  matrix_double z;
  NeuralLayer* layers;
} NeuralNet;
void nn_init(NeuralNet* nn, matrix_int sz) {
  unsigned int nlr = sz.rows;
  nn->nlr = nlr;
  mi_copy(&sz, &nn->sz);
  nn->layers = (NeuralLayer*) malloc(nlr * sizeof(NeuralLayer));
  unsigned int i;
  for (i = 1; i < nlr; ++i) {
    nl_init(&nn->layers[i], sz.data[i][0], sz.data[i-1][0]);
  }
}

matrix_double* nn_forward(NeuralNet* nn, matrix_double x) {
  matrix_double a;
  md_copy(&x, &nn->z);
  unsigned int i;
  for (i = 1; i < nn->nlr; ++i) {
    md_copy(nl_forward(&nn->layers[i], nn->z), &a);
    md_copy(&a, &nn->z);
  }
  md_free(&a);
  return &nn->z;
}

enum {
  minimize = 25,
  maximize = 36
};
const int train_type = minimize;

void nn_train(NeuralNet* nn, matrix_double x, matrix_double y) {
  matrix_double yHat;
  matrix_double z_prime;
  md_copy(nn_forward(nn, x), &yHat);
  matrix_double delta_prev;
  matrix_double delta_next;
  md_init(&delta_prev, nn->sz.data[nn->nlr - 1][0], 1);
  unsigned int i;
  unsigned int j;
  for (i = 0; i < nn->sz.data[nn->nlr - 1][0]; ++i) {
    sub(&yHat, nn_forward(nn, x), &delta_prev);
  }
  for (i = nn->nlr - 2; i > 0; i--) {
    md_init(&z_prime, nn->layers[i].zct.rows, 1);
    for (j = 0; j < z_prime.rows; ++i) {
      z_prime.data[i][0] = sigmoid_prime(nn->layers[i].zct.data[i][0]);
    }
    dot(&delta_prev, &z_prime, &delta_next);
    dot(&delta_next, &nn->layers[i].act, &nn->layers[i].dJdW);
    dot(&delta_next, &nn->layers[i].weight, &delta_prev);
    if (train_type == minimize) {
      sub(&nn->layers[i].weight, &nn->layers[i].dJdW, &nn->layers[i].weight);
    }
    if (train_type == maximize) {
      add(&nn->layers[i].weight, &nn->layers[i].dJdW, &nn->layers[i].weight);
    }
  }
}

void test() {
  unsigned int nlr = 3;
  matrix_int sz;
  mi_init(&sz, nlr, 1);
  sz.data[0][0] = 2;
  sz.data[1][0] = 3;
  sz.data[2][0] = 1;
  NeuralNet net;
  nn_init(&net, sz);
  matrix_double x;
  md_init(&x, sz.data[0][0], 3);
  x.data[0][0] = 0.3;
  x.data[1][0] = 1.0;
  x.data[0][1] = 0.5;
  x.data[1][1] = 0.2;
  x.data[0][2] = 1.0;
  x.data[1][2] = 0.4;
  matrix_double y;
  md_init(&y, sz.data[nlr-1][0], 3);
  y.data[0][0] = 0.75;
  y.data[0][1] = 0.82;
  y.data[0][2] = 0.93;
  unsigned int t;
  for (t = 0; t < 5000; ++t) {
    nn_train(&net, x, y);
  }
  matrix_double yHat = *nn_forward(&net, x);
  unsigned int i;
  for (i = 0; i < sz.data[2][0]; ++i) {
    PrintToScreen("%f\t", yHat.data[i][0]);
  }
  PrintToScreen("\n");
}

#endif

