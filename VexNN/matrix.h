#ifndef VEX_MATRIX_H
#define VEX_MATRIX_H

#include <stdlib.h>
#include <string.h>

typedef struct {
  unsigned int rows;
  unsigned int cols;
  void** data;
} matrix_void;
void mv_free(matrix_void* mv) {
  if (mv->data) {
    unsigned int i;
    for (i = 0; i < mv->rows; ++i) {
      free(mv->data[i]);
    }
    free(mv->data);
  }
}
void mv_init(matrix_void* mv, unsigned int rows, unsigned int cols) {
  mv_free(mv);
  mv->rows = rows;
  mv->cols = cols;
  mv->data = (void**) malloc(rows * sizeof(void*));
  unsigned int i;
  for (i = 0; i < rows; ++i) {
    mv->data[i] = (void*) malloc(cols * sizeof(void));
  }
}
void mv_copy(matrix_void* src, matrix_void* dst) {
  mv_init(dst, src->rows, src->cols);
  unsigned int i;
  for (i = 0; i < src->rows; ++i) {
    memcpy(src->data[i], dst->data[i], src->cols);
  }
}

typedef struct {
  unsigned int rows;
  unsigned int cols;
  int** data;
} matrix_int;
void mi_free(matrix_int* mi) {
  if (mi->data) {
    unsigned int i;
    for (i = 0; i < mi->rows; ++i) {
      free(mi->data[i]);
    }
    free(mi->data);
  }
}
void mi_init(matrix_int* mi, unsigned int rows, unsigned int cols) {
  mi_free(mi);
  mi->rows = rows;
  mi->cols = cols;
  mi->data = (int**) malloc(rows * sizeof(int*));
  unsigned int i;
  for (i = 0; i < rows; ++i) {
    mi->data[i] = (int*) malloc(cols * sizeof(int));
  }
}
void mi_copy(matrix_int* src, matrix_int* dst) {
  mi_init(dst, src->rows, src->cols);
  unsigned int i;
  for (i = 0; i < src->rows; ++i) {
    memcpy(src->data[i], dst->data[i], src->cols);
  }
}

typedef struct {
  unsigned int rows;
  unsigned int cols;
  double** data;
} matrix_double;
void md_free(matrix_double* md) {
  if (md->data) {
    unsigned int i;
    for (i = 0; i < md->rows; ++i) {
      free(md->data[i]);
    }
    free(md->data);
  }
}
void md_init(matrix_double* md, unsigned int rows, unsigned int cols) {
  md->rows = rows;
  md->cols = cols;
  md->data = (double**) malloc(rows * sizeof(double*));
  unsigned int i;
  for (i = 0; i < rows; ++i) {
    md->data[i] = (double*) malloc(cols * sizeof(double));
  }
}
void md_copy(matrix_double* src, matrix_double* dst) {
  md_init(dst, src->rows, src->cols);
  unsigned int i;
  for (i = 0; i < src->rows; ++i) {
    memcpy(src->data[i], dst->data[i], src->cols);
  }
}

#endif

