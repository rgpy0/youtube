
library(tidyverse)
library(Rcpp)
library(patchwork)

n <- 30
num_samples <- 1000

# Normal dist:
normal_means <- rnorm(num_samples, mean = 0, sd = 1 / sqrt(n))

# cauchy Dist:
sourceCpp('cauchy_dist.cpp')

cauchy_means <- dist_cauchy(n = n, num_samples = num_samples)

mydata <- tibble(
  dist_norm = normal_means,
  dist_cauchy = cauchy_means
) 

p1 <- 
  mydata |> 
  ggplot(aes(x = dist_norm)) +
  geom_density(fill = 'orange') +
  labs(title = 'Normal Distribution', x = NULL, y = NULL) +
  theme_minimal()

p2 <- 
  mydata |> 
  ggplot(aes(x = dist_cauchy)) +
  geom_density(fill = 'orange') +
  labs(title = 'Cauchy Distribution', x = NULL, y = NULL) +
  theme_minimal()

p1 + p2





