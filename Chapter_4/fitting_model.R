library(rethinking)
data(Howell1)
d <- Howell1
d2 <- d[d$age >= 18, ]

# Define the model 
#m <- map(
#  alist(
#    height ~ dnorm( a+b*weight , sigma ),
#    a ~ dnorm( 178 , 100 ),
#    b ~ dnorm( 0 , 10 ),
#    sigma ~ dunif( 0 , 50 )
#  ) ,
#  data=d2
#)

# is height a good predictor of weight?
#plot(d2$weight, d2$height)
# plot points of people (>= 18 years old) to see how height and weight covary
# plot each variables distribution 
#plot(density(d2$weight))
#plot(density(d2$height))

# precis(m) <- interpret model fit
#        mean   sd   5.5%    94.5%
#a      113.90 1.91 110.86  116.95
#b       0.90   0.04  0.84    0.97
#sigma   5.07   0.19  4.77    5.38

# First row: quadratic approximation for a
# Second row: quadratic approximation for b
# Third row: quadratic approximation for sigma

# B is a slope; 0.90 means that a person 1kg heavier is expected to be .90cm taller
# 89% of posterior probability is between 0.84 and 0.97; b values close to 0 or above 1 are incompatible

# Estimate of A indicates that a person with 0kg weight is expected to be 113.90cm tall (not realistic, but extrapolation outside data range)
# thus, value of intercept is not meaningful here

# Sigma informs us of the width of the distribution of heights around the mean
# 95% of probability in gaussian distribution lies within 2 standard deviations of the mean, so 95% of plausible heights lie within 10cm (2sigma) of the mean height

# precis(m, corr=TRUE) # show correlations between parameters
# a and b are negatively correlated

# centering = subtracting the mean from each value
d2$weight.c <- d2$weight - mean(d2$weight)

m2 <- map(
  alist(
    height ~ dnorm(mu, sigma),
    mu <- a + b*weight.c,
    a ~ dnorm(178, 100),
    b ~ dnorm(0, 10),
    sigma ~ dunif(0, 50)
    
  ) ,
  data = d2
)

plot(height ~ weight, data=d2)
abline(a=coef(m2)["a"], b=coef(m2)["b"])

# sequence of weights on the original scale
w_seq <- seq(min(d2$weight), max(d2$weight), length.out = 100)

# center them the same way as in the model
w_c_seq <- w_seq - mean(d2$weight)

# predicted mean height
mu_hat <- coef(m2)["a"] + coef(m2)["b"] * w_c_seq

# plot
plot(height ~ weight, data = d2)
lines(w_seq, mu_hat, col = "blue", lwd = 2)

# extract posterior samples
post <- extract.samples(m2)
post[1:5,]

#         a         b    sigma
#1 154.4101 0.9083219 5.324095
#2 154.3688 0.9209352 5.029243
#3 154.6342 0.9464066 5.017499
#4 154.4816 0.9603862 4.691406
#5 154.2750 0.9088594 5.276142

# each row is a correlated random sample from the joint posterior of all three paramters
# the paired values of a and b on each row define a line 
# the average of very many of these lines is the MAP line

# extract the first 10 cases and re estimate the model
N <- 10
dN <- d2[ 1:N , ]
mN <- map(
alist(
height ~ dnorm( mu , sigma ) ,
mu <- a + b*weight ,
a ~ dnorm( 178 , 100 ) ,
b ~ dnorm( 0 , 10 ) ,
sigma ~ dunif( 0 , 50 )
) , data=dN )

# extract 20 samples from the posterior
post <- extract.samples( mN , n=20 )
# display raw data and sample size
plot( dN$weight , dN$height ,
xlim=range(d2$weight) , ylim=range(d2$height) ,
col=rangi2 , xlab="weight" , ylab="height" )
mtext(concat("N = ",N))
# plot the lines, with transparency
for ( i in 1:20 )
abline( a=post$a[i] , b=post$b[i] , col=col.alpha("black",0.3) )

# by plotting multiple lines sampled from the posteriror, we can see the highly confident and less confident aspects
# the cloud of regression lines display greater uncertainty at extreme values for weight

mu_at_50 <- post$a + post$b * 50
dens( mu_at_50, col=rangi2, lwd=2, xlab="mu|weight=50kg" )
HPDI( mu_at_50, prob=0.89 )

# define sequence of weights to compute predictions for
# these values will be on the horizontal axis
weight.seq <- seq( from=25 , to=70 , by=1 )

# use link to compute mu
# for each sample from posterior
# and for each weight in weight.seq
mu <- link( m2 , data=data.frame(weight=weight.seq) )
str(mu)

# use type="n" to hide raw data
plot( height ~ weight , d2 , type="n" )
# loop over samples and plot each mu value
for ( i in 1:100 )
points( weight.seq , mu[i,] , pch=16 , col=col.alpha(rangi2,0.1) )

# summarize the distribution of mu
mu.mean <- apply( mu , 2 , mean )
mu.HPDI <- apply( mu , 2 , HPDI , prob=0.89 )

# plot raw data
# fading out points to make line and interval more visible
plot( height ~ weight , data=d2 , col=col.alpha(rangi2,0.5) )
# plot the MAP line, aka the mean mu for each weight
lines( weight.seq , mu.mean )
# plot a shaded region for 89% HPDI
shade( mu.HPDI , weight.seq )