# Função para leitura de múltiplos arquivos CSV de um diretório
read_sales_data <- function(directory) {
  sales_files <- list.files(directory, pattern = "\\.csv$", full.names = TRUE)
  sales_data <- lapply(sales_files, read.csv)
  return(bind_rows(sales_data))
}

# Função para leitura de tabelas de uma base de dados SQLite
read_sqlite_data <- function(database_path, table_name) {
  con <- dbConnect(RSQLite::SQLite(), database_path)
  data <- dbReadTable(con, table_name)
  dbDisconnect(con)
  return(data)
}

# Função para tratar valores ausentes em categorias
handle_missing_categories <- function(data, category_column, default_value = "Desconhecida") {
  data <- data %>%
    mutate(!!category_column := ifelse(is.na(.data[[category_column]]), default_value, .data[[category_column]]))
  return(data)
}

# Função para calcular faturamento por produto
calculate_revenue <- function(data, quantity_column, price_column) {
  data <- data %>%
    mutate(faturamento = .data[[quantity_column]] * .data[[price_column]])
  return(data)
}

# Função para salvar dados em formato Parquet
save_as_parquet <- function(data, output_path) {
  write_parquet(data, output_path)
}

# Função para salvar gráficos
save_plot <- function(plot, output_path) {
  ggsave(output_path, plot = plot, width = 8, height = 6)
}
