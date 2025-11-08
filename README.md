# parallel-programming
Implementar a multiplicação de matrizes com PThreads, OpenMP e CUDA.

## Descrição da atividade
Trabalho de Arquitetura de Computadores

1.  Implementar a multiplicação de matrizes multithreads com número de threads indexado. 

2.  Fazer a versão OpenMP da multiplicação paralela de matrizes.

3.  Implementar a multiplicação de matrizes em GPU.
* Comparar o tempo de execução com a versão sequencial, paralela e OpenMP.
* Avaliar diferentes tamanhos de matrizes e quantidade de núcleos de forma a mostrar os cenários vantajosos e não vantajosos.
* Gráficos de comparação (Curvas).

## Estrutura do repositório

```
parallel-programming
├── Codigos             # Códigos em C de programação sequencial, paralela, paralela utlizando OpenMP, paralela em GPU. Contém os CSV dos resultados.
└── resultados.ipynb    # Resultados obtidos
```

- Para comparação é possível visualizar o resultado feito em um computador com menos threads, apenas clicando [aqui](https://github.com/RaffaellaSantos/parallel-programming/tree/Teste_8_Threads)

- Para ver os resultados utilizando CUDA clique [aqui](https://github.com/RaffaellaSantos/parallel-programming/tree/paralelo_cuda)

## Configurar e executar

### Executar o OpenMP
Na pasta onde está localizado o OpenMP:
```bash
gcc -fopenmp openmp.c -o openmp && ./openmp
```

### Executar o código com CUDA
```
nvcc -o parallelprogramming_cuda parallelprogramming_cuda.cu && ./parallelprogramming_cuda
```

### Configurações da máquina

* Sistema operacional: Microsoft Windows 11 Pro, Versão 10.0.26100
* Driver: Driver Game Ready - 576.83 - Wed Apr 16, 2025
* CPU: Intel(R) Core(TM) Ultra 7 155H
* 11 cores (22 threads)
* Memória RAM: 32.0 GB

Placa gráfica
* GPU: NVIDIA GeForce RTX 4060 Laptop GPU
* Núcleos CUDA: 3072
* Clock de gráficos: 2010 MHz
* Tecnologias Max-Q: Gen-5
* Memória de vídeo dedicada: 8188 MB GDDR6

* O código foi rodado em terminal utilizando o wsl (versão 2.4.13.0)

### Ativar o ambiente virtual
```bash
python3 -m venv .venv # Criar o ambiente
source .venv/bin/activate # ativar o ambiente
pip install --upgrade pip # Garantir que o pip está atualizado
pip install ipykernel pandas numpy scipy matplotlib # Instala as bibliotecas necessárias para o projeto
```

## Recomendações

* Use Linux.
* Consulte as documentações do [OpenMP](https://curc.readthedocs.io/en/latest/programming/OpenMP-C.html), [sub-rotina sysconf](https://www.ibm.com/docs/pt-br/aix/7.3.0?topic=s-sysconf-subroutine) e [CUDA](https://docs.nvidia.com/cuda)
