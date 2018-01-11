library(coindeskr)
context("get_currencies Output DF Check")

test_that("The output dataframe Type is ",{

        expect_equal(class(get_currency_list()),"data.frame")

})

context("get_current_price Output DF Check")

test_that("The output dataframe Type is ",{

        expect_equal(class(get_current_price()),"data.frame")

})

context("get_last31days_price Output DF Check")

test_that("The output dataframe Type is ",{

        expect_equal(class(get_last31days_price()),"data.frame")

})

context("get_historic_price Output DF Check")

test_that("The output dataframe Type is ",{

        expect_equal(class(get_historic_price()),"data.frame")

})
