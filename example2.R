# Disease cluster?
# Between 1990 and 2011, there were 2,876 "cancer cluster" investigations in the US. 
# Sometimes there is no obvious hypothesis, other times there is.

# 1996-2005 investigation
# Among households less than 10 miles from a nuclear power plant, 
# 80,515 children aged 0-14
# 47 cases of childhood leukemia
# rate of leukemia = 47 / 80,515 = 0.0005839 = 5.839 per 10,000 children

# For comparison
# Among households more than 30 miles from a nuclear power plant, 
# 1,819,636 children aged 0-14
# 851 cases of childhood leukemia
# rate of leukemia = 851 / 1,819,636 = 0.0004677 = 4.677 per 10,000 children

# in epidemiology, ratio of these rates is the incidence ratio
# incidence ratio = 5.839 / 4.677 = 1.2487
# This implies that the rate of leukemia is 23% higher among children living within 10 miles of a nuclear power plant compared to those living more than 30 miles away.
# Is this difference statistically significant?

#Step 1: null hypothesis is that children near nuclear power plants in illinois experience leukemia at the background rate of 4.7 per 10000 
#Step 2: test statistic is the number of leukemia cases. Higher number of cases implies stronger evidence against the null hypothesis
#Step 3: calculate the probability distribution of the test statistic assuming the null hypothesis is true.

# Simulate 80,515 flips that comes up heads 4.7 times per 10,000 flips on average
#80,515 is the number of children living within 10 miles of a nuclear power plant
#4.7 is the background rate of leukemia per 10,000 children

n <- nflip(n=80515, prob = 0.00047)

library(ggplot2)

# simulate 10,000 samples of number of cancer cases
sim_cancer = do(10000)*nflip(n=80515, prob=0.00047)

hist(df$nflip)

# essentially, distribution that is ~47 cases or larger is about 10% (p=0.085)
# this means that the null hypothesis is plausible, we do not have enough evidence to reject it.