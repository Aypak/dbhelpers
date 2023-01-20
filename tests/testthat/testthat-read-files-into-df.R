temp_dir <- tempdir()


# Create test files
write.csv(data.frame(col1 = 1:5, col2 = 6:10), file = paste0(temp_dir,"/test1.csv"), row.names = F)
write.csv(data.frame(col1 = 1:5, col2 = 6:10), file = paste0(temp_dir,"/test2.csv"), row.names = F)
write.csv(data.frame(col1 = 1:5, col3 = 6:10), file = paste0(temp_dir,"/test3.csv"), row.names = F)


# Test that the function correctly binds together all files in a directory
test_that("read_files_into_df correctly binds together all files in a directory", {
  df <- read_files_into_df(file_directory = temp_dir, file_pattern = "^test[[:alnum:]]+.csv")
  expect_equal(nrow(df), 15)
  expect_equal(ncol(df), 3)
})

#Test that the function correctly updates the data type of the columns
test_that("read_files_into_df correctly updates the data type of the columns", {
  df <- read_files_into_df(temp_dir, file_pattern = "^test[[:alnum:]]+.csv")
  expect_equal(class(df$col1[1]), "integer")
  expect_equal(class(df$col2[1]), "integer")
})
