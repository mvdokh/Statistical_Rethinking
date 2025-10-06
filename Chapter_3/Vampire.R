#0.001 probability of being a vampire
#0.999 probability of being human
#0.95 probability of testing positive if vampire
#0.01 probability of testing positive if human

PrPV <- 0.95
PrPH <- 0.01
PrV <- 0.001

PrP <- PrPV * PrV + PrPH * (1 - PrV)
PrVP <- (PrPV * PrV) / PrP
