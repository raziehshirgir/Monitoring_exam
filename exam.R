
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
setwd("C:/("/Users/alireza/Desktop/lab/")") 

# Let's read the first dataset 
# list all the files with pattern "gls"
rlist <- list.files(pattern="gls")
rlist

# import all the files that has been listed before
import <- lapply(rlist,raster)
import

#stack them and plot them

fire_stack <- stack(import)
names(fire_stack) <- c("March_2015",
                "March_2016",
                "March_2017",
                "March_2018", 
                "March_2019", 
                "March_2020", 
                "March_2021",
                "March_2022")

plot(fire_stack) 

# Let's plot 
plotRGB(fire_stack,  r=1, g=2, b=6, stretch = 'lin')
plotRGB(fire_stack,  r=1, g=2, b=8, stretch = 'lin')
plotRGB(fire_stack,  r=1, g=2, b=7, stretch = 'lin')


# 
pairs( fire_stack ) 
albedoPCA2019 <- rasterPCA(fire_stack)
summary(albedoPCA2019$model)# PC1 d e s c r i b e s 94%
plot( albedoPCA2019$map )










# Let's crop Eroupe - do this later
#ext<- c(-180, 180, -90, 90)
#extension <- crop(fire_stack, ext) 

#plot(extension)


