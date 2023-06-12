#' Create a pool connection to a PostgreSQL database either using a config file or environment variables
#' If both exist, config file is given priority
#'
#' @param config_file A yml config file with database credentials. Default is \code{config.yml} in root of project
#' @param config_value The set of config vars to use from the config file
#' @param envars_prefix The prefix of the environment variables to use to connect
#' @param ... Arguments passed to config::get
#'
#' @return A database connection object
#' @export
#'
connect_to_pg <- function(config_file = here::here("config.yml"), config_value = "default", envars_prefix = "DEFAULT_DATABASE_", ...) {
  if (file.exists(config_file)) {
    # fetch config vars from file
    config_vars <- config::get(value = config_value, file = config_file, ...)
    db_name <- config_vars$database
    db_host <- config_vars$server
    db_user <- config_vars$uid
    db_passwd <- config_vars$pwd
    db_port <- config_vars$port
  } else {
    # If config file does not exist
    # Attempt to get config vars from environment variables
    db_name <- Sys.getenv(paste0(envars_prefix, "NAME"))
    db_host <- Sys.getenv(paste0(envars_prefix, "HOST"))
    db_user <- Sys.getenv(paste0(envars_prefix, "USER"))
    db_passwd <- Sys.getenv(paste0(envars_prefix, "PASSWORD"))
    db_port <- Sys.getenv(paste0(envars_prefix, "PORT"))
  }

  # create database connection pool object
  db_conn <- pool::dbPool(
    drv = RPostgres::Postgres(),
    dbname = db_name,
    host = db_host,
    user = db_user,
    password = db_passwd,
    port = db_port
  )

  return(db_conn)
}
