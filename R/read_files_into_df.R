#' Read files from a directory and bind them into a single \code{data.frame}
#'
#' @param file_directory Name or path to the directory containing files of interest
#' @param file_pattern Regular expression to match the file names on. Default is "*.csv"
#' @param ... Arbitrary args passed to readr
#'
#' @return A \code{data.frame} containing rows from the files in the directory.
#' @export
#'
read_files_into_df <- function(file_directory, file_pattern = "*.csv",...) {
  # Create a placeholder data frame
  placeholder_df <- data.frame()

  # Get a vector of all of the file names in a directory
  filenames <- list.files(
    file_directory,
    pattern = file_pattern,
    full.names = T
  )

  # Loop through the list of files
  for (i in 1:length(filenames)) {
    # Read each file and bind it to the placeholder df
    file <- data.table::fread(file = filenames[i],...)
    placeholder_df <- placeholder_df %>% plyr::rbind.fill(file)
  }

  # Return placeholder df
  return(placeholder_df)
}
