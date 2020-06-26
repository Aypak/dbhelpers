#'
#' Create a lazy connection to a table in a schema
#'
#' @param pool_conn A pool connection to a PostgreSQL database
#' @param schemaname The schema from which to get the tables. Default is public
#' @param tablename The name of the table to create the connection to
#' @return A pool connection object
#'
#' @export
#'
#' @import dplyr
#'
create_lazy_conn <- function(pool_conn, schemaname = "public", tablename){
  lazy_conn <- pool_conn %>% dplyr::tbl(dbplyr::in_schema(schemaname, tablename))
  return(lazy_conn)
}
