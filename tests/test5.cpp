#include <stdio.h>

void foo() {
  int a[100][100][100];

  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 10; j++) {
      for (int k = 0; k < 10; k++) {
        a[i + 70][j + 69][k + 1] = a[i][j + 67][k] + a[i][j][k] + a[i + 70][j][k];
        a[i + 80][j + 89][k + 3] = a[i][j + 87][k] + 2;
      }
    }
  }
}

  int main() { return 0; }
