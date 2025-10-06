# define grid; 100 values between 0 and 1
p_grid <- seq(from = 0, to = 1, length.out = 50)

# All priors have equal probability
#prior <- rep(1, 20)

# Prior = e(-5*(p_grid - 0.5)) e = Eulers Number (2.71828)
#prior <- exp( -5*abs( p_grid - 0.5 ) )

# Prior = 0 for values < 0.5 and 1 for values >= 0.5
prior <- ifelse( p_grid < 0.55 , 0 , 1 )


# compute likelihood at each value in grid
likelihood <- dbinom(50, size=100, prob=p_grid)

# compute product of likelihood and prior
unstd.posterior <- likelihood * prior

# standardize the posterior, so it sums to 1
posterior <- unstd.posterior / sum(unstd.posterior)

plot( p_grid , posterior , type="b" ,
xlab="probability of water" , ylab="posterior probability" )
mtext( "100 points" )