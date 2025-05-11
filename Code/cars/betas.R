
pacman::p_load(slider, furrr, tidyverse)

# Read Data
source('estimate_capm.R')

# read prepare data
df0 <- read.csv('stocks_with_index.csv') |> 
  tibble() |> 
  mutate(
    Date = as.Date(Date),
    month = floor_date(Date, 'month')
  ) |> 
  select(Symbol, Company, Date, month, stock_return, market_return) |> 
  drop_na()

df0

beta_data <- df0 |>
  nest(data = -c(Symbol))

beta_data

# Calculate beta's: (Takes 10 minutes to run)
betas_daily <- beta_data |>
  mutate(
    beta_market = future_map(data, ~roll_capm_estimation(., var_num = 1, months = 3, min_obs = 50) )
) 

betas_daily

# Get the betas
beta_market <- betas_daily |> 
  unnest(beta_market) |> 
  select(Symbol, month, beta_market = beta)

# Highly skewed data
beta_market |> 
  ggplot(aes(x = beta_market)) +
  geom_density() +
  facet_wrap(~Symbol, scales = 'free_x')
  
beta_market |> 
  ggplot(aes(x = month, y = beta_market, color = Symbol)) +
  geom_line() +
  theme_bw() +
  facet_wrap(~Symbol, scales = 'free_x')
