# Suppose there are two species of panda bear. Both are equally common in the wild and live
#in the same places. They look exactly alike and eat the same food, and there is yet no genetic assay
#capable of telling them apart.

#So suppose now that a veterinarian comes along who has a new genetic test that she claims can
#identify the species of our mother panda. But the test, like all tests, is imperfect. This is the information you have about the test:
#• The probability it correctly identifies a species A panda is 0.8.
#• The probability it correctly identifies a species B panda is 0.65.
#The vet administers the test to your panda and tells you that the test is positive for species A. First
#ignore your previous information from the births and compute the posterior probability that your
#panda is species A

#So, I want to know:
# Probability A given A result
# Probability B given A result
# Probability A given B result 
# Probability B given B result

#Based on:
# p_correct_A = 0.8 [P(test says A|A)]
# p_incorrect_A = 0.2 [P(test says B|A)]
# p_correct_B = 0.65 [P(test says B|B)]
# p_incorrect_B = 0.35 [P(test says A|B)]
# p_A = 0.5 [P(A)]
# p_B = 0.5 [P(B)]

# Priors
p_A <- 0.5
p_B <- 0.5

# Test accuracy
p_A_given_A <- 0.8
p_B_given_A <- 0.2
p_B_given_B <- 0.65
p_A_given_B <- 0.35

# 1. Posterior: P(A | test says A)
p_testA <- p_A_given_A * p_A + p_A_given_B * p_B
p_A_given_testA <- (p_A_given_A * p_A) / p_testA

# 2. Posterior: P(B | test says A)
p_B_given_testA <- (p_A_given_B * p_B) / p_testA

# 3. Posterior: P(A | test says B)
p_testB <- p_B_given_A * p_A + p_B_given_B * p_B
p_A_given_testB <- (p_B_given_A * p_A) / p_testB

# 4. Posterior: P(B | test says B)
p_B_given_testB <- (p_B_given_B * p_B) / p_testB

# Print results
cat("P(A | test = A):", p_A_given_testA, "\n")
cat("P(B | test = A):", p_B_given_testA, "\n")
cat("P(A | test = B):", p_A_given_testB, "\n")
cat("P(B | test = B):", p_B_given_testB, "\n")




