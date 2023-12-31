% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/LinearReg.R
\name{LinearReg}
\alias{LinearReg}
\title{Linear Regression Model}
\usage{
LinearReg(formula, data)
}
\arguments{
\item{formula}{The model requires to be fitted
It is described as "response variable ~ explanatory variables"}

\item{data}{A data frame of the explanatory variables in the model}
}
\value{
A list of the output significant coefficients and parameters
}
\description{
This function performs the linear regression by Ordinary Least Squares (OLS).
    The statistical measures of residuals, coefficients, and other significant statistics
    will be calculated
    Both simple linear regression and multiple linear regression could be performed
}
\examples{
# Simple Linear Regression
LinearReg(Murder ~ UrbanPop, data = USArrests)

x <- c(1, 2, 3, 4, 5)
y <- c(1.5, 3.0, 4.5, 6.0, 8.5)
df <- data.frame(y = y, x = x)
LinearReg(y ~ x, data = df)

# Multiple Linear Regression
LinearReg(Murder ~ Assault + UrbanPop + Rape, data = USArrests)

set.seed(123)
x1 <- rnorm(50)
x2 <- rnorm(50)
x3 <- rnorm(50)
y <- 1 + 2 * x1 + 3.5 * x2 + 7 * x3 + rnorm(50)
df1 <- data.frame(y = y, x1 = x1, x2 = x2, x3 = x3)
LinearReg(y ~ x1 + x2 + x3, data = df1)
}
