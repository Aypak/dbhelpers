# set up a test directory with sample csv and excel files
temp_dir <- tempdir()

# create a sample csv file
csv_data <- data.frame(A = c(1, 2, 3), B = c("a", "b", "c"), stringsAsFactors = FALSE)
# row.names(csv_data) <- c("1", "2", "3")
write.csv(csv_data, file = paste0(temp_dir, "/test_csv.csv"), row.names = FALSE)

# create a sample excel file
excel_data <- data.frame(C = c(4, 5, 6), D = c("d", "e", "f"), stringsAsFactors = FALSE)
# row.names(excel_data) <- c("4", "5", "6")
xlsx::write.xlsx(excel_data, file = paste0(temp_dir, "/test_excel.xlsx"), row.names = FALSE)

# run the read_files function on the test directory
test_data <- read_files_into_df(file_directory = temp_dir)
# row.names(test_data) <- NULL
# row.names(excel_data) <- NULL
# row.names(csv_data) <- NULL

# check if the combined data has the correct number of rows and columns
expect_equal(nrow(test_data), 6)
expect_equal(ncol(test_data), 4)

# check if the combined data has the correct column names
expect_true(all(names(test_data) %in% c("A", "B", "C", "D")))

# check if the csv data was read correctly
expect_equal(test_data[1:3, c("A", "B")], csv_data, check.attributes = FALSE)

# check if the excel data was read correctly
expect_equal(test_data[4:6, c("C", "D")], excel_data, check.attributes = FALSE)

unlink(temp_dir)
