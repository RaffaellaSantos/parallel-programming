#include <sys/time.h>
#include <stdio.h>

#define TAM_MATRIZ 10

int m1[TAM_MATRIZ][TAM_MATRIZ],
    m2[TAM_MATRIZ][TAM_MATRIZ],
    prod[TAM_MATRIZ][TAM_MATRIZ];

void main(void) {
    struct timeval start, end;
    long mtime, seconds, useconds;
    int i=0, j=0;

    for (i=0; i < TAM_MATRIZ; i++){
        for (j=0; j < TAM_MATRIZ; j++){
            m1[i][j] = i;
            m2[i][j] = 2;
            prod[i][j] = 0;
        }
    }

    gettimeofday(&start, NULL);

    for (i=0; i < TAM_MATRIZ; i++){
        for (j=0; j < TAM_MATRIZ; j++){
            for ( int x=0; x < TAM_MATRIZ; x++){
                prod[i][j] += m1[i][x] * m2[x][j];
            }
        }
    }

    gettimeofday(&end, NULL);

    seconds = end.tv_sec - start.tv_sec;
    useconds = end.tv_usec - start.tv_usec;
    mtime = ((seconds) * 1000 + useconds/1000.0) + 0.5;

    printf("Tempo transcorrido: %lu milisegundos\n", mtime);

    for (i=0; i < TAM_MATRIZ; i++){
        for (j=0; j < TAM_MATRIZ; j++){
            printf("%d", prod[i][j]);
        }
        printf("\n");
    }
}



