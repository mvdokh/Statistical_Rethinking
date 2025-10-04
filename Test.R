install.packages("tidyverse")
library(tidyverse)

# Create a data frame
my_data <- data.frame(
  x = c(1, 2, 3, 4, 5, 10, 3, 4, 5),
  y = c(2, 4, 1, 5, 3, 8, 1, 5, 2)
)

# Create a scatter plot
ggplot(data = my_data, aes(x = x, y = y)) +
  geom_point()

# Create a line plot
ggplot(data = my_data, aes(x = x, y = y)) +
  geom_line()

