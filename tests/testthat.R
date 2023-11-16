# This file is part of the standard setup for testthat.
# It is recommended that you do not modify it.
#
# Where should you do additional test configuration?
# Learn more about the roles of various files in:
# * https://r-pkgs.org/testing-design.html#sec-tests-files-overview
# * https://testthat.r-lib.org/articles/special-files.html

library(testthat)
library(LinearModel.new)

test_check("LinearModel.new")

test_that("LinearReg performs simple linear regression correctly", {
  data(USArrests)
  new_model <- LinearReg(Murder ~ UrbanPop, data = USArrests)
  lm_model <- lm(Murder ~ UrbanPop, data = USArrests)
  lm_summary <- summary(lm_model)
  expect_equal(custom_model$std_error_betahat, coef(summary(lm_model))[, "Std. Error"], tolerance = 1e-5)
  expect_equal(custom_model$t_statistic, coef(summary(lm_model))[, "t value"], tolerance = 1e-5)
  expect_equal(custom_model$p_value, coef(summary(lm_model))[, "Pr(>|t|)"], tolerance = 1e-5)
  expect_equal(custom_model$r_squared, lm_summary$r.squared, tolerance = 1e-5)
  expect_equal(custom_model$adj_r_squared, lm_summary$adj.r.squared, tolerance = 1e-5)
  expect_equal(custom_model$F_statistic, lm_summary$fstatistic[1], tolerance = 1e-5)
  expect_equal(custom_model$p_value_F, pf(lm_summary$fstatistic[1], lm_summary$fstatistic[2], lm_summary$fstatistic[3], lower.tail = FALSE), tolerance = 1e-5)
  expect_equal(custom_model$estimate_betahat, coef(lm_model), tolerance = 1e-5)
})
