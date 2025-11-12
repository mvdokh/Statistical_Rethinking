


# Intervals of defined boundaries.
# What is the posterior probability that the proportion of water is less than 0.5?
# Using the grid approximate posterior, you can add up all probabilities where the corresponding parameter value is less than 0.5

p_grid <- seq(from = 0, to = 1, length.out = 1000)
# creates grid of 1000 possible balues between 0 and 1 (discretized parameter space)
prior <- rep(1, 1000) # uniform prior
# makes the prior equally likely for all values of p_grid
likelihood <- dbinom(6, size = 9, prob = p_grid)
# 6 successes in 9 trials. For each value in p_grid, calculates the likelihood of observing 6 successes in 9 trials assuming that value is the true probability of success
posterior <- likelihood * prior
# posterior(p) proportional to Likelihood(p) * Prior(p)
posterior <- posterior / sum(posterior) 
# normalize

# Now we wish to draw 10,000 samples from this posterior. Values near the peak are more common than those in the tails
# Resulting samples will have the same proportions as the exact posterior density
samples <- sample( p_grid , prob=posterior , size=1e4 , replace=TRUE)

sum( posterior[p_grid < 0.5])
# x <- sum( posterior[p_grid < 0.5]) = 0.1718
# so about 17% of the posterior probability lies below 0.5

# Using samples from the posterior to estimate the same probability
sum( samples < 0.5 ) / 1e4
# x <- sum( samples < 0.5 ) / 1e4 = close to 17%, will vary

# Using the same approach, estimate how much posterior probability lies between 0.5 and 0.75
sum( samples > 0.5 & samples < 0.75 ) / 1e4
# Around 61%

# Counting with sum: R internally converts a logical expression, like samples < 0.5 into a vector of TRUE and FALSE; saying whether or not each element matches the criterion.
# It essentially counts how many true values are in the vector

# Quantiles
# It is common to see scientific journals reporting an interval of defined mass; a confidence interval
# An interval of posterior probability is called a credible interval
# Suppose you want to know the boundaries of the lower 80% posterior probability
quantile( samples , 0.8 )

# The middle 80% interval lies between the 10% and 90% quantiles
quantile( samples , c(0.1,0.9) )

# KEY POINTS:
# Once you have a posterior distribution,
# How much posterior probability lies below some parameter value?
# How much posterior probability lies between two parameter values?
# Which parameter value marks the lower %5 of the posterior probability
# Which range of parameter values contains 90% of the posterior probability
# Which parameter value has the highest posterior probability

# First you have a model
# out of 1000 coin tosses, 60% will be head (posterior)
# this can be plotted as a posterior distribution
# with this posterior distribution, you can ask what events occur on the lower 5% of the distribution?