# dbhelpers
> Helper functions to make working with databases a bit smoother

<!-- badges: start -->
[![R build status](https://github.com/Aypak/dbhelpers/workflows/R-CMD-check/badge.svg)](https://github.com/Aypak/dbhelpers/actions)
<!-- badges: end -->

## Overview

This package provides some functions to help work with (mostly PostgreSQL) databases, and to help clean your data.
(This package has not yet been listed on CRAN)

Installation :
```r
# Download latest release zip file
install.packages("<release zip file>",repos = NULL)

# From Github
# install.packages("devtools")
devtools::install_github("Aypak/dbhelpers")
```

## Functions available :
- [read_files_into_df](#read_files_into_df)
- [create_lazy_conn](#create_lazy_conn)
- [lazy_conn_all_tables](#lazy_conn_all_tables)
- [get_first_name](#get_first_name)
- [get_last_name](#get_last_name)


####read_files_into_df
Read multiple files from a directory into a single dataframe. Essentially binding the contents of the files and filling missing columns with NA.
e.g
```r
raw_data <- read_files_into_df(file_directory="raw_csv_files",file_pattern="*.csv")
```

####create_lazy_conn
Create a connection to a database table using a database pool object. The connection is exactly like a pool connection. It does not retreive any data until it is explicitly called. 

#####Example: 
Assume there is a [pool connection](https://db.rstudio.com/pool) to a PostgreSQL database called books_conn in the workspace.  
In the public schema, the database contains the tables:  
users,books,transactions

```r
# If we want to create a connection to the users table
users <- create_lazy_conn(books_conn, schemaname = "public", "users")
```

####lazy_conn_all_tables
Create connections the same as the [create_lazy_conn](#create_lazy_conn) function for all tables in a specified schema. The connections will have the same names as the tables they are connected to. 

Following the example above:
```r
# create connections to all tables in the public schema in the global environment
lazy_conn_all_tables(books_conn,schemaname = "public", prefix = "", env = globalenv())

# This will create the connection objects: users, books, transactions
```

####get_first_name
Get the first name from a full name separated by spaces 
e.g
```r
get_first_name("John Banda")
# [1] "John"
```

####get_last_name
Get the last name from a full name separated by spaces. If there are middle names, all of the middle names and last name will be taken as the last name. 
e.g
```r
get_last_name("John Bewzani Banda")
# [1] "Bewzani Banda"
```
