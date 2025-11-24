library(rethinking) 
data(Howell1) 
d <- Howell1 
d2 <- d[ d$age >= 18 , ]

flist <- alist( 
  height ~ dnorm( mu , sigma ) , 
  mu ~ dnorm( 178 , 20 ) , 
  sigma ~ dunif( 0 , 50 )
)

m4.1 <- map( flist, data=d2 )

#Now, you have a fitted model

#A different set of priors:
flist2 <- alist( 
  mu = mean(d2$height),  
  sigma = mean(d2$height)
)

#More informative set of priors (stdev is 0.1, so very narrow around the mean)
m4.2 <- map(
  alist( 
    height ~ dnorm( mu , sigma ) , 
    mu ~ dnorm( 178 , 0.1 ) , 
    sigma ~ dunif( 0 , 50 )
  ), 
  data=d2)

#Important to play around with priors, most use flat priors but they can be problematic

#The above explains how to get a MAP approximation of the posterior
#How do you get samples from the quadratic approximate posterior distribution
#Since mu and sigma each contribute one parameter, the posterior is two-dimensional
#So, when R constructs a quadratic approximation, it builds a 2D Gaussian distribution by calculating covariance among pairs of parameters
#To see matrix of variances and covariances, use vcov()
vcov(m4.1)
#It tells us how each parameter relates to every other parameter in the posterior distribution

#V-C-V matrix can be factored into two elements:
#1. a vector of variances for the parameter
#2. a correlation matrix that describes how pairs of parameters vary together
diag(vcov(m4.1))  #variances
cov2cor(vcov(m4.1))  #correlation matrix

#How do we get samples from this multidimensional posterior?
#Sample vectors of values from 2D gaussian distribution
library(rethinking)
post <- extract.samples(m4.1, n=1e4)
#Data frame with 10,000 rows and two columns

#Quadratic assumption for sigma can be problematic. Can use log(sigma)
m4.1_logsigma <- map(
  alist( 
    height ~ dnorm( mu , exp(log_sigma) ) , 
    mu ~ dnorm( 178 , 20 ) , 
    log_sigma ~ dnorm( 2,10 )
  ), 
  data=d2)

post_logsigma <- extract.samples(m4.1_logsigma)
sigma <- exp( post_logsigma$log_sigma )
#When you have a lot of data this doesnt make a noticeable difference.