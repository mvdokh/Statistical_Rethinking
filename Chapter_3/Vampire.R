# Pr = probability
# P = Positive 
# V = Vampire
# M = Mortal

# PrPV = P(positive | vampire) = probability of testing positive given that the person is a vampire
# PrVP = P(vampire | positive) = probability of being a vampire given that the person tested positive

# Full Equation: Pr(V|P) = Pr(P|V) * Pr(V) / Pr(P)

PrPV <- 0.95
PrPM <- 0.01
PrV <- 0.001
PrP <- PrPV * PrV + PrPM * (1-PrV)
( PrVP <- PrPV * PrV / PrP )

# Probability of being a vampire given a positive test is only 8.7%