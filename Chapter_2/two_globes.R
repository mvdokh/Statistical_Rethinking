# 2M3. Suppose there are two globes, one for Earth and one for Mars. The Earth globe is 70% covered
# in water. The Mars globe is 100% land. Further suppose that one of these globes—you don’t know
# which—was tossed in the air and produced a “land” observation. Assume that each globe was equally
# likely to be tossed. Show that the posterior probability that the globe was the Earth, conditional on
# seeing “land” (Pr(Earth|land)), is 0.23.

# Priors
p_earth <- 0.5
p_mars <- 0.5

# Likelihood of Priors
p_land_given_mars <- 1.0
p_land_given_earth <- 0.3

numerator <- p_land_given_earth * p_earth
denominator <- numerator + (p_land_given_mars * p_mars)

# Posterior probability that it is Earth, given land
p_earth_given_land <- numerator/denominator
p_earth_given_land