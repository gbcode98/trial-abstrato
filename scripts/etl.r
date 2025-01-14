# Carregar pacotes necessários
library(dplyr)
library(DBI)
library(RSQLite)
library(arrow)
library(ggplot2)
library(lubridate)

# Caminhos dos dados
sales_dir <- "data/sales/"
database_path <- "data/database.sqlite"
output_parquet <- "output/faturamento_agrupado.parquet"
output_plots <- "output/"

# Função: leitura dos dados de vendas
read_sales_data <- function(directory) {
  sales_files <- list.files(directory, pattern = "\\.csv$", full.names = TRUE)
  sales_data <- lapply(sales_files, read.csv)
  return(bind_rows(sales_data))
}

# Função: leitura das tabelas SQLite
read_sqlite_data <- function(database_path, table_name) {
  con <- dbConnect(RSQLite::SQLite(), database_path)
  data <- dbReadTable(con, table_name)
  dbDisconnect(con)
  return(data)
}

# Extração dos dados
sales_data <- read_sales_data(sales_dir)
products <- read_sqlite_data(database_path, "produtos")
categories <- read_sqlite_data(database_path, "categorias")

# Transformação dos dados
sales_data <- sales_data %>%
  mutate(faturamento = quantidade * preco_unitario) %>%
  mutate(data = as.Date(data))

consolidated_data <- sales_data %>%
  left_join(products, by = "produto_id") %>%
  left_join(categories, by = "categoria_id") %>%
  mutate(categoria = ifelse(is.na(nome_categoria), "Desconhecida", nome_categoria))

# Agregação
faturamento_por_categoria <- consolidated_data %>%
  group_by(categoria) %>%
  summarise(faturamento_total = sum(faturamento, na.rm = TRUE))

faturamento_mensal <- consolidated_data %>%
  mutate(mes = floor_date(data, "month")) %>%
  group_by(mes) %>%
  summarise(faturamento_mensal = sum(faturamento, na.rm = TRUE))

# Armazenamento
write_parquet(consolidated_data, output_parquet)

# Relatórios
ggplot(faturamento_por_categoria, aes(x = reorder(categoria, -faturamento_total), y = faturamento_total)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Faturamento por Categoria", x = "Categoria", y = "Faturamento Total") +
  theme_minimal() +
  ggsave(paste0(output_plots, "faturamento_por_categoria.png"))

ggplot(faturamento_mensal, aes(x = mes, y = faturamento_mensal)) +
  geom_line(color = "darkgreen", size = 1) +
  labs(title = "Evolução Mensal do Faturamento", x = "Mês", y = "Faturamento Mensal") +
  theme_minimal() +
  ggsave(paste0(output_plots, "evolucao_faturamento_mensal.png"))
