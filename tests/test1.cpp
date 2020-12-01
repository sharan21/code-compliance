#include <stdio.h>

void foo() {
  int a[100];

  for (int i = 0; i < 10; i++) {
    a[i + 3] = a[i + 1];
  }
}

int main() { return 0; }