library(testthat)
library(LinearModel.new)

test_that("LinearReg performs simple linear regression correctly", {
  new_model1 <- LinearReg(Murder ~ UrbanPop, data = USArrests)
  lm_model1 <- lm(Murder ~ UrbanPop, data = USArrests)
  lm_summary1 <- summary(lm_model1)
  residuals <- lm_model1$residuals
  residuals_min <- min(residuals)
  residuals_1Q <- quantile(residuals, prob = 0.25)
  residuals_median <- median(residuals)
  residuals_3Q <- quantile(residuals, 0.75)
  residuals_max <- max(residuals)
  expect_equal(new_model1$Residuals$Residual_Min[[1]],
               residuals_min,
               tolerance = 1e-5)
  expect_equal(new_model1$Residuals$Residual_1Q[[1]],
               unname(residuals_1Q["25%"]),
               tolerance = 1e-5)
  expect_equal(new_model1$Residuals$Residual_Median[[1]],
               residuals_median,
               tolerance = 1e-5)
  expect_equal(new_model1$Residuals$Residual_3Q[[1]],
               unname(residuals_3Q["75%"]),
               tolerance = 1e-5)
  expect_equal(new_model1$Residuals$Residual_Max[[1]],
               residuals_max,
               tolerance = 1e-5)
  estimates1 <- as.vector(new_model1$Coefficients$Estimate)
  names(estimates1) <- rownames(new_model1$Coefficients)
  expect_equal(estimates1,
               coef(lm_model1),
               tolerance = 1e-5)
  stderror1 <- as.vector(new_model1$Coefficients$Std_Error)
  names(stderror1) <- rownames(new_model1$Coefficients)
  expect_equal(stderror1,
               lm_summary1$coefficients[, "Std. Error"],
               tolerance = 1e-5)
  tvalue1 <- as.vector(new_model1$Coefficients$t_value)
  names(tvalue1) <- rownames(new_model1$Coefficients)
  expect_equal(tvalue1,
               lm_summary1$coefficients[, "t value"],
               tolerance = 1e-5)
  pvalue1 <- as.vector(new_model1$Coefficients$p_value)
  names(pvalue1) <- rownames(new_model1$Coefficients)
  expect_equal(pvalue1,
               lm_summary1$coefficients[, "Pr(>|t|)"],
               tolerance = 1e-5)
  expect_equal(new_model1$ModelStats$Residual_Std_Error,
               lm_summary1$sigma,
               tolerance = 1e-5)
  expect_equal(new_model1$ModelStats$R_Squared,
               lm_summary1$r.squared,
               tolerance = 1e-5)
  expect_equal(new_model1$ModelStats$Adj_R_Squared,
               lm_summary1$adj.r.squared,
               tolerance = 1e-5)
  expect_equal(new_model1$ModelStats$F_Statistic,
               unname(lm_summary1$fstatistic["value"]),
               tolerance = 1e-5)
  expect_equal(new_model1$ModelStats$P_Value_F,
               unname(
                 pf(
                   lm_summary1$fstatistic[1],
                   lm_summary1$fstatistic[2],
                   lm_summary1$fstatistic[3],
                   lower.tail = FALSE
                 )
               ),
               tolerance = 1e-5)
})

test_that("LinearReg performs multiple linear regression correctly", {
  set.seed(123)
  x1 <- rnorm(50)
  x2 <- rnorm(50)
  x3 <- rnorm(50)
  y <- 1 + 2 * x1 + 3.5 * x2 + 7 * x3 + rnorm(50)
  df1 <- data.frame(y = y,
                    x1 = x1,
                    x2 = x2,
                    x3 = x3)
  new_model2 <- LinearReg(y ~ x1 + x2 + x3, data = df1)
  lm_model2 <- lm(y ~ x1 + x2 + x3, data = df1)
  lm_summary2 <- summary(lm_model2)
  residuals <- lm_model2$residuals
  residuals_min <- min(residuals)
  residuals_1Q <- quantile(residuals, prob = 0.25)
  residuals_median <- median(residuals)
  residuals_3Q <- quantile(residuals, 0.75)
  residuals_max <- max(residuals)
  expect_equal(new_model2$Residuals$Residual_Min[[1]],
               residuals_min,
               tolerance = 1e-5)
  expect_equal(new_model2$Residuals$Residual_1Q[[1]],
               unname(residuals_1Q["25%"]),
               tolerance = 1e-5)
  expect_equal(new_model2$Residuals$Residual_Median[[1]],
               residuals_median,
               tolerance = 1e-5)
  expect_equal(new_model2$Residuals$Residual_3Q[[1]],
               unname(residuals_3Q["75%"]),
               tolerance = 1e-5)
  expect_equal(new_model2$Residuals$Residual_Max[[1]],
               residuals_max,
               tolerance = 1e-5)
  estimates2 <- as.vector(new_model2$Coefficients$Estimate)
  names(estimates2) <- rownames(new_model2$Coefficients)
  expect_equal(estimates2,
               coef(lm_model2),
               tolerance = 1e-5)
  stderror2 <- as.vector(new_model2$Coefficients$Std_Error)
  names(stderror2) <- rownames(new_model2$Coefficients)
  expect_equal(stderror2,
               lm_summary2$coefficients[, "Std. Error"],
               tolerance = 1e-5)
  tvalue2 <- as.vector(new_model2$Coefficients$t_value)
  names(tvalue2) <- rownames(new_model2$Coefficients)
  expect_equal(tvalue2,
               lm_summary2$coefficients[, "t value"],
               tolerance = 1e-5)
  pvalue2 <- as.vector(new_model2$Coefficients$p_value)
  names(pvalue2) <- rownames(new_model2$Coefficients)
  expect_equal(pvalue2,
               lm_summary2$coefficients[, "Pr(>|t|)"],
               tolerance = 1e-5)
  expect_equal(new_model2$ModelStats$Residual_Std_Error,
               lm_summary2$sigma,
               tolerance = 1e-5)
  expect_equal(new_model2$ModelStats$R_Squared,
               lm_summary2$r.squared,
               tolerance = 1e-5)
  expect_equal(new_model2$ModelStats$Adj_R_Squared,
               lm_summary2$adj.r.squared,
               tolerance = 1e-5)
  expect_equal(new_model2$ModelStats$F_Statistic,
               unname(lm_summary2$fstatistic["value"]),
               tolerance = 1e-5)
  expect_equal(new_model2$ModelStats$P_Value_F,
               unname(
                 pf(
                   lm_summary2$fstatistic[1],
                   lm_summary2$fstatistic[2],
                   lm_summary2$fstatistic[3],
                   lower.tail = FALSE
                 )
               ),
               tolerance = 1e-5)
})
