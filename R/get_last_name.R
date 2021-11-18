#'
#' Get the last name from a full name
#'
#' @param full_name The full name from which to extract the last name
#' @return A string containing the last name. All names after the first name will be taken as the last name
#' @export
#' @examples
#' get_last_name("John Nsombo")
#' get_last_name("Jorgen Von Straggle")
get_last_name <- Vectorize(function(full_name) {
  {
    # if the full name is blank or there is only one name
    if (nchar(full_name) == 0 || length(strsplit(full_name, " ")[[1]]) == 1) {
      last_name <- ""
    }

    else {
      last_name <- paste(strsplit(full_name, " ")[[1]][-1], collapse = " ")
    }
    return(last_name)
  }
})
