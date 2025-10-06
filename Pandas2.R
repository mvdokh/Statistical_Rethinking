#2H1. Suppose there are two species of panda bear. Both are equally common in the wild and live
#in the same places. They look exactly alike and eat the same food, and there is yet no genetic assay
#capable of telling them apart. They differ however in their family sizes. Species A gives birth to twins
#10% of the time, otherwise birthing a single infant. Species B births twins 20% of the time, otherwise
#birthing singleton infants. Assume these numbers are known with certainty, from many years of field
#research.

#Now suppose you are managing a captive panda breeding program. You have a new female panda
#of unknown species, and she has just given birth to twins. What is the probability that her next birth
#will also be twins?

#Continuing on from the previous problem, suppose the same panda mother has a second birth
#and that it is not twins, but a singleton infant. Compute the posterior probability that this panda is
#species A.

# Equally common species
p_A <- 0.5
p_B <- 0.5

# Likelihoods: p(twins | species)
p_twins_A <- 0.10
p_twins_B <- 0.20

# Posterior becomes the new prior
p_A_given_twins <- 1/3
p_B_given_twins <- 2/3

# Likelihood: p(singleton | species)
p_singleton_A <- 1 - 0.10
p_singleton_B <- 1 - 0.20

# Marginal probability (Care about twins only, not which species). Law of total probability
p_twins <- p_A * p_twins_A + p_B * p_twins_B

# Probability that birth 1 = twin, birth 2 = singleton, AND mother is A
# P(A | twins, singleton) 
p_A_given_twins_singleton <- (p_A_given_twins * p_singleton_A) /
  (p_A_given_twins * p_singleton_A + p_B_given_twins * p_singleton_B)

cat("P(A | twins, singleton) =", p_A_given_twins_singleton, "\n")
cat("P(B | twins, singleton) =", 1 - p_A_given_twins_singleton, "\n")