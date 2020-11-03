#'
#' Get data from a database table as a \code{data.frame}
#'
#' @param pool_conn A pool connection to a PostgreSQL database
#' @param schemaname The schema from which to get the tables. Default is public
#' @param tablename The name of the table to create the connection to
#' @return A \code{data.frame} containing the data in the specified table
#'
#' @export
#'
#' @import dplyr
#'
get_table_data <- function(pool_conn, schemaname = "public", tablename) {
  table_data <- pool_conn %>%
    dplyr::tbl(dbplyr::in_schema(schemaname, tablename)) %>%
    collect()
  return(table_data)
}
