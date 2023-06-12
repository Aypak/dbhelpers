# Test case 1: Valid input string
test_that("str_to_uuid converts valid input string to uuid", {
  input_string <- "f3f6bf4b9c424b6fbd90bece1418a415"
  expected_output <- "f3f6bf4b-9c42-4b6f-bd90-bece1418a415"
  result <- str_to_uuid(input_string)
  expect_equal(result, expected_output, check.attributes = FALSE)
})

# Test case 2: Valid input string with different characters
test_that("str_to_uuid converts valid input string with different characters to uuid", {
  input_string <- "3a126f041a9e4127978bb6544a099d0d"
  expected_output <- "3a126f04-1a9e-4127-978b-b6544a099d0d"
  result <- str_to_uuid(input_string)
  expect_equal(result, expected_output, check.attributes = FALSE)
})

# Test case 3: Invalid input string (less than 32 characters)
test_that("str_to_uuid throws an error for an input string with less than 32 characters", {
  input_string <- "f3f6bf4b9c424b6fbd90bece1418a41"
  expect_error(str_to_uuid(input_string), "Input string must have 32 characters")
})

# Test case 4: Invalid input string (more than 32 characters)
test_that("str_to_uuid throws an error for an input string with more than 32 characters", {
  input_string <- "f3f6bf4b9c424b6fbd90bece1418a415d"
  expect_error(str_to_uuid(input_string), "Input string must have 32 characters")
})
