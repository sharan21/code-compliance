#include <stdio.h>

using namespace std;

void foo() {
  int a[100];
  int b[100];

  int t;

  for (int i = 0; i < 10; i++) {

    a[i + 3] = a[i + 1] + 1;
    b[i + 3] = b[i + 1] + 1;

    t = i + 5;

  }
}

int main() { return 0; }