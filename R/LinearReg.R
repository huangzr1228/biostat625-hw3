#' @title Linear Regression Model
#' @description This function performs the linear regression by Ordinary Least Squares (OLS).
#'     The statistical measures of residuals, coefficients, and other significant statistics
#'     will be calculated
#'     Both simple linear regression and multiple linear regression could be performed
#' @param formula The model requires to be fitted
#'     It is described as "response variable ~ explanatory variables"
#' @param data A data frame of the explanatory variables in the model
#'
#' @return A list of the output significant coefficients and parameters
#' @export
#'
#' @examples
#' simple linear regression
#' LinearReg(Murder ~ UrbanPop, data = USArrests)
#'
#' x <- c(1, 2, 3, 4, 5)
#' y <- c(1.5, 3.0, 4.5, 6.0, 8.5)
#' df <- data.frame(y = y, x = x)
#' LinearReg(y ~ x, data = df)
#'
#' multiple linear regression
#' LinearReg(Murder ~ Assault + UrbanPop + Rape, data = USArrests)
#'
#' set.seed(123)
#' x1 <- rnorm(50)
#' x2 <- rnorm(50)
#' x3 <- rnorm(50)
#' y <- 1 + 2 * x1 + 3.5 * x2 + 7 * x3 + rnorm(50)
#' df1 <- data.frame(y = y, x1 = x1, x2 = x2, x3 = x3)
#' LinearReg(y ~ x1 + x2 + x3, data = df1)
LinearReg <- function(formula, data) {
  # address the missing values "NA"
  # remove observations with missing valuess "NA"
  data <- na.omit(data)

  # generates a data frame from the provided data
  # obtain the response variable as a vector from the established data frame
  # create the design matrix for explanatory variables
  Y <- model.response(model.frame(formula, data))
  X <- model.matrix(formula, data)
  n <- nrow(X)
  p <- ncol(X)

  # calculate the coefficients and significant of the fitted model
  beta_hat <- solve(t(X) %*% X) %*% t(X) %*% Y
  Y_hat <- X %*% beta_hat
  residuals <- Y - Y_hat
  residual_min <- min(residuals)
  residual_1Q <- quantile(residuals, 0.25)
  residual_median <- median(residuals)
  residual_3Q <- quantile(residuals, 0.75)
  residual_max <- max(residuals)
  sigma_squared <- t(residuals) %*% residuals / (n - p)
  se_residual <-  sqrt(sigma_squared)
  se_beta_hat <- sqrt(diag(solve(t(X) %*% X) * c(sigma_squared)))
  t_statistic <- beta_hat / se_beta_hat
  df <- n - p
  p_value <- 2 * (1 - pt(q = abs(t_statistic), df))
  SSE <- sum((residuals) ^ 2)
  Y_bar = mean(Y)
  SSR <- sum((Y_hat - Y_bar) ^ 2)
  SSY <- sum((Y - Y_bar) ^ 2)
  MSE <- SSE / (n - p)
  MSR <- SSR / (p - 1)
  F_stat <- MSR / MSE
  p_value_F <- 1 - pf(F_stat, df1 = p - 1, df2 = n - p)
  r_squared <- SSR / SSY
  adj_r_squared <- 1 - (SSE / (n - p)) / (SSY / (n - 1))

  residuals_stats <- data.frame(
    Residual_Min = residual_min,
    Residual_1Q = residual_1Q,
    Residual_Median = residual_median,
    Residual_3Q = residual_3Q,
    Residual_Max = residual_max
  )
  coefficients_df <- data.frame(
    Estimate = beta_hat,
    Std_Error = se_beta_hat,
    t_value = t_statistic,
    p_value = p_value
  )
  model_stats <- data.frame(
    Residual_Std_Error = se_residual,
    R_Squared = r_squared,
    Adj_R_Squared = adj_r_squared,
    F_Statistic = F_stat,
    P_Value_F = p_value_F
  )

  # combine the result into a single data frame
  results_df <- list(Residuals = residuals_stats,
                     Coefficients = coefficients_df,
                     ModelStats = model_stats)

  return(results_df)
}
