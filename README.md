# parallel-programming
Implementar a multiplicação de matrizes multithreads com número de threads indexado.

## Descrição da atividade
Trabalho de Arquitetura de Computadores

1.  Implementar a multiplicação de matrizes multithreads com número de threads indexado. 
* Comparar o tempo de execução com a versão sequencial.
* Avaliar diferentes tamanhos de matrizes e quantidade de núcleos de forma a mostrar os cenários vantajosos e não vantajosos.
* Gráficos de comparação (Curvas).

2.  Fazer a versão OpenMP da multiplicação paralela de matrizes.

## Estrutura do repositório

```
parallel-programming
├── .venv/              # Ambiente virtual python
├── Codigos             # Códigos em C de programação sequencial, paralela e utlizando OpenMP. Contém os CSV dos resultados.
└── resultados.ipynb    # Resultados obtidos
```

- Para comparação é possível visualizar o resultado feito em um computador com menos threads, apenas clicando {aqui](https://github.com/RaffaellaSantos/parallel-programming/tree/Teste_8_Threads)

## Configurar e executar

### Executar o OpenMP
Na pasta onde está localizado o OpenMP:
```bash
gcc -fopenmp openmp.c -o openmp && ./openmp
```

### Ativar o ambiente virtual
```bash
python3 -m venv .venv # Criar o ambiente
source .venv/bin/activate # ativar o ambiente
pip install --upgrade pip # Garantir que o pip está atualizado
pip install ipykernel pandas numpy scipy matplotlib # Instala as bibliotecas necessárias para o projeto
```

## Recomendações

* Use Linux.
