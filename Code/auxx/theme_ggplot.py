
import plotnine as pn
from plotnine import *

# Set 
theme_nice = (
    theme_bw(base_size = 12) + 
    theme(
        plot_title   = element_text(hjust = 0.5, size = 8),
        axis_title   = element_text(),
        axis_title_x = element_text(),
        axis_title_y = element_text(),
        axis_line    = element_line(colour = 'black', linewidth = 0.25),
        strip_text   = element_text(size = 12, colour = 'black', hjust = 0.5),
        strip_background = element_rect(fill = 'white', color = 'white'),
        legend_title     = element_blank(),
        legend_position  = 'bottom',
        panel_border     = element_blank(),
        panel_grid_major = element_line(size = 0.08, color = '#d9d9d9'),
        panel_grid_minor = element_line(size = 0.05, color = '#d9d9d9'),
        axis_ticks       = element_line(color = 'black', linewidth = 0.2),
        figure_size      = (4.5, 3)
    )
)

theme_set(theme_nice)

rgpy_cols = [
  '#407EC9', '#FF8200', '#910048', '#707372', '#001E60', '#78BE20', '#009CDE',  
  '#8031A7', '#658D1B', '#F2A900', '#E35205', '#DA291C', '#231F20', '#00B0B9'
]