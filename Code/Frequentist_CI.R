
rm(list = ls())
library(tidyverse)
theme_set(theme_minimal())

x <- rnorm(100)
y <- 2*x + rnorm(100)
df <- cbind(x,y) %>% as_tibble()

models   <- list()
coef_s   <- c() # Betas
coef_int <- c()

for (j in 1:10) {
  df_ <- sample_n(df, 20)
  models[[j]]  <- lm(y ~ x,  data = df_)
  coef_int[j]  <- models[[j]]$coefficients[1]
  coef_s[j]    <- models[[j]]$coefficients[2]
}

coef_int
coef_s

(p <- df %>% 
    ggplot(aes(x, y)) +
    geom_point(size = 1.5) )

for (j in 1:10) {
  p <- p + 
    geom_abline(intercept = coef_int[j], slope = coef_s[j], color = 'red')
}

p + geom_smooth(method = 'lm', color = 'blue', size = 2, se = F)


# Bayesian Estimation
library(rstanarm)
library(bayestestR)
m_bayes <- stan_glm(y ~ x, prior = normal(), prior_intercept = normal(),
                   data = df)

# Posterior Values for X
post_vals <- m_bayes %>% as_tibble() %>% select(x)

post_vals %>% 
  estimate_density(extend = F) %>% 
  ggplot(aes(x = x, y = y)) +
  geom_area(fill = "red", color = "blue", alpha = 0.3, linetype = 2) +
  labs(x = "", y = "") + theme_minimal()




