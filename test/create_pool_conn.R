library(RPostgres)
library(pool)
library(dbplyr)
library(dplyr)


edu_config <- config::get(
  "central",
  file = paste0(here(),"/config.yml"))

# create database connection pool objects
edu_pool <- dbPool(
  drv = RPostgres::Postgres(),
  dbname = edu_config$database,
  host = edu_config$server,
  user = edu_config$uid,
  password = edu_config$pwd,
  port = edu_config$port
)
