#ifndef VEX_NN_MATH_H
#define VEX_NN_MATH_H

#include <math.h>

#include "matrix.h"

double sigmoid(double z) {
  return 1.0 / (1 + exp(-z));
}

double sigmoid_prime(double z) {
  return sigmoid(z) * (1 - sigmoid(z));
}

void add(matrix_double* a, matrix_double* b, matrix_double* c) {
  md_init(c, a->rows, a->cols);
  unsigned int i;
  unsigned int j;
  for (i = 0; i < a->rows; ++i) {
    for (j = 0; j < a->cols; ++j) {
      c->data[i][j] = a->data[i][j] + b->data[i][j];
    }
  }
}

void sub(matrix_double* a, matrix_double* b, matrix_double* c) {
  md_init(c, a->rows, a->cols);
  unsigned int i;
  unsigned int j;
  for (i = 0; i < a->rows; ++i) {
    for (j = 0; j < a->cols; ++j) {
      c->data[i][j] = a->data[i][j] - b->data[i][j];
    }
  }
}

void dot(matrix_double* a, matrix_double* b, matrix_double* c) {
  md_init(c, a->rows, b->cols);
  unsigned int i;
  unsigned int j;
  unsigned int k;
  for (i = 0; i < a->rows; ++i) {
    for (j = 0; j < b->cols; ++j) {
      for (k = 0; k < a->cols; ++k) {
        c->data[i][j] += a->data[i][k] * b->data[k][j];
      }
    }
  }
}

#endif

