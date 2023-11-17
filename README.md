# LinearModel.new
<!-- badges: start -->
  [![R-CMD-check](https://github.com/huangzr1228/biostat625-hw3/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/huangzr1228/biostat625-hw3/actions/workflows/R-CMD-check.yaml)
  <!-- badges: end -->
The LinearModel.new package is created to perform the linear regression by ordinary least squares (OLS) and calculate the significant coefficients and other parameters of the linear regression. With the input of the formula and data, the package will return the list of results where the coefficents, t statistic, p value, F statistic, r squared etc. would be included. 
## Installation
This package could be installed from Github：
```r
install.packages("LinearModel.new")
devtools::install_github("huangzr1228/LinearModel.new")
```
## Usage
```r
library(LinearModel.new)

# Simple linear regression:
# Example 1
LinearReg(Murder ~ UrbanPop, data = USArrests)
# Output
#$residuals
#                  25%                   75%            
#-6.5370674 -3.7360419 -0.7790319  3.3319958  9.7279780 
#$estimate_betahat
#                  [,1]
#(Intercept) 6.41594246
#UrbanPop    0.02093466
#$std_error_betahat
#(Intercept)    UrbanPop 
#2.90669257  0.04332647 
#$t_statistic
#                 [,1]
#(Intercept) 2.2073000
#UrbanPop    0.4831841
#$p_value
#                  [,1]
#(Intercept) 0.03210725
#UrbanPop    0.63116178
#$residual_std_error
#         [,1]
#[1,] 4.389983
#$r_squared
#[1] 0.00484035
#$adj_r_squared
#[1] -0.03750687
#$F_statistic
#[1] 0.2334668
#$p_value_F
#[1] 0.6311618

# Multiple linear regression
# Example 2
LinearReg(Murder ~ Assault + UrbanPop + Rape, data = USArrests)
# Output
# $residuals
#                   25%                   75%            
#-4.3990175 -1.9126792 -0.3443603  1.2557190  7.4278916 
#$estimate_betahat
#                    [,1]
# (Intercept)  3.27663918
# Assault      0.03977717
# UrbanPop    -0.05469363
# Rape         0.06139942
# $std_error_betahat
# (Intercept)     Assault    UrbanPop        Rape 
# 1.737997161 0.005911667 0.027880242 0.055740249 
# $t_statistic
#                  [,1]
# (Intercept)  1.885296
# Assault      6.728587
# UrbanPop    -1.961734
# Rape         1.101528
# $p_value
#                     [,1]
# (Intercept) 6.571517e-02
# Assault     2.328851e-08
# UrbanPop    5.586128e-02
# Rape        2.763975e-01
# $residual_std_error
#          [,1]
# [1,] 2.574255
# $r_squared
# [1] 0.6720656
# $adj_r_squared
# [1] 0.6429159
# $F_statistic
# [1] 31.42399
# $p_value_F
# [1] 3.322431e-11
```
