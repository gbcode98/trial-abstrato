
# **ETL e Análise de Dados com R**

Este projeto implementa um pipeline de dados completo para processar informações de vendas e produtos, integrando dados de arquivos CSV e de um banco de dados SQLite. O objetivo é consolidar, transformar e analisar os dados, gerando relatórios úteis para a tomada de decisões de negócios.


## **Estrutura do Projeto**

```plaintext
├── data/
│   ├── sales/            # Diretório contendo os arquivos CSV de vendas
│   ├── database.sqlite   # Banco de dados SQLite com informações de produtos e categorias
├── scripts/
│   ├── etl.R             # Script principal para o pipeline de ETL
│   ├── utils.R           # Funções auxiliares utilizadas no projeto
├── output/
│   ├── faturamento_agrupado.parquet   # Arquivo parquet com os dados transformados
│   ├── faturamento_por_categoria.png  # Gráfico de faturamento por categoria
│   ├── evolucao_faturamento_mensal.png  # Gráfico de evolução mensal do faturamento
├── README.md             # Documentação do projeto
```

---

## **Funcionalidades**

1. **Extração de Dados**:
   - Leitura de múltiplos arquivos CSV contendo dados de vendas.
   - Integração com um banco de dados SQLite para recuperar informações de produtos e categorias.

2. **Transformação de Dados**:
   - Cálculo do faturamento por produto.
   - Consolidação de dados de vendas, produtos e categorias.
   - Tratamento de valores ausentes, como produtos sem categoria.

3. **Armazenamento de Dados**:
   - Salvamento dos dados transformados em formato **Parquet**.
   - Criação de tabelas no SQLite, se necessário.

4. **Geração de Relatórios**:
   - Gráfico de barras: **Faturamento por categoria de produto**.
   - Gráfico de linha: **Evolução do faturamento mensal**.

---

## **Requisitos**

Certifique-se de ter os seguintes pacotes instalados no R:

```r
install.packages(c("dplyr", "DBI", "RSQLite", "arrow", "ggplot2", "lubridate"))
```

---

## **Como Executar**

1. Clone o repositório:
   ```bash
   git clone <https://github.com/gbcode98/trial-abstrato>
   cd <trial-abstrato>
   ```

2. Coloque os arquivos CSV de vendas no diretório `data/sales/`.

3. Certifique-se de que o arquivo `database.sqlite` esteja em `data/` com as tabelas necessárias.

4. Execute o script principal `etl.R` no RStudio ou na linha de comando:
   ```r
   source("scripts/etl.R")
   ```

5. Os resultados (dados transformados e gráficos) estarão disponíveis na pasta `output/`.

---

## **Estrutura dos Dados**

### **Arquivos CSV de Vendas**
Cada arquivo de vendas deve conter as seguintes colunas:

| Coluna          | Descrição                   |
|------------------|-----------------------------|
| data            | Data da venda (YYYY-MM-DD)  |
| loja_id         | Identificador da loja       |
| produto_id      | Identificador do produto    |
| quantidade      | Quantidade vendida          |
| preco_unitario  | Preço unitário do produto   |

### **Banco de Dados SQLite**
O banco de dados contém duas tabelas:

#### **Tabela `produtos`**
| Coluna        | Descrição                          |
|---------------|------------------------------------|
| produto_id    | Identificador único do produto     |
| nome_produto  | Nome do produto                   |
| categoria_id  | Identificador da categoria         |

#### **Tabela `categorias`**
| Coluna          | Descrição                          |
|------------------|------------------------------------|
| categoria_id     | Identificador único da categoria  |
| nome_categoria   | Nome da categoria                |

---

## **Gráficos Gerados**

1. **Faturamento por Categoria**  
   ![Faturamento por Categoria](output/faturamento_por_categoria.png)

2. **Evolução do Faturamento Mensal**  
   ![Evolução do Faturamento Mensal](output/evolucao_faturamento_mensal.png)

---

## **Autor**

**gbcode98**  
[LinkedIn](https://www.linkedin.com/in/gabriel-carlos-3312b21b9/) | [GitHub](https://github.com/gbcode98)
