# LinearModel.new
## Introduction
The LinearModel.new package is created to perform the linear regression by ordinary least squares (OLS) and calculate statistical measures of residuals, coefficients, and other significant statistics of the linear regression. 

The formula of the linear regression by OLS:
\[
Y = X\beta + \epsilon
\]

\[
Y = 
\begin{bmatrix}
Y_1 \\
Y_2 \\
\vdots \\
Y_n
\end{bmatrix}_{n \times 1}
\quad
\epsilon = 
\begin{bmatrix}
\epsilon_1 \\
\epsilon_2 \\
\vdots \\
\epsilon_n
\end{bmatrix}_{n \times 1}
\]

\[
X = 
\begin{bmatrix}
1 & X_{11} & X_{12} & \dots & X_{1,p-1} \\
1 & X_{21} & X_{22} & \dots & X_{2,p-1} \\
\vdots & \vdots & \vdots & \ddots & \vdots \\
1 & X_{n1} & X_{n2} & \dots & X_{n,p-1}
\end{bmatrix}_{n \times p}
\quad
\beta = 
\begin{bmatrix}
\beta_0 \\
\beta_1 \\
\beta_2 \\
\vdots \\
\beta_{p-1}
\end{bmatrix}_{p \times 1}
\]

\[
\frac{\partial SSE}{\partial \hat{\beta}} = -2X^T Y + 2X^T X  \hat{\beta} = 0
\]


\[
\hat{\beta} = (X^TX)^{-1}X^TY
\]

With the input of the formula and data, the package will return the data frame of results where the coefficents, t statistic, p value, F statistic, r squared etc. would be included. 

## Installation
You can install the development version of LinearModel.new from [GitHub]GitHub(https://github.com/huangzr1228/biostat625-hw3) with:
```r
install.packages("LinearModel.new")
devtools::install_github("huangzr1228/LinearModel.new")
```
## Usage
The function LinearReg() in the R package "LinearModel.new" could be used in this way
1. Load the ”LinearModel.new" package into the R session
2. Load the data sets (built-in datasets or simulated datasets or other datasets)
3. Call the function LinearReg() in LinearReg(formula, data)
formula: The model requires to be fitted, described as "response variable ~ explanatory variables"
data: A data frame of the explanatory variables in the model
4. This function will return the data frame of all results, including the statistical    measures of residuals, coefficients, and other significant statistics

```r
library(LinearModel.new)
```

### Example 1
Simple linear regression for buit-in datasets
```r
LinearReg(Murder ~ UrbanPop, data = USArrests)
# Output
# $Residuals
#     Residual_Min Residual_1Q Residual_Median Residual_3Q Residual_Max
# 25%    -6.537067   -3.736042      -0.7790319    3.331996     9.727978

# $Coefficients
#               Estimate  Std_Error   t_value    p_value
# (Intercept) 6.41594246 2.90669257 2.2073000 0.03210725
# UrbanPop    0.02093466 0.04332647 0.4831841 0.63116178

# $ModelStats
#   Residual_Std_Error  R_Squared Adj_R_Squared F_Statistic P_Value_F
# 1           4.389983 0.00484035   -0.01589214   0.2334668 0.6311618
```

### Example 2
Simple linear regression for simulated datasets
```r
x <- c(1, 2, 3, 4, 5)
y <- c(1.5, 3.0, 4.5, 6.0, 8.5)
df <- data.frame(y = y, x = x)
LinearReg(y ~ x, data = df)
# Output
# $Residuals
#     Residual_Min Residual_1Q Residual_Median Residual_3Q Residual_Max
# 25%         -0.4        -0.2    -5.77316e-15         0.2          0.4

# $Coefficients
#             Estimate Std_Error   t_value      p_value
# (Intercept)     -0.4 0.3829708 -1.044466 0.3730213624
# x                1.7 0.1154701 14.722432 0.0006797755

# $ModelStats
#  Residual_Std_Error R_Squared Adj_R_Squared F_Statistic    P_Value_F
# 1          0.3651484 0.9863481     0.9817975      216.75 0.0006797755
```

### Example 3
Multiple linear regression for buit-in datasets
```r
LinearReg(Murder ~ Assault + UrbanPop + Rape, data = USArrests)
# Output
# $Residuals
#     Residual_Min Residual_1Q Residual_Median Residual_3Q Residual_Max
# 25%    -4.399018   -1.912679      -0.3443603    1.255719     7.427892

# $Coefficients
#                Estimate   Std_Error   t_value      p_value
# (Intercept)  3.27663918 1.737997161  1.885296 6.571517e-02
# Assault      0.03977717 0.005911667  6.728587 2.328851e-08
# UrbanPop    -0.05469363 0.027880242 -1.961734 5.586128e-02
# Rape         0.06139942 0.055740249  1.101528 2.763975e-01

# $ModelStats
#   Residual_Std_Error R_Squared Adj_R_Squared F_Statistic    P_Value_F
# 1           2.574255 0.6720656     0.6506786    31.42399 3.322431e-11
```

### Example 4
Multiple linear regression for simulated datasets
```r
set.seed(123)
x1 <- rnorm(50)
x2 <- rnorm(50)
x3 <- rnorm(50)
y <- 1 + 2 * x1 + 3.5 * x2 + 7 * x3 + rnorm(50)
df1 <- data.frame(y = y, x1 = x1, x2 = x2, x3 = x3)
LinearReg(y ~ x1 + x2 + x3, data = df1)
# Output
# $Residuals
#     Residual_Min Residual_1Q Residual_Median Residual_3Q Residual_Max
# 25%    -1.467981   -0.675463      -0.1069042   0.6308809     3.019347

# $Coefficients
#             Estimate Std_Error   t_value      p_value
# (Intercept) 1.060995 0.1385663  7.656948 9.518661e-10
# x1          1.871836 0.1452661 12.885564 0.000000e+00
# x2          3.329838 0.1503218 22.151403 0.000000e+00
# x3          6.971902 0.1375456 50.687943 0.000000e+00

# $ModelStats
#   Residual_Std_Error R_Squared Adj_R_Squared F_Statistic P_Value_F
# 1          0.9406099 0.9847123     0.9837153    987.6549         0
```
