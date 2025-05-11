
# Load
pacman::p_load(RSelenium, rvest, polite, tidyverse)

# Set Drivers
driver  <- rsDriver(browser = "firefox", port = 4550L, verbose = F, chromever = NULL)
browser <- driver$client

# Go to page
browser$navigate(url = 'https://ideas.repec.org/i/ebluesky.html')
repec_url <- browser$getPageSource()[[1]] |> 
  read_html() |> 
  html_elements("a") |> 
  html_attr("href") |> 
  url_absolute(base = "https://ideas.repec.org")

repec_url_clean <- 
  repec_url |> 
  tibble() |> 
  mutate(check = str_detect(repec_url, '.person')) |> 
  dplyr::filter(check == TRUE)

repec_url_clean

# Loop through pages
for (j in 1:10) {
  tryCatch(
    expr = {
  # Browse
  browser$navigate(url = repec_url_clean$repec_url[j])
  #Get the link
  bluesky_link <- 
    browser$getPageSource()[[1]] |> 
    read_html() |> 
    html_elements("a") |> 
    html_attr('href') |> 
    as_tibble() |> 
    mutate(check = str_detect(value, '.bsky.social') ) |> 
    dplyr::filter(check == TRUE) |> 
    pull(value)
  
  repec_url_clean[j, 'Profile'] = bluesky_link
  
  Sys.sleep(3)
  cat("Step", j, 'is done ... \n')
    },
  
  error = function(e) { NULL }
  )
}
















