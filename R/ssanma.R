#' @importFrom stats pnorm qnorm
NULL

#' Calculate the optimal sample size allocation for a new two-arm trial when analyze it with the existing network
#'
#' This function calculates the optimal sample size allocation for each treatment group
#' with a fixed total sample size when planning a new two-arm trial
#' with binary outcome.
#'
#' @param p1 Risk of treatment 1
#' @param p2 Risk of treatment 2
#' @param enma_sigma Standard error of the estimated effect size (log odds ratio) between treatment 1 and treatment 2 from the existing network
#' @param N Number of total sample size
#' @param sig.level Significance level, the default value is 0.05
#' @param method a character string specifying the method of analyzing the new trial, must be one of 'with' (default) or 'without'
#' @param allocation a character string specifying the type of sample size allocation between two groups, must be one of 'uneven' (default) or 'even'.
#' @return A list with the following components:
#'  \item{sample_alloc}{Sample size allocation to each treatment group.}
#'  \item{power}{Power of the test.}
#' @export
#' @examples
#' ssanma(p1 = 0.2, p2 = 0.3, enma_sigma = 0.4, N = 200)
ssanma <- function(p1,p2,enma_sigma,N,sig.level = 0.05, method = "with", allocation = "uneven"){
  # cal the total sample size when we added one more condition: sample sizes are equal for both treatment groups
  beta1 = log(p1/(1-p1))
  beta2 = log(p2/(1-p2)) - log(p1/(1-p1))
  mu_1 <- exp(beta1)/(1+exp(beta1))^2
  mu_2 <- exp(beta1 + beta2)/(1+exp(beta1 + beta2))^2
  s <- N
  var_fn <- function(n, mu_1, mu_2, s){
    1/(mu_1 * n[1]) + 1/(mu_2 * n[2])
  }

  power_formula <- function(n){
    if(method == "with") {
      if( is.null(enma_sigma) ) stop('enma_sigma is missing')
      var_inv <- 1/(1/(mu_1 * n[1]) + 1/(mu_2 * n[2]))+1/enma_sigma^2
      var <- 1/var_inv
    }else{
      var <- 1/(mu_1 * n[1]) + 1/(mu_2 * n[2])
    }
    se <- sqrt(var)
    z <- beta2/se
    power <- pnorm(z-qnorm(1-sig.level/2))+pnorm(-z-qnorm(1-sig.level/2))
    return(power)
  }

  con_fn <- function(n, mu_1, mu_2,s){
    n1 <- n[1]
    n2 <- n[2]
    n1 + n2 - s
  }
  if(allocation == "uneven"){
    suppressWarnings(sample_alloc <- DEoptimR::JDEoptim(lower = c(0,0), upper = c(s,s),
                                       fn = var_fn, constr = con_fn,
                                       meq = 1, triter = 50,
                                       mu_1 = mu_1,
                                       mu_2 = mu_2,
                                       s = s))
    sample_alloc <- round(sample_alloc$par,0)
  }else{
    sample_alloc <- c(N/2, N/2)
  }


  power_value <- round(power_formula(sample_alloc),3)
  return(list(sample_alloc = sample_alloc, power = power_value))
}

