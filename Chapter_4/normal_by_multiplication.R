pos <- replicate(1000, sum( runif(16,-1,-1)))


# normal distributions arise from summing random fluctuations
# 12 random numbers between 1 and 1.1
# product of all 12 is computed and returned as output
growth <- replicate(1000, prod(1 + runif(12,0,0.1)))
#dens(growth, norm.comp=TRUE)
#plot(growth)

big <- replicate(1000, prod(1 + runif(12,0,0.5)))
#dens(big, norm.comp=TRUE)
#plot(big)
small <- replicate(1000, prod(1 + runif(12,0,0.01)))
#dens(small, norm.comp=TRUE)
#plot(small)

extreme <- replicate(1000, prod(1 + runif(12,0,4))) # doesnt fit as well to normal
#dens(extreme, norm.comp=TRUE)
#plot(extreme)

# normal by log-multiplication
log.big <- replicate(1000, sum(log(1 + runif(12,0,0.5))))
dens(log.big, norm.comp=TRUE)
plot(log.big)

