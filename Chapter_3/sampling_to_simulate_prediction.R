# A fixed true proportion of water p exists, and that is the target of our inference
# Tossing the globe in the air and catching it produces observations of "water" or "land" that appear in proportion to p and 1 - p, respectively



#binomial distribution
dbinom( 0:2, size=2, prob=0.7)
# 2 tosses of the globe, 3 possible observations (0 water, 1 water, 2 water)
# compute the likelihood of each observation given p=0.7

# [1] 0.09 0.42 0.49
# 9% chance of observing 0 water, 42% chance of observing 1 water, 49% chance of observing 2 water

#now try:
#dbinom( 0:2, size=2, prob=0.5)
# [1] 0.25 0.50 0.25

#random binomial
rbinom(1, size=2, prob=0.7)
rbinom( 10 , size=2 , prob=0.7 )

#simulate 100,000 experiments
#each toss consists of 9 trials
#probability of water on each trial is 0.7
dummy_w <- rbinom( 1e5 , size=9 , prob=0.7 )
simplehist(dummy_w, xlab="dummy water count")
