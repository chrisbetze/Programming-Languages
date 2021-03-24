//Για την γραφή του κώδικα χρησιμοποιήθηκαν στοιχεία από τον αντίστοιχο κώδικα που παρουσιάστηκε στο μάθημα σε γλώσσα Python

#include <stdio.h>
#include <stdlib.h>

int main (int argc, char **argv) {
  int i=0, j=0, z, N, K;
  FILE *inputs;

  inputs = fopen(argv[1], "r");
  fscanf(inputs, "%d %d", &N, &K);

  int answer=N+1, color[N], appearances_of_color[K];

  for (z=0; z<N; z++) {
    fscanf(inputs, "%d", &color[z]);
  }

  for (z=0; z<K; z++) {
    appearances_of_color[z]=0;
  }

  int counter_of_zero_elements=K;

  while (j<N || counter_of_zero_elements==0) {
    if (counter_of_zero_elements>0) {
      if (appearances_of_color[color[j]-1]==0) {
        counter_of_zero_elements -= 1;
      }

      appearances_of_color[color[j]-1] += 1;
      j += 1;
    }
    else {
      if (j-i<answer) {
        answer = j-i;
      }

      appearances_of_color[color[i]-1] -= 1;

      if (appearances_of_color[color[i]-1]==0) {
        counter_of_zero_elements += 1;
      }

      i += 1;
    }
  }

  if (answer==N+1) {
    printf("0\n");
  }
  else {
    printf("%d\n", answer);
  }
  return 0;
}
