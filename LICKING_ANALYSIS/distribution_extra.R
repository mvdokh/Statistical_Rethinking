# ---------------------------------------
# Load data
# ---------------------------------------
data <- read.csv("LICKING_ANALYSIS/720.csv")
vals <- data$Tongue_area_Interval_Max

# ---------------------------------------
# Compute mean and standard deviation
# ---------------------------------------
mu_hat <- mean(vals, na.rm = TRUE)
sigma_hat <- sd(vals, na.rm = TRUE)

cat("Mean =", mu_hat, "\n")
cat("SD   =", sigma_hat, "\n\n")

# ---------------------------------------
# Set up file to save plots
# ---------------------------------------
png(filename = "LICKING_ANALYSIS/Tongue_area_analysis.png", width = 1200, height = 800)
par(mfrow = c(2,2))  # 2x2 plots

# ---------------------------------------
# 1. Histogram + Gaussian PDF
# ---------------------------------------
hist(vals,
     breaks = 30,
     freq = FALSE,
     col = "lightblue",
     border = "white",
     main = "Histogram + PDF",
     xlab = "Tongue_area_Interval_Max")
curve(dnorm(x, mean = mu_hat, sd = sigma_hat),
      col = "red", lwd = 2, add = TRUE)
abline(v = mu_hat, col = "darkgreen", lwd = 2, lty = 2)
legend("topright", legend=c("Data Histogram","Estimated PDF","Mean"),
       col=c("lightblue","red","darkgreen"), lwd=c(10,2,2), lty=c(1,1,2), pch=c(15,NA,NA), pt.cex=2)

# ---------------------------------------
# 2. Empirical CDF
# ---------------------------------------
plot(ecdf(vals),
     main = "Empirical CDF",
     xlab = "Tongue_area_Interval_Max",
     ylab = "Cumulative Probability",
     col = "blue", lwd = 2)
# Overlay theoretical Gaussian CDF
curve(pnorm(x, mean = mu_hat, sd = sigma_hat),
      add = TRUE, col = "red", lwd = 2)
legend("bottomright", legend=c("Empirical CDF","Gaussian CDF"),
       col=c("blue","red"), lwd=2)

# ---------------------------------------
# 3. Q-Q Plot (Normality check)
# ---------------------------------------
qqnorm(vals, main = "Q-Q Plot for Normality")
qqline(vals, col = "red", lwd = 2)

# ---------------------------------------
# 4. Posterior of μ (Bayesian)
# Assume Gaussian likelihood, known σ, flat prior
# ---------------------------------------
# Posterior: μ | data ~ N(mean(vals), sigma^2 / n)
n <- length(vals)
posterior_sd <- sigma_hat / sqrt(n)
posterior_mean <- mu_hat

# Plot posterior
x_post <- seq(posterior_mean - 4*posterior_sd, posterior_mean + 4*posterior_sd, length.out = 200)
plot(x_post, dnorm(x_post, mean = posterior_mean, sd = posterior_sd),
     type = "l", lwd = 2, col = "purple",
     main = "Posterior Distribution of μ",
     xlab = "μ", ylab = "Density")
abline(v = posterior_mean, col = "darkgreen", lty = 2, lwd = 2)
legend("topright", legend=c("Posterior PDF","Posterior Mean"),
       col=c("purple","darkgreen"), lwd=c(2,2), lty=c(1,2))

# ---------------------------------------
# Close PNG device
# ---------------------------------------
dev.off()

cat("All plots saved to 'LICKING_ANALYSIS/Tongue_area_analysis.png'\n")
