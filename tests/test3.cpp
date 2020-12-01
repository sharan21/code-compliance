#include <stdio.h>

void foo() {
  int a[100][100];

  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 10; j++) {

      a[i + 70][j + 69] = a[i][j + 67] + 1;
      a[i + 80][j + 89] = a[i][j + 87] + 2;
    }
  }
}

int main() { return 0; }