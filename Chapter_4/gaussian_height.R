#Dataframe:
#Height (cm), Weight (kg), Age (years), Male (1), Female (0)
library(rethinking) 
data(Howell1) 
d <- Howell1

par(mfrow=c(1,1))  

#Individuals older than 18
d2 <- d[d$age >= 18, ]

#Goal is to model these values as a Gaussian distribution
# Distribution of heights
plot(density(d2$height), xlab="Height (cm)", ylab="Density", main="Height Density")

#Looks gaussian, how do we model it? height ~ Normal(mu, sigma) mu=mean height, sigma=sd height

#Priors: mean is normal (178, 20) sd is uniform (0, 50): show prior curve for mean height
curve(dnorm(x, 178, 20), from=100, to=250, xlab="Height (cm)", ylab="Density", main="Prior on Height")

#Sigma Prior: truly flat prior that functions just to constrain sigmal to positive values between 0 and 50
curve( dunif( x , 0 , 50 ) , from=-10 , to=60 )

#Standard deviation like sigma must be positive, so bounding it at 0 makes sense
#How to pick the upper bound?
#STDEV of 50cm implies that 95% of heights lie within 100cm of the mean (large range)

#Distribution of heights averaged over the prior. Prior probability distributioin is not itself gaussian. This is expected, as it is the distribution of relative plausibilities of different heights before seeing the data. 
sample_mu <- rnorm( 1e4 , 178 , 20 )
sample_sigma <- runif( 1e4 , 0 , 50 ) 
prior_h <- rnorm( 1e4 , sample_mu , sample_sigma ) 
dens( prior_h )

# Guts of the golem
mu.list <- seq( from=140, to=160 , length.out=200 )  
sigma.list <- seq( from=4 , to=9 , length.out=200 ) 
post <- expand.grid( mu=mu.list , sigma=sigma.list ) 
post$LL <- sapply( 1:nrow(post) , function(i) sum( dnorm(
               d2$height ,
               mean=post$mu[i] , 
               sd=post$sigma[i] , 
               log=TRUE ) ) ) 
post$prod <- post$LL + dnorm( post$mu , 178 , 20 , TRUE ) + 
      dunif( post$sigma , 0 , 50 , TRUE ) 
post$prob <- exp( post$prod - max(post$prod) )

contour_xyz( post$mu , post$sigma , post$prob, xlim = c(153,156), ylim=c(7,8.5),
             xlab="Mean height (cm)", ylab="SD height (cm)" )

#Heatmap
image_xyz( post$mu , post$sigma , post$prob, xlim = c(153,156), ylim=c(7,8.5) )

#Sampling from the posterior
sample.rows <- sample( 1:nrow(post) , size=1e4 , replace=TRUE ,  prob=post$prob )
sample.mu <- post$mu[ sample.rows ] 
sample.sigma <- post$sigma[ sample.rows ]

# You have 10,000 samples from the posterior distribution of mu and sigma
plot( sample.mu , sample.sigma , cex=0.5 , pch=16 , col=col.alpha(rangi2,0.1) )

#To characterize the shapes of marginal posterior densities mu and sigma (also summarize density)
dens(sample.mu)
mu.hpdi <- HPDI( sample.mu )
abline(v=mu.hpdi, col="green", lwd=2)

dens(sample.sigma)
sigma.hpdi <- HPDI( sample.sigma )
abline(v=sigma.hpdi, col="red", lwd=2)


# The reason for posterior of sigma being skewed right is that sigma must be positive (more complicated)
#Analyze only 20 of the heights to reveal this issue
d3 <- sample( d2$height , size=20 )

mu.list <- seq( from=150, to=170 , length.out=200 )
sigma.list <- seq( from=4 , to=20 , length.out=200 ) 
post2 <- expand.grid( mu=mu.list , sigma=sigma.list ) 
post2$LL <- sapply( 1:nrow(post2) , function(i)
      sum( dnorm( d3 , mean=post2$mu[i] , sd=post2$sigma[i] , 
      log=TRUE ) ) ) 
post2$prod <- post2$LL + dnorm( post2$mu , 178 , 20 , TRUE ) + 
      dunif( post2$sigma , 0 , 50 , TRUE ) 
post2$prob <- exp( post2$prod - max(post2$prod) ) 
sample2.rows <- sample( 1:nrow(post2) , size=1e4 , replace=TRUE , 
      prob=post2$prob ) 
sample2.mu <- post2$mu[ sample2.rows ] 
sample2.sigma <- post2$sigma[ sample2.rows ] 
plot( sample2.mu , sample2.sigma , cex=0.5 , 
      col=col.alpha(rangi2,0.1) , 
      xlab="mu" , ylab="sigma" , pch=16 )

#Marginal posterior of sigma is skewed up and right? Larger tail at the top of the cloud of points
#Inspect marginal posterior density sigma, averaging over mu
dens(sample2.sigma, norm.comp=TRUE)
#Indeed it is skewed right



#To find the values of mu and sigma that jointly maximize the posterior (MAP), use MAP function
#maximize_posterior.R in Chapter_4 folder
