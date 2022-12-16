SSS_uneven <- function(p1,p2,enma_sigma,power.level,sig.level = 0.05, method = "with"){
  beta1 <- log(p1/(1-p1))
  beta2 <- log(p2/(1-p2)) - log(p1/(1-p1))
  mu_1 <- exp(beta1)/(1+exp(beta1))^2
  mu_2 <- exp(beta1 + beta2)/(1+exp(beta1 + beta2))^2
  n0 <- c(1,1)

  power_cal <- function(n){
    if(method == "with"){
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

  confun <- function(n){
    f = power.level-power_cal(n)
    f = rbind(f,-n[1])
    f = rbind(f,-n[2])
    return(list(ceq=NULL,c=f))
  }


  objfun=function(n){
    n[1]+n[2]
  }

  solution_temp <- NlcOptim::solnl(n0,objfun=objfun,confun=confun)$par
  solution_temp_int <- round(solution_temp,0)
  # get the integer solution around this
  dat_para <- expand.grid(n1=c(max(solution_temp_int[1]-2,1):(solution_temp_int[1]+2)),n2=c(max(solution_temp_int[2]-2,1):(solution_temp_int[2]+2)))

  for(c in 1:nrow(dat_para)){
    dat_para[c,3] <- power_cal(c(dat_para$n1[c],dat_para$n2[c]))
  }

  dat_para <- dat_para[dat_para$V3>=power.level,]
  dat_para$n <- dat_para$n1+dat_para$n2
  nmin <- min(dat_para$n)
  dat_para <- dat_para[dat_para$n==nmin,]
  dat_para <- dat_para[order(dat_para$V3,decreasing = TRUE),]
  return(as.numeric(dat_para[1,1:2]))
}
