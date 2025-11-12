p_grid <- seq(from = 0, to = 1, length.out = 1000)
prior <- rep(1, 1000)
likelihood <- dbinom(6, size = 9, prob = p_grid)
posterior <- likelihood * prior
posterior <- posterior / sum(posterior)
samples <- sample(p_grid, size=1e4, replace=TRUE, prob=posterior)

# Already sampling from posterior
# To shade 50% confidence interval:
PI(samples, prob=0.5)
# This interval assigns 25% of the probability mass above and below the interval 
# 25% = 0.7037, 75% = 0.9329

# HDPI = highest posterior density interval
# The narrowest interval containing the specified probability mass (posterior density for a given confidence level)

HPDI(samples, prob=0.5)
# |0.5                0.5|
# 0.84084           1.00000
