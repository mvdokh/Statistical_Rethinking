library(rethinking)

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

p_grid[ which.max(posterior) ]
samples <- sample( p_grid , prob=posterior , size=1e4 , replace=TRUE)
chainmode( samples , adj=0.01 )

plot(samples)


#posterior mean/median
mean <- mean(samples)
median <- median(samples)
mode <- chainmode(samples, adj=0.01)

dens(samples)

abline(v = mean, col = "blue", lwd = 2, lty = 2)
abline(v = median, col = "red", lwd = 2, lty = 2)
abline(v = mode , col = "green", lwd = 2, lty = 2)
legend("topright", legend = c("Mean", "Median", "Mode"), col = c("blue", "red", "green"), lty = 2, lwd = 2)

#calculating expected loss for any given decision means using the posterior to average over our uncertainty in the true value
# We use p=0.5

sum( posterior*abs(0.5 - p_grid))
loss <- sapply(p_grid, function(d) sum( posterior*abs(d - p_grid)))
p_grid[ which.min(loss) ]