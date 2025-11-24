library(rethinking) 
data(Howell1) 
d <- Howell1 
d2 <- d[ d$age >= 18 , ]

#Height and weight of individuals above 18. looks correlated
plot( d2$weight , d2$height ,
      xlab="weight (kg)" , ylab="height (cm)" )

#Knowing weight might help predict height
#How do we take our gaussian model from the previous section and incorporate predictor values?

#The strategy is to make the parameter for the mean of a gaussian distribution (mu) a linear function of the predictor variable and other new parameters that we invent
#This is called a linear model
#It instructs the golem to assume that the predictor variable has a perfectly constant and additive relationship to the mean of the outcome

#For weight to height function: mu = a + b*weight
m4.3 <- map( 
            alist( 
                  height ~ dnorm( mu , sigma ) , 
                  mu <- a + b*weight , a ~ dnorm( 156 , 100 ) , 
                  b ~ dnorm( 0 , 10 ) , 
                  sigma ~ dunif( 0 , 50 ) 
                ), 
                data=d2 )

