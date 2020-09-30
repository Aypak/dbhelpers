#'
#' Get data from all tables in a schema. Each as a separate \code{data.frame}
#'
#' @param pool_conn A pool connection to a PostgreSQL database
#' @param schemaname The schema from which to get the tables. Default is public
#' @param prefix String to prefix the variables with
#' @param env The environment in which to create the variables. Default is global environment
#'
#' @return A \code{data.frame} for each of the tables in the specified schema
#'
#' @export
#'
#'
get_all_tables_data <- function(pool_conn,schemaname = "public", prefix = "", env = globalenv()){
  # Create vector of the table names using the connection and schema passed in
  table_names <- pool_conn %>%
    # table names are found in the information schema on postgres
    dplyr::tbl(dbplyr::in_schema("information_schema","tables")) %>%
    # filter out entries of table type BASE TABLE
    dplyr::filter(table_schema == schemaname, table_type == "BASE TABLE") %>%
    # pull out the table name column
    dplyr::pull(table_name)

  # Walk through the vector above and apply the get_table_data method to each table
  # Create variable in the environment specified
  # Add the optional prefix to each variable name
  purrr::walk(table_names,
              ~assign(
                envir = env,
                x = paste0(prefix,.),
                value = get_table_data(pool_conn,schemaname,.)
              )
  )
}
