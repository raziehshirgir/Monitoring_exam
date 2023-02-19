# Install the libraries 

install.packages("sf")
install.packages("sp")
install.packages("raster")
install.packages("Rstoolbox")
install.packages("viridisLite")
install.packages("viridis")
install.packages("tidyr")


# ========== Import the libraries 
# To crop the Region of Interest,i.e., Italy
library(sf)

# Raster files 
library(sp)
library(raster)


# Mathematical tools 
library(RStoolbox)

# For plotting Purposes
library(viridisLite)
library(viridis)
library(tidyr)


# ======== Set the Directory and relative paths 


base_dir <- "/Users/alireza/Desktop/lab/"
shape_path <- paste0(base_dir, "countries_shape/ne_10m_admin_0_countries.shp") # Shape path 

# Dataset path 
setwd(paste0(base_dir, "data_set_yearly/"))
# Let's read the data and label it 
ds_list_2015 <- base::list.files(path=".", pattern = "2015")
ds_list_2016 <- base::list.files(path=".", pattern = "2016")
ds_list_2017 <- base::list.files(path=".", pattern = "2017")
ds_list_2018 <- base::list.files(path=".", pattern = "2018")
ds_list_2019 <- base::list.files(path=".", pattern = "2019")
ds_list_2020 <- base::list.files(path=".", pattern = "2020")
ds_list_2021 <- base::list.files(path=".", pattern = "2021")
 

# Convert .tif to Raster objects 
ds_2015 <- base::lapply(ds_list_2015, raster)
ds_2016 <- base::lapply(ds_list_2016, raster)
ds_2017 <- base::lapply(ds_list_2017, raster)
ds_2018 <- base::lapply(ds_list_2018, raster)
ds_2019 <- base::lapply(ds_list_2019, raster)
ds_2020 <- base::lapply(ds_list_2020, raster)
ds_2021 <- base::lapply(ds_list_2021, raster)


# stack .tif files 
ds_stack_2015 <- raster :: stack(ds_2015)
ds_stack_2016 <- raster :: stack(ds_2016)
ds_stack_2017 <- raster :: stack(ds_2017)
ds_stack_2018 <- raster :: stack(ds_2018)
ds_stack_2019 <- raster :: stack(ds_2019)
ds_stack_2020 <- raster :: stack(ds_2020)
ds_stack_2021 <- raster :: stack(ds_2021)

# Let's plot the world - Blue means colder and Red means Hotter 
cl <- colorRampPalette(c('light blue', 'dark red'))(1000)
#plot(ds_stack, col = cl)

# Let's crop Italy & Focus the Analysis on Italy

country <- "Italy"
shapes <- sf :: st_read(shape_path)
Italy_shape <- shapes %>%
  dplyr::filter(ADMIN == country)

Italy_ex <- raster::extent(Italy_shape)

Italy_crop_2015 <- raster::crop(x = ds_stack_2015 ,y = Italy_ex)
Italy_crop_2016 <- raster::crop(x = ds_stack_2016 ,y = Italy_ex)
Italy_crop_2017 <- raster::crop(x = ds_stack_2017 ,y = Italy_ex)
Italy_crop_2018 <- raster::crop(x = ds_stack_2018 ,y = Italy_ex)
Italy_crop_2019 <- raster::crop(x = ds_stack_2019 ,y = Italy_ex)
Italy_crop_2020 <- raster::crop(x = ds_stack_2020 ,y = Italy_ex)
Italy_crop_2021 <- raster::crop(x = ds_stack_2021 ,y = Italy_ex)

Italy_ds_2015 <- raster::mask(x = Italy_crop_2015, mask = Italy_shape)
Italy_ds_2016 <- raster::mask(x = Italy_crop_2016, mask = Italy_shape)
Italy_ds_2017 <- raster::mask(x = Italy_crop_2017, mask = Italy_shape)
Italy_ds_2018 <- raster::mask(x = Italy_crop_2018, mask = Italy_shape)
Italy_ds_2019 <- raster::mask(x = Italy_crop_2019, mask = Italy_shape)
Italy_ds_2020 <- raster::mask(x = Italy_crop_2020, mask = Italy_shape)
Italy_ds_2021 <- raster::mask(x = Italy_crop_2021, mask = Italy_shape)



plot(Italy_ds_2015$layer.1, col = cl)

# Do the PCA & see the outcome 
pca_2015 <- rasterPCA(Italy_ds_2015)
pca_2018 <- rasterPCA(Italy_ds_2018)
pca_2021 <- rasterPCA(Italy_ds_2021)

# Summary of PCAs 
summary(pca_2015$model)
summary(pca_2018$model)
summary(pca_2021$model)



cl <- colorRampPalette(c('light blue', 'dark red'))(1000)
plot(pca_2015$map$PC1, col = cl, xlab="Longitude", ylab="Latitude", main = "2015")
plot(pca_2018$map$PC1, col = cl, xlab="Longitude", ylab="Latitude", main = "2018")
plot(pca_2021$map$PC1, col = cl, xlab="Longitude", ylab="Latitude", main = "2021")


# plot the RGB for difference: 
# let's stack them to make the rgb plot
rgb_stack <- raster :: stack(pca_2015$map$PC1, pca_2018$map$PC1, pca_2021$map$PC1)
plotRGB(rgb_stack,  r=1, g=2, b=3, stretch = 'lin', main = "RGB plot")

# Make a histogram of data 

hist_it_2015 <- hist(Italy_ds_2015 , xlim = c(200, 280), ylim = c(0, 500), col = cl)
hist_it_2016 <- hist(Italy_ds_2016 , xlim = c(200, 280), ylim = c(0, 500), col = cl)
hist_it_2017 <- hist(Italy_ds_2017 , xlim = c(200, 280), ylim = c(0, 500), col = cl)
hist_it_2018 <- hist(Italy_ds_2018 , xlim = c(200, 280), ylim = c(0, 500), col = cl)
hist_it_2019 <- hist(Italy_ds_2019 , xlim = c(200, 280), ylim = c(0, 500), col = cl)
hist_it_2020 <- hist(Italy_ds_2020 , xlim = c(200, 280), ylim = c(0, 500), col = cl)
hist_it_2021 <- hist(Italy_ds_2021 , xlim = c(200, 280), ylim = c(0, 500), col = cl)

# plot just one histogram 
hist(Italy_ds_2015$layer.1, col = cl, main = "Histogram of January 2015")

# plot just one zoomed histogram 
hist(Italy_ds_2015$layer.1, col = cl, main = "Zoomed Version Histogram of January 2015", xlim = c(200, 280), ylim = c(0, 500) )


hist_it_2021
# Count the high temperature for several years :D 
sequence_loop <- seq(1, 12, by=1)  
sequence_loop


italy_hot_2015 <- rep(NA, 12)
italy_hot_2016 <- rep(NA, 12)
italy_hot_2017 <- rep(NA, 12)
italy_hot_2018 <- rep(NA, 12)
italy_hot_2019 <- rep(NA, 12)
italy_hot_2020 <- rep(NA, 11)
italy_hot_2021 <- rep(NA, 12)

na_checker <- function(x) {if (is.na(x)){ 0 } else {x}} 
na_checker(100)

for(indx  in sequence_loop)
{
  total_temp_2015 <- hist_it_2015[[indx]]$counts[12] + hist_it_2015[[indx]]$counts[14]
  italy_hot_2015[indx] <- total_temp_2015 
  
  total_temp_2016 <- na_checker(hist_it_2016[[indx]]$counts[12]) + na_checker(hist_it_2016[[indx]]$counts[14])
  italy_hot_2016[indx] <- total_temp_2016 
  
  total_temp_2017 <- hist_it_2017[[indx]]$counts[12] + na_checker(hist_it_2017[[indx]]$counts[14]) 
  italy_hot_2017[indx] <- total_temp_2017 
  
  total_temp_2018 <- hist_it_2018[[indx]]$counts[12] + hist_it_2018[[indx]]$counts[14]
  italy_hot_2018[indx] <- total_temp_2018 
  
  total_temp_2019 <- hist_it_2019[[indx]]$counts[12] + hist_it_2019[[indx]]$counts[14]
  italy_hot_2019[indx] <- total_temp_2019 

  total_temp_2021 <- hist_it_2021[[indx]]$counts[12] + hist_it_2021[[indx]]$counts[14]
  italy_hot_2021[indx] <- total_temp_2021 
}
sequence_loop = seq(1,11, by = 1)
for(indx  in sequence_loop)
{
  total_temp_2020 <- hist_it_2020[[indx]]$counts[12] + hist_it_2020[[indx]]$counts[14]
  italy_hot_2020[indx] <- total_temp_2020 
  
}

ts_seq <- seq(as.Date("2015/1/1"), as.Date("2021/11/1 "), by = "month")
(ts_seq)

df <- data.frame(date = ts_seq,
                 Number = c(italy_hot_2015,
                            italy_hot_2016,
                            italy_hot_2017,
                            italy_hot_2018,
                            italy_hot_2019,
                            italy_hot_2020,
                            italy_hot_2021))


df
write.csv(df, file="final_time_series_data.csv")
plot(ts_seq,df$Number, type="l", col="blue", ylim = c(0,600), xlab ="Time", 
     ylab= "Number of hot points")
legend("topleft", legend = c("Italy"),
       col = c("blue" ),
       lty = 1)

