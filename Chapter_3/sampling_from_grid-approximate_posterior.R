# 3.1 Sampling from a grid-approximate posterior
# "Imagine there's an image that you can't view in its entirety, you only observe snippets along a grid that sweeps from left to right across the image"
# "The finer the grid, the more detail you can see"
# "And if the grid is fine enough, you can reconstruct the image perfectly"
# Bayesian grid approximation: target image = f(theta/y). Instead of observing every possible value of theta, we observe onlu a finite and discrete grid of possible theta values

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

plot(samples)

library(rethinking)
# There are many more samples from the dense region near 0.6 and few below 0.25
dens(samples)

# All youve done so far is crudely replicate the posterior density you had already computed. 
