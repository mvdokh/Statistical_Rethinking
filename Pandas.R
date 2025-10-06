#2H1. Suppose there are two species of panda bear. Both are equally common in the wild and live
#in the same places. They look exactly alike and eat the same food, and there is yet no genetic assay
#capable of telling them apart. They differ however in their family sizes. Species A gives birth to twins
#10% of the time, otherwise birthing a single infant. Species B births twins 20% of the time, otherwise
#birthing singleton infants. Assume these numbers are known with certainty, from many years of field
#research.

#Now suppose you are managing a captive panda breeding program. You have a new female panda
#of unknown species, and she has just given birth to twins. What is the probability that her next birth
#will also be twins?

# Equally common species
p_A <- 0.5
p_B <- 0.5

# Likelihoods: p(twins | species)
p_twins_A <- 0.10
p_twins_B <- 0.20

# Marginal probability (Care about twins only, not which species). Law of total probability
p_twins <- p_A * p_twins_A + p_B * p_twins_B

# Posterior probability that mother is A given twins
p_A_given_twins <- (p_A * p_twins_A) / p_twins

# Posterior probability that mother is B given twins
p_B_given_twins <- (p_B * p_twins_B) / p_twins

# Probability that next birth will ALSO be twins
# P(next twins given the observed twins) = P(twins from mother A)*P(mother A is the mother given twins) + P(twins from mother B)*P(mother B is the mother given twins)
p_next_twins <- p_twins_A * p_A_given_twins + p_twins_B * p_B_given_twins

cat("P(A | twins) =", p_A_given_twins, "\n")
cat("P(B | twins) =", p_B_given_twins, "\n")
cat("P(next twins | first twins) =", p_next_twins, "\n")