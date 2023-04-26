SSS_even <- function(p1,p2,enma_sigma,power.level,sig.level = 0.05, method = "with"){
  # cal the total sample size when we added one more condition: sample sizes are equal for both treatment groups
  beta1 <- log(p1/(1-p1))
  beta2 <- log(p2/(1-p2)) - log(p1/(1-p1))
  mu_1 <- exp(beta1)/(1+exp(beta1))^2
  mu_2 <- exp(beta1 + beta2)/(1+exp(beta1 + beta2))^2
  n0 <- c(1,1)


  power_cal <- function(n){
    size <- n/2
    if(method == "with") {
      if( is.null(enma_sigma) ) stop('enma_sigma is missing')
      var_inv <- 1/(1/(mu_1 * size) + 1/(mu_2 * size))+1/enma_sigma^2
      var <- 1/var_inv
    }else{
      var <- 1/(mu_1 * size) + 1/(mu_2 * size)
    }
    se <- sqrt(var)
    z <- beta2/se
    power <- pnorm(z-qnorm(1-sig.level/2))+pnorm(-z-qnorm(1-sig.level/2))
    return(power)
  }

  confun <- function(n){
    f = power.level-power_cal(n)
    f = rbind(f,-n)
    return(list(ceq=NULL,c=f))
  }

  objfun=function(n){
    n[1]+n[2]
  }

  solution_temp <- NlcOptim::solnl(n0,objfun=objfun,confun=confun)$par
  solution_temp_int <- ceiling(solution_temp[2])
  # get the even integer solution around this
  if(solution_temp_int %% 2 ==0){
    res <- solution_temp_int
  }else{
    res <- solution_temp_int+1
  }

  power_value <- round(power_cal(res),3)
  return(list(sample_size = c(res/2,res/2),
              power = power_value))

}

