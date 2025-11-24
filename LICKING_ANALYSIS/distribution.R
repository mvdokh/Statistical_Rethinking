# ---------------------------------------
# Load the CSV file
# ---------------------------------------
data <- read.csv("LICKING_ANALYSIS/720.csv")

# Extract the column
vals <- data$Tongue_area_Interval_Max

# ---------------------------------------
# Compute mean and standard deviation
# ---------------------------------------
mu <- mean(vals, na.rm = TRUE)
sigma <- sd(vals, na.rm = TRUE)

cat("Mean =", mu, "\n")
cat("SD   =", sigma, "\n")

# ---------------------------------------
# Plot histogram + Gaussian PDF
# ---------------------------------------
hist(vals,
     breaks = 30,
     freq = FALSE,               # density scale
     col = "lightblue",
     border = "white",
     main = "Distribution of Tongue_area_Interval_Max",
     xlab = "Tongue Area Interval Max")

# Add the estimated Gaussian PDF curve
curve(
  dnorm(x, mean = mu, sd = sigma),
  col = "red",
  lwd = 2,
  add = TRUE
)

# Add vertical line for the mean
abline(v = mu, col = "darkgreen", lwd = 2, lty = 2)

legend("topright",
       legend = c("Data Histogram", "Estimated PDF", "Mean"),
       col = c("lightblue", "red", "darkgreen"),
       lwd = c(10, 2, 2),
       lty = c(1, 1, 2),
       pch = c(15, NA, NA),
       pt.cex = 2)
