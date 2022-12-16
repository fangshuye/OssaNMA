#' @importFrom stats pnorm qnorm
NULL

#' Calculate the optimal sample sizes for a new two-arm trial when analyze it with the existing network
#'
#' This function calculates the optimal sample size for each treatment group to
#' achieve a pre-specified power when planning a new two-arm trial with
#' binary outcome.
#'
#' @param p1 Risk of treatment 1
#' @param p2 Risk of treatment 2
#' @param enma_sigma Standard error of the estimated effect size (log odds ratio) between treatment 1 and treatment 2 from the existing network
#' @param power.level Power of test we want to obtain
#' @param sig.level Significance level, the default value is 0.05
#' @param method a character string specifying the method of analyzing the new trial, must be one of 'with' (default) or 'without'
#' @param allocation a character string specifying the type of sample size allocation between two groups, must be one of 'uneven' (default) or 'even'.
#' @return the sample size for each treatment group
#' @export
#' @examples
#' ssnma(p1 = 0.2, p2 = 0.3, enma_sigma = 0.4, power = 0.8)

ssnma <- function(p1,p2,enma_sigma = NULL,power.level,sig.level = 0.05, method = "with", allocation = "uneven"){
  if( any(p1 < 0 | p1 > 1) ) stop('p1 not between 0 and 1')
  if( any(p2 < 0 | p2 > 1) ) stop('p2 not between 0 and 1')
  if( any(power.level < 0 | power.level > 1) ) stop('power.level not between 0 and 1')
  if( any(sig.level < 0 | sig.level > 1) ) stop('sig.level not between 0 and 1')
  beta1 = log(p1/(1-p1))
  beta2 = log(p2/(1-p2)) - log(p1/(1-p1))
  mu_1 <- exp(beta1)/(1+exp(beta1))^2
  mu_2 <- exp(beta1 + beta2)/(1+exp(beta1 + beta2))^2
  n0=c(1,1)

  if(allocation == "uneven"){
    SSS_uneven(p1,p2,enma_sigma,power.level,sig.level, method)
  }else{
    SSS_even(p1,p2,enma_sigma,power.level,sig.level, method)
  }

}
