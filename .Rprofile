
# Load Packages (install if not installed already)
pacman::p_load(scales, tidyverse, here)

# Paths for Data Export and Import
here::here()

dir_data <- here::here('DATA')
dir_figs <- here::here('Output', 'figs')
dir_tabs <- here::here('Output', 'tabs')

# A function to clean console:
cls <- function(){cat("\014") }; cls()

# Custom ggplot2 Theme
theme_nice <- function(){
  theme_bw(base_size = 12) +
    theme(
      plot.title   = element_text(hjust = 0.5, vjust = 2, size = 16),
      axis.title   = element_text(),
      axis.title.x = element_text(hjust = 0.5),
      axis.title.y = element_text(hjust = 0.5),
      axis.line    = element_line(colour = 'black', linewidth = 0.25),
      strip.text   = element_text(hjust = 0.5, colour = 'black', size = 14),
      strip.background = element_rect(fill = 'gray99', color = NA),
      panel.border = element_rect(colour = NA),
      panel.grid.minor = element_blank(),
      panel.grid.major = element_line(linewidth = 0.08, colour = 'gray85'),
      legend.title = element_blank(),
      legend.position = 'bottom',
      axis.ticks = element_line(color = 'black', linewidth = rel(0.75) )
    )
}

theme_set(theme_nice())

# rgpy colors palette
rgpy_colors <- c('#8F3931', '#FF8200', '#407EC9', '#155F83', '#8A9045', '#00B0B9', '#C16622', 
                 '#767676', '#78BE20', '#58593F', '#350E20', '#658D1B', '#707372', '#8031A7')


# Priority to dplyr
conflicted::conflicts_prefer(dplyr::select, dplyr::filter, dplyr::arrange, dplyr::summarise, dplyr::summarize, dplyr::rename, dplyr::across, .quiet = T)




