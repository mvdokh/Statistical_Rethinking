# Suppose the globe tossing data had turned out to be 8 water in 15 tosses. construct the posterior distribution using a grid approximation assuming a uniform prior.
p_grid <- seq( from=0 , to=1 , length.out=1000 )
prior <- rep( 1 , 1000 )
likelihood <- dbinom( 8 , size=15 , prob=p_grid )
posterior <- likelihood * prior
posterior <- posterior / sum(posterior)
set.seed(100)
samples <- sample( p_grid , prob=posterior , size=1e4 , replace=TRUE )
# What is the posterior probability that p is less than 0.5?
prob_less_0.5 <- mean(samples < 0.5)

# Draw 10,000 samples, use the samples to calculate 90% HPDI for p
library(rethinking) # for highest posterior density interval function
y <- HPDI(samples, prob=0.90)

# Construct a posterior predictive check for this model and data. This means simulate the distribution of samples, averaging over the posterior uncertainty in p. What is the probability of observing 8 water in 15 tosses?
# Posterior predictive check:
# Simulate new data from posterior samples
sim_water <- rbinom(1e4, size = 15, prob = samples)

# Probability of observing exactly 8 water in 15 tosses
mean(sim_water == 8)


