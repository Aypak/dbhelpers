#'
#' Get the first name from a full name
#'
#' @param full_name The full name from which to extract the first name
#' @return A string containing the first name
#' @export
#' @examples
#' get_first_name("John Nsombo")
#' get_first_name("Jorgen Von Straggle")

get_first_name <- function(full_name) {
  if(nchar(full_name) == 0 || length(strsplit(full_name, ' ')[[1]]) == 1){
    first_name <- ''
  }
  else{
    first_name <- paste(strsplit(full_name,' ')[[1]][1],collapse = ' ')
  }
  return(toString(first_name))
}
