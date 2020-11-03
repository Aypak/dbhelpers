#' Get the mode from a vector
#'
#' @param v A vector
#'
#' @return A vector containing the most frequent value in a vector.
#' If there is a tie, the top values will be returned.
#' R currently has no built-in function to get mode
#'
#' @export
#'
#' @examples
#' hps <- mtcars$hp
#' getmode(hps)
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}
