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

#Also included p A twins twins, p B twins twins, p A single single, p B single single

# Given / known
p_A <- 0.5
p_B <- 0.5

p_twins_A <- 0.10
p_twins_B <- 0.20

p_singleton_A <- 1 - p_twins_A
p_singleton_B <- 1 - p_twins_B

# --- Posterior after observing: first = twins, second = singleton ---
# Posterior after first twins (intermediate)
p_A_given_twins <- (p_A * p_twins_A) / (p_A * p_twins_A + p_B * p_twins_B)
p_B_given_twins <- 1 - p_A_given_twins

# Update after second observation = singleton
p_A_given_twins_singleton <- (p_A_given_twins * p_singleton_A) /
  (p_A_given_twins * p_singleton_A + p_B_given_twins * p_singleton_B)
p_B_given_twins_singleton <- 1 - p_A_given_twins_singleton

# --- Joint probabilities (species AND sequence of births) ---
# P(A and twins, then twins)
p_A_TT <- p_A * p_twins_A * p_twins_A

# P(B and twins, then twins)
p_B_TT <- p_B * p_twins_B * p_twins_B

# P(A and singleton, then singleton)
p_A_SS <- p_A * p_singleton_A * p_singleton_A

# P(B and singleton, then singleton)
p_B_SS <- p_B * p_singleton_B * p_singleton_B

# Print everything
cat("Posterior after observations (twins, then singleton):\n")
cat(sprintf("  P(A | twins, singleton) = %.4f\n", p_A_given_twins_singleton))
cat(sprintf("  P(B | twins, singleton) = %.4f\n\n", p_B_given_twins_singleton))

cat("Joint probabilities (species AND sequence of two births):\n")
cat(sprintf("  P(A and twins, then twins)       = %.4f\n", p_A_TT))
cat(sprintf("  P(B and twins, then twins)       = %.4f\n", p_B_TT))
cat(sprintf("  P(A and singleton, then singleton)= %.4f\n", p_A_SS))
cat(sprintf("  P(B and singleton, then singleton)= %.4f\n", p_B_SS))