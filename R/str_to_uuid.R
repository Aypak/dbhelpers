#' Convert a string to a uuid by inserting hyphens in the right places
#'
#' @param input_string A 32-character string to convert to a uuid
#'
#' @return A string formatted as a uuid
#' @export
#'
#' @examples
#' str_to_uuid("f3f6bf4b9c424b6fbd90bece1418a415")
#' str_to_uuid("3a126f041a9e4127978bb6544a099d0d")
str_to_uuid <- Vectorize(function(input_string) {
  uuid_string <- paste(stringr::str_sub(input_string, 1, 8), stringr::str_sub(input_string, 9, 12), stringr::str_sub(input_string, 13, 16), stringr::str_sub(input_string, 17, 20), stringr::str_sub(input_string, 21, 32), sep = "-")
  return(uuid_string)
})
