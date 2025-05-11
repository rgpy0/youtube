
pacman::p_load(slider, furrr, tidyverse)

# This function estimates market beta of financial assets
estimate_capm <- function(
    data,        # data used for estimations
    var_num,     # Variable number in regressions. y ~ x1 + x2: 1 for x1 and 2 for x2...
    min_obs = 1  # Minimum number of observations in the models
) {
  if (nrow(data) < min_obs) {
    beta <- as.numeric(NA)
  } else {
    fit  <- lm(stock_return ~ market_return, data = data)
    beta <- as.numeric(coefficients(fit)[var_num + 1]) # first coefficient is intercept. Add 1
  }
  return(beta)
}

# This function calculates beta based on rolling regression
roll_capm_estimation <- function(data, var_num, months, min_obs) {
  data <- data |> arrange(month)
  
  betas <- slide_period_vec(
    .x = data,
    .i = data$month,
    .period = "month",
    .f = ~ estimate_capm(., var_num, min_obs),
    .before = months - 1,
    .complete = FALSE
  )
  
  return(tibble(
    month = unique(data$month),
    beta = betas
  ))
}


