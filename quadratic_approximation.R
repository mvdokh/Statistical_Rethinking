install.packages("devtools")
devtools::install_github("stan-dev/cmdstanr")
cmdstanr::install_cmdstan()
devtools::install_github("rmcelreath/rethinking")

library(rethinking)

globe.qa <- map(
alist(
      w ~ dbinom(9,p) , # binomial likelihood
      p ~ dunif(0,1) # uniform prior
  ) ,
  data=list(w=6) )

# display summary of q
precis( globe.qa )

# analytical calculation
w <- 6
n <- 9
curve( dbeta( x , w+1 , n-w+1 ) , from=0 , to=1 )
# quadratic approximation
curve( dnorm( x , 0.67 , 0.16 ) , lty=2 , add=TRUE )

