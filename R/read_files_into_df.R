#' Read files from a directory and bind them into a single \code{data.frame}
#'
#' @param file_directory Path to the directory containing files of interest
#' @param file_pattern File pattern or regular expression to match the file names on. Supported file types are csv, xlsx, and xls
#' @param files_recursive Boolean. Search for files recursively in the current directory or not. Default is FALSE
#' @param clean_names Boolean. Use \code{janitor::clean_names()} on the data as it is being read. Default is FALSE
#' @param ... Arbitrary args passed to \code{fread}
#'
#' @return A \code{data.frame} containing rows from the files in the directory.
#' @export
#'
read_files_into_df <- function(file_directory, file_pattern = rebus::or("*.csv", "*.xlsx", "*.xls"), files_recursive = FALSE, clean_names = FALSE, ...) {
  # get all the files in the directory
  filenames <- list.files(file_directory, pattern = file_pattern, full.names = TRUE, recursive = files_recursive)

  # create an empty dataframe to hold the combined data
  combined_data <- data.frame()

  # loop through each file and read it into a dataframe
  for (i in 1:length(filenames)) {
    # try to read the file as csv or excel
    tryCatch(
      {
        # read the file as csv if it matches the csv pattern
        if (grepl(".csv", filenames[i])) {
          file_data <- data.table::fread(file = filenames[i], ...)
        }
        # read the file as excel if it matches the excel pattern
        else if (grepl(".xlsx|.xls", filenames[i])) {
          file_data <- readxl::read_excel(filenames[i], ...)
        }
        # throw an error if the file does not match either pattern
        else {
          stop(paste("File type not supported:", filenames[i]))
        }

        # Check for duplicate columns and update the data type to character
        if (nrow(combined_data) > 0) {
          duplicate_cols <- intersect(colnames(file), colnames(combined_data))
          for (col in duplicate_cols) {
            if (class(file[[col]]) != class(combined_data[[col]])) {
              combined_data[[col]] <- as.character(combined_data[[col]])
              file[[col]] <- as.character(file[[col]])
            }
          }
        }

        if (isTRUE(clean_names)) {
          file_data <- file_data %>% janitor::clean_names()
        }

        combined_data <- plyr::rbind.fill(combined_data, file_data)
      },
      error = function(e) {
        # print an error message if the file cannot be read
        print(paste("An error occurred while reading file", filenames[i], ":", e))
      }
    )
  }

  # fill any uncommon columns with NA
  all_columns <- unique(names(combined_data))
  for (col in all_columns) {
    if (!(col %in% names(combined_data))) {
      combined_data[[col]] <- NA
    }
  }

  # return the combined data
  return(combined_data)
}
