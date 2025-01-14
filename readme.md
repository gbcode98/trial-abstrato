## ETL e Análise de Dados com R
Este projeto implementa um pipeline de dados completo para processar informações de vendas e produtos, integrando dados de arquivos CSV e de um banco de dados SQLite. O objetivo é consolidar, transformar e analisar os dados, gerando relatórios úteis para a tomada de decisões de negócios.

```
├── data/
│   ├── sales/            # Diretório contendo os arquivos CSV de vendas
│   ├── database.sqlite   # Banco de dados SQLite com informações de produtos e categorias
├── scripts/
│   ├── etl.R             # Script principal para o pipeline de ETL
│   ├── utils.R           # Funções auxiliares utilizadas no projeto
├── output/
│   ├── faturamento_agrupado.parquet # Arquivo parquet com os dados transformados
│   ├── faturamento_por_categoria.png # Gráfico de faturamento por categoria
│   ├── evolucao_faturamento_mensal.png # Gráfico de evolução mensal do faturamento
├── README.md             # Documentação do projeto

```