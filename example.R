library(tidyverse)
library(mosaic)

# Simulate 10,000 games where the Patriots flip a coin 25 times
patriots_sim = do(10000)*nflip(25)

nineteen_or_more_wins <- sum(patriots_sim >= 19)
probability_19_or_more <- nineteen_or_more_wins / 10000

#probability of patriots winning 19 or more games is 0.0066

# The four steps of hypothesis testing
# Step 1: state null hypothesis, or "hypothesis of no effect". here the null hypothesis is that the pre-game coin toss in the patriots game was truly random.
# Step 2: we use a test statistic, or a numerical summary to measure the strength of evidence against the null hypothesis. Here the test statistic is that the number of Patriots coin toss wins out of 25: higher number entails stronger evidence against the null hypothesis. (25/25 means there is a smaller probability of the null hypothesis being true; reject it, coin toss is not random)
# Step 3: calculate the probability distribition of the test statistic assuming that the null hypothesis is true. Here we simulated 10,000 monte carlo simulations (with each having 25 coin tosses) assuming an unbiased coin. 
# Step 4: assess the distribution in step 3 to assess whether the null hypothesis seemed capable of explaining the observed test statistic. 

# probability_19_or_more is 0.0066, which is less than 0.05, so we reject the null hypothesis that the coin toss was random. 

# p-value is the probability of observing a test statistic as extreme as or more extreme than the test statistic actually observed, given that the null hypothesis is true. a probability distribution for test statistic.