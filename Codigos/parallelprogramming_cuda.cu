# include <sys/time.h>
# include <stdio.h>
# include <stdlib.h>
#include <unistd.h>

int TAM_MATRIZES[] = {10, 20, 40, 80, 160, 320, 640, 1280, 2560, 5120};
int num_tam = sizeof(TAM_MATRIZES) / sizeof(TAM_MATRIZES[0]);


// Corpo da Thread
__global__ void Prod_Matriz(int *m1, int *m2, int *prod, int TAM_MATRIZ) {
    
    int linha = blockIdx.y * blockDim.y + threadIdx.y;
    int coluna = blockIdx.x * blockDim.x + threadIdx.x;

    if(linha < TAM_MATRIZ && coluna < TAM_MATRIZ) {
        int soma = 0;
        for (int k = 0; k < TAM_MATRIZ; k++) {
            soma += m1[linha * TAM_MATRIZ + k] * m2[k * TAM_MATRIZ + coluna];
        }
        prod[linha * TAM_MATRIZ + coluna] = soma;
    }
}

int main() {
    struct timeval start, end;
    long mtime, seconds, useconds;

    FILE *file = fopen("resultados_paralelo_cuda.csv", "w");
    if(file == NULL){
        printf("Erro ao abrir arquivo!");
    }

    fprintf(file, "\xEF\xBB\xBF");
    fprintf(file, "Tamanho da matriz, Tempo (milisegundos)\n");
    
    for (int i=0; i < num_tam; i++){
        int TAM_MATRIZ = TAM_MATRIZES[i];

        size_t tamBytes = TAM_MATRIZ * TAM_MATRIZ * sizeof(int);

        // Declaração das matrizes
        int *h_m1 = (int*)malloc(tamBytes);
        int *h_m2 = (int*)malloc(tamBytes);
        int *h_prod = (int*)malloc(tamBytes);

        int *d_m1, *d_m2, *d_prod;
        cudaMalloc((void**)&d_m1, tamBytes);
        cudaMalloc((void**)&d_m2, tamBytes);
        cudaMalloc((void**)&d_prod, tamBytes);

        // Inicializando matrizes
        for (int j=0; j < TAM_MATRIZ; j++){
            for (int k=0; k < TAM_MATRIZ; k++){
                h_m1[j * TAM_MATRIZ + k] = j;
                h_m2[j * TAM_MATRIZ + k] = 2;
                h_prod[j * TAM_MATRIZ + k] = 0;
            }
        }

        cudaMemcpy(d_m1, h_m1, tamBytes, cudaMemcpyHostToDevice);
        cudaMemcpy(d_m2, h_m2, tamBytes, cudaMemcpyHostToDevice);
        cudaMemcpy(d_prod, h_prod, tamBytes, cudaMemcpyHostToDevice);

        dim3 threadsPerBlock(16, 16);
        dim3 blocksPerGrid(
            (TAM_MATRIZ + threadsPerBlock.x - 1) / threadsPerBlock.x,
            (TAM_MATRIZ + threadsPerBlock.y - 1) / threadsPerBlock.y
        );

        // Inicio do tempo
        gettimeofday(&start, NULL);

        Prod_Matriz<<<blocksPerGrid, threadsPerBlock>>>(d_m1, d_m2, d_prod, TAM_MATRIZ);

        cudaMemcpy(h_prod, d_prod, tamBytes, cudaMemcpyDeviceToHost);

        // Final do tempo
        gettimeofday(&end, NULL);

        // Tempo final
        seconds = end.tv_sec - start.tv_sec;
        useconds = end.tv_usec - start.tv_usec;
        mtime = ((seconds) * 1000 + useconds/1000.0) + 0.5;

        
        fprintf(file, "%d, %lu\n", TAM_MATRIZ, mtime);

        // Exibir tempo e matriz produto
        printf("Tempo para a matriz: %d\n", TAM_MATRIZ);
        printf("Tempo transcorrido: %lu milisegundos\n", mtime);

        // for (int row = 0; row < TAM_MATRIZ; row++) {
        //     free(h_m1[row]);
        //     free(h_m2[row]);
        //     free(h_prod[row]);
        //     cudaFree(d_m1[row]);
        //     cudaFree(d_m2[row]);
        //     cudaFree(d_prod[row]);
        // }
        free(h_m1);
        free(h_m2);
        free(h_prod);
        cudaFree(d_m1);
        cudaFree(d_m2);
        cudaFree(d_prod);
    }
    fclose(file);
    return 0;
}