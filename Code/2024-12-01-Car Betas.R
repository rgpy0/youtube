
pacman::p_load(slider, furrr, tidyverse)

# Read Data
source('Code/auxx/estimate_capm.R')

# Car Names
carnames <- tibble(
  'Symbol'  = c('TSLA', 'BMWYY', 'F', 'GM', 'MBGYY', 'VWAGY'),
  'carname' = c('Tesla', 'BMW',  'Ford', 'General Motors', 'Mercedes Benz', 'Volkswagen')
)


# read prepare data
df0 <- read.csv(here(dir_data, 'stocks_with_index.csv')) |> 
  tibble() |> 
  mutate(
    Date = as.Date(Date),
    month = floor_date(Date, 'month')
  ) |> 
  select(Symbol, Company, Date, month, stock_return, market_return) |> 
  drop_na() |> 
  left_join(carnames, by = 'Symbol')

df0

beta_data <- df0 |>
  nest(data = -c(carname))

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
  select(carname, month, beta_market = beta)

# Highly skewed data
plot_density <- beta_market |> 
  ggplot(aes(x = beta_market, fill = carname)) +
  geom_density() +
  facet_wrap(~carname, scales = 'free_x') +
  theme(legend.position = 'none') +
  labs(y = 'Density', x = 'Market Beta', caption = 'Youtube: @rgpy') +
  scale_fill_uchicago()

plot_density

plot_ts <- beta_market |> 
  ggplot(aes(x = month, y = beta_market, color = carname)) +
  geom_line() +
  facet_wrap(~carname, scales = 'free_x') +
  theme(legend.position = 'none') +
  labs(y = 'Date', y = 'Market Beta') +
  labs(caption = 'Youtube: @rgpy') +
  scale_color_uchicago()

plot_ts

ggsave(plot = plot_density, filename = 'Output/plot_density.png', width = 10, height = 7.5, dpi = 300)
ggsave(plot = plot_ts,      filename = 'Output/plot_ts.png',    , width = 10, height = 7.5, dpi = 300)


