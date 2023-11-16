#' @title Linear Regression Model
#' @description This function performs the linear regression by Ordinary Least Squares (OLS).
#'     It calculates the significant coefficients and parameters.
#' @param formula the model requires to be fitted
#'     it is described as "response variable ~ explanatory variables"
#' @param data a data frame of the explanatory variables in the model
#'
#' @return a list of the output significant coefficients and parameters
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
  # remove observations with "NA"
  data <- na.omit(data)

  # obtain the response variable as a vector from the data
  # create the design matrix for explanatory variables
  Y <- model.response(model.frame(formula, data))
  X <- model.matrix(formula, data)
  n <- nrow(X)
  p <- ncol(X)

  # calculate the coefficients and other parameters of the fitted model
  beta_hat <- solve(t(X) %*% X) %*% t(X) %*% Y
  Y_hat <- X %*% beta_hat
  residuals <- Y - Y_hat
  residual_min <- min(residuals)
  residual_1Q <- quantile(residuals, 0.25)
  residual_median <- median(residuals)
  residual_3Q <- quantile(residuals, 0.75)
  residual_max <- max(residuals)
  sigma_squared <- t(residuals) %*% residuals / (n-p)
  se_residual <-  sqrt(sigma_squared)
  se_beta_hat <- sqrt(diag(solve(t(X) %*% X) * c(sigma_squared)))
  t_statistic <- beta_hat / se_beta_hat
  df <- n - p
  p_value <- 2 * (1 - pt(q = abs(t_statistic), df))
  SSE <- sum((residuals)^2)
  Y_bar = mean(Y)
  SSR <- sum((Y_hat - Y_bar)^2)
  SSY <- sum((Y - Y_bar)^2)
  MSE <- SSE / (n - p)
  MSR <- SSR / (p - 1)
  F_stat <- MSR/MSE
  p_value_F <- 1 - pf(F_stat, df1 = p - 1, df2 = n - p)
  r_squared <- SSR / SSY
  adj_r_squared <- 1 - (1 - r_squared) * (n - 1) / (n - p - 1)

  return(list(residuals = c(residual_min, residual_1Q, residual_median, residual_3Q, residual_max),
              estimate_betahat = beta_hat, std_error_betahat = se_beta_hat,
              t_statistic = t_statistic, p_value = p_value,
              residual_std_error = se_residual,
              r_squared = r_squared, adj_r_squared = adj_r_squared,
              F_statistic = F_stat, p_value_F = p_value_F))
}
