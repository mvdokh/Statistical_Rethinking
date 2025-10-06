# 2M1 — Globe tossing model

# Create grid of possible p values
p_grid <- seq(from = 0, to = 1, length.out = 1000)

# Uniform prior
#prior <- rep(1, 1000)
#prior <- ifelse( p_grid < 0.50 , 0 , 1 )
prior <- exp( -5*abs( p_grid - 0.5 ) )

# Define a function to compute posterior given data
compute_posterior <- function(w, n, p_grid, prior) {
  # Likelihood: Binomial probability of observing w water in n tosses
  likelihood <- dbinom(w, size = n, prob = p_grid)
  
  # Unstandardized posterior
  unstd_posterior <- likelihood * prior
  
  # Standardize (normalize) posterior
  posterior <- unstd_posterior / sum(unstd_posterior)
  
  return(posterior)
}

# Data sets
data_list <- list(
  c(W=3, L=0),  # (1) W, W, W
  c(W=3, L=1),  # (2) W, W, W, L
  c(W=5, L=2)   # (3) L, W, W, L, W, W, W
)

# Plot posterior for each case
par(mfrow = c(3, 1))  # 3 rows, 1 column
for (i in 1:3) {
  w <- data_list[[i]]["W"]
  n <- sum(data_list[[i]])
  
  posterior <- compute_posterior(w, n, p_grid, prior)
  
  plot(p_grid, posterior, type = "l", lwd = 2,
       xlab = "probability of water (p)", ylab = "posterior probability",
       main = paste("Case", i, ":", w, "W,", n - w, "L"))
}
