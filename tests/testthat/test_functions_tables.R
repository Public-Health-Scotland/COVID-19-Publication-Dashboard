# Test the format_entry function from shiny_app/functions/functions_tables.R

test_that("Formatting table entries works", {
  expect_equal(format_entry("1,000"), "1,000")
  expect_equal(format_entry(1000), "1,000")
  expect_equal(format_entry(1000, dp=4), "1,000.0000")
  expect_equal(format_entry("hi"), "hi")
  expect_equal(format_entry(85.284, perc=T, dp=1), "85.3%")
})