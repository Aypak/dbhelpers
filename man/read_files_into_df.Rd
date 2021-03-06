% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_files_into_df.R
\name{read_files_into_df}
\alias{read_files_into_df}
\title{Read files from a directory and bind them into a single \code{data.frame}}
\usage{
read_files_into_df(file_directory, file_pattern = "*.csv", ...)
}
\arguments{
\item{file_directory}{Name or path to the directory containing files of interest}

\item{file_pattern}{Regular expression to match the file names on. Default is "*.csv"}

\item{...}{Arbitrary args passed to \code{fread}}
}
\value{
A \code{data.frame} containing rows from the files in the directory.
}
\description{
Read files from a directory and bind them into a single \code{data.frame}
}
