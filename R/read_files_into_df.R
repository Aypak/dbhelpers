#' Read files from a directory and bind them into a single \code{data.frame}
#'
#' @param file_directory Name or path to the directory containing files of interest
#' @param file_pattern Regular expression to match the file names on. Default is "*.csv"
#' @param ... Arbitrary args passed to \code{fread}
#'
#' @return A \code{data.frame} containing rows from the files in the directory.
#' @export
#'
read_files_into_df <- function(file_directory, file_pattern = "*.csv", ...) {
  # Get a vector of all of the file names in a directory
  filenames <- list.files(file_directory, pattern = file_pattern, full.names = T)

  # Create a placeholder data frame
  placeholder_df <- data.frame()

  # Loop through the list of filenames
  for (i in 1:length(filenames)) {
    # Try to read each file
    tryCatch(
      {
        file <- data.table::fread(file = filenames[i], ...)
        # Check for duplicate columns and update the data type to character
        if (nrow(placeholder_df) > 0) {
          duplicate_cols <- intersect(colnames(file), colnames(placeholder_df))
          for (col in duplicate_cols) {
            if (class(file[[col]]) != class(placeholder_df[[col]])) {
              placeholder_df[[col]] <- as.character(placeholder_df[[col]])
              file[[col]] <- as.character(file[[col]])
            }
          }
        }
        # Bind the file read to the placeholder df, fill any missing columns with null
        placeholder_df <- plyr::rbind.fill(placeholder_df, file)
      },
      # If there is an error reading a file, print out the name of the file and the error
      error = function(e) {
        print(paste("An error occurred while reading file", filenames[i], ":", e))
      }
    )
  }

  # Return the completely bound df
  return(placeholder_df)
}
