p_grid <- seq( from=0 , to=1 , length.out=1000 )
prior <- rep( 1 , 1000 )
likelihood <- dbinom( 6 , size=9 , prob=p_grid )
posterior <- likelihood * prior
posterior <- posterior / sum(posterior)
set.seed(100)
samples <- sample( p_grid , prob=posterior , size=1e4 , replace=TRUE )

plot(samples)
x <- mean(samples < 0.2) #makes sense
y <- mean(samples > 0.8)

#plot as bar
x <- mean(samples < 0.2) 
y <- mean(samples > 0.8)


vals <- c(x, y)
names(vals) <- c("p < 0.2", "p > 0.8")

barplot(vals,
        col = c("skyblue", "tomato"),
        ylim = c(0, max(vals) * 1.2),
        ylab = "Posterior probability",
        main = "Posterior tail probabilities")

# what chunk of posterior probability is between 0.2 and 0.8
k <- mean(samples > 0.2 & samples < 0.8)


# 20% of posterior probability lies below which value of p?
v <- quantile(samples, 0.2)

# 20% of posterior probability lies above which value of p? 
b <- quantile(samples, 0.8)

# Which values of p contain the narrowest interval equal to 66% of posterior probability?
library(rethinking) # for highest posterior density interval function
z <- HPDI(samples, prob=0.66)
# | 0.66 | = 0.508 and 0.773

# What values of p contain 66% of the posterior probability, assuming equal posterior probability both above and below the interval?
e <- PI(samples, prob=0.66)

