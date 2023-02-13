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
setwd("/Users/alireza/Desktop/data/tif_files/")
# uploading the file
fire21032014_tif <- raster("c_gls_BA300_QL_201503310000_GLOBE_PROBAV_V1.0.1.tiff")
fire21032014_tif
#prepearing data 
fire21032014_tif_stack <- stack(fire21032014_tif)
#ploting data
plot(fire21032014_tif)

fire21032014_df <- as.data.frame(fire21032014_tif, xy = TRUE)%>%na.omit()  


# ggplot + raster 

ggplot(fire21032014_df)   + 
  geom_raster((fire21032014_df) , mapping = aes(x=x, y=y, fill=layer))  
