# -----------------------------
# Parameters
# -----------------------------
mu <- 10        # true length
sigma <- 0.2    # measurement noise
n <- 1000       # number of simulated measurements

# -----------------------------
# Simulate noisy measurements
# -----------------------------
set.seed(123)
y <- rnorm(n, mean = mu, sd = sigma)

# -----------------------------
# Plot histogram + true PDF
# -----------------------------
# Create histogram
hist(y,
     breaks = 30,
     freq = FALSE,        # density scale
     col = "lightblue",
     border = "white",
     main = "Measurements: y ~ N(10, 0.2^2)",
     xlab = "Measured Length (cm)")

# Add theoretical Gaussian curve
curve(dnorm(x, mean = mu, sd = sigma),
      col = "red",
      lwd = 2,
      add = TRUE)

# Add mean line
abline(v = mu, col = "darkgreen", lwd = 2, lty = 2)

# Add legend
legend("topright",
       legend = c("Simulated data", "True Probability Density Function", "True mean"),
       col = c("lightblue", "red", "darkgreen"),
       lwd = c(10, 2, 2),
       lty = c(1, 1, 2),
       pch = c(15, NA, NA),
       pt.cex = 2)
