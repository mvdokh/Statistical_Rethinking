# Globe Tossing

#             W L    
p_grid <- seq(0, 1, length.out = 1000)
prior <- rep(1, 1000)  # uniform prior
likelihood <- dbinom(6, size = 9, prob = p_grid)  # likelihood of 6 water in 9 tosses
posterior <- likelihood * prior
posterior <- posterior / sum(posterior)  # normalize to get posterior probabilities

# Scoop out samples
samples <- sample(p_grid, replace = TRUE, prob = posterior)
plot(samples)
hist(samples, breaks = 30, main = "Posterior Distribution of p", xlab = "p", freq = FALSE)

library(rethinking)
dens( samples, show.HPDI = TRUE )


#Sampling to summarize
# add up posterior probability where p < 0.5
sum( posterior[ p_grid < 0.5 ] )

# 17% of posterior probability lies below 0.5
sum( samples < 0.5 ) / 1e4

# 61% of posterior probability lies between 0.5 and 0.75
sum( samples > 0.5 & samples < 0.75 ) / 1e4

quantile( samples , 0.8 )
quantile( samples , c( 0.1 , 0.9 ) )

