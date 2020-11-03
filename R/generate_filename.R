#'
#' Generate a file name for a report
#'
#' @param reports_dir Directory to prefix the report name with. Default is ~/.reports/
#' @param report_name Name of the report
#' @param date Date of the report
#' @param module Module of the report
#' @param separator Separator between the inputs. Default is "_"
#' @param extension File extension. Default is ".csv"
#' @param device_name Name of the device the report comes from
#' @return A string containing the generated file name in the format:
#'   reports_dir sep
#'   device_name sep
#'   report_name sep
#'   module sep
#'   date
#'   extension
#'
#'   e.g ~/.reports/monthend_KRP_numeracy_06-20.csv
#'
#' @export
#'
#' @examples
#' generate_filename(
#'   report_name = "monthend",
#'   date = "06-20",
#'   module = "numeracy",
#'   device_name = "KRP"
#' )
#'
#' generate_filename(
#'   report_name = "alldata",
#'   date = "06-20",
#'   module = "literacy",
#'   device_name = "DRY"
#' )
generate_filename <- function(reports_dir = "~/.reports/",
                              report_name,
                              date,
                              module,
                              extension = ".csv",
                              device_name,
                              separator = "_") {
  # Generate file name from argumentss above
  filename <- paste0(reports_dir, report_name) %>%
    paste(device_name,
      module,
      date,
      sep = separator
    ) %>%
    # Call paste0 to add the extension
    paste0(extension)

  # Return the final file name
  return(filename)
}
