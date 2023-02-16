
# Import the required packages
library(ncdf4)
library(sp)
library(raster)
library(RStoolbox)
library(viridisLite)
library(viridis)
library(ggplot2)
library(patchwork)

# Set the working directory directory
setwd("C:/Users/amir/OneDrive - Alma Mater Studiorum Università di Bologna (1)/Rosa's dataset/tif_files/four_cases") 

# Let's read the first dataset 
# list all the files with pattern "gls"
rlist <- list.files(pattern="gls")
rlist

# import all the files that has been listed before
import <- lapply(rlist,raster)
import

#stack them and plot them
TGr <- stack(import)
names(TGr) <- c("March 2017","March 2018", "March 2019", "March 2020", "March 2021")

plot(TGr)
# Let's change their names

plot(TGr, names.attr=c("March 2017","March 2018", "March 2019", "March 2020", "March 2021"))

plotRGB(TGr,  r=1, g=2, b=5, stretch = 'lin')
