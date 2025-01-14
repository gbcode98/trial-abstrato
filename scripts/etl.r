# Carregar pacotes necessários
library(dplyr)
library(DBI)
library(RSQLite)
library(arrow)
library(ggplot2)
library(lubridate)

# Carregar funções auxiliares
source("scripts/utils.R")

# Caminhos dos dados
sales_dir <- "data/sales_/"
database_path <- "data/database.sqlite"
output_parquet <- "output_/faturamento_agrupado.parquet"
output_plots <- "output_/"

# Extração dos dados
sales_data <- read_sales_data(sales_dir)
products <- read_sqlite_data(database_path, "produtos")
categories <- read_sqlite_data(database_path, "categorias")

# Transformação dos dados
sales_data <- calculate_revenue(sales_data, "quantidade", "preco_unitario")

consolidated_data <- sales_data %>%
  left_join(products, by = "produto_id") %>%
  left_join(categories, by = "categoria_id") %>%
  handle_missing_categories("nome_categoria")

# Agregação
faturamento_por_categoria <- consolidated_data %>%
  group_by(categoria) %>%
  summarise(faturamento_total = sum(faturamento, na.rm = TRUE))

faturamento_mensal <- consolidated_data %>%
  mutate(mes = floor_date(data, "month")) %>%
  group_by(mes) %>%
  summarise(faturamento_mensal = sum(faturamento, na.rm = TRUE))

# Armazenamento
save_as_parquet(consolidated_data, output_parquet)

# Relatórios
plot1 <- ggplot(faturamento_por_categoria, aes(x = reorder(categoria, -faturamento_total), y = faturamento_total)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Faturamento por Categoria", x = "Categoria", y = "Faturamento Total") +
  theme_minimal()

save_plot(plot1, paste0(output_plots, "faturamento_por_categoria.png"))

plot2 <- ggplot(faturamento_mensal, aes(x = mes, y = faturamento_mensal)) +
  geom_line(color = "darkgreen", size = 1) +
  labs(title = "Evolução Mensal do Faturamento", x = "Mês", y = "Faturamento Mensal") +
  theme_minimal()

save_plot(plot2, paste0(output_plots, "evolucao_faturamento_mensal.png"))
