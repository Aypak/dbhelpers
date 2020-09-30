#'
#' Create lazy connections to all tables in a schema as separate variables
#'
#' @param pool_conn A pool connection to a PostgreSQL database
#' @param schemaname The schema from which to get the tables. Default is public
#' @param prefix String to prefix the variables with
#' @param env The environment in which to create the variables. Default is global environment
#'
#' @return Variables for lazy connections to each of the tables in the environment specified
#'
#' @export
#'
#'
lazy_conn_all_tables <- function(pool_conn,schemaname = "public", prefix = "", env = globalenv()){
  # Create vector of the table names using the connection and schema passed in
  table_names <- pool_conn %>%
    # table names are found in the information schema on postgres
    dplyr::tbl(dbplyr::in_schema("information_schema","tables")) %>%
    # filter out entries of table type BASE TABLE
    dplyr::filter(table_schema == schemaname, table_type == "BASE TABLE") %>%
    # pull out the table name column
    dplyr::pull(table_name)

  # Walk through the vector above and apply the create_lazy_conn method to each table
  # Create variable in the environment specified
  # Add the optional prefix to each variable name
  purrr::walk(table_names,
       ~assign(
         envir = env,
         x = paste0(prefix,.),
         value = create_lazy_conn(pool_conn,schemaname,.)))
}
