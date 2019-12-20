#Load Probabilities

# Filedir
filedir <- "https://raw.github.com/christianhof/BioScen1.5_SDM/master/data/"

#Set Dispersal
disp <- "disp1"
year <- 1995
taxa <- c("Amphibian", "Ter_Mammal", "Ter_Bird")

# Define function to read files
grabRemote <- function(url) {
  temp <- tempfile(fileext=".csv.xz")
  download.file(url, temp)
  aap.file <- readr::read_csv(temp)
  unlink(temp)
  return(aap.file)
}

# Predicted SR
library(dplyr)
amphi_sr_gam <- grabRemote(paste0(filedir, taxa[1], "_prob_GAM_", disp, ".csv.xz")) %>% 
  select(c(x,y), matches(paste0(year)))
amphi_sr_gbm <- grabRemote(paste0(filedir, taxa[1], "_prob_GBM_", disp, ".csv.xz")) %>% 
  select(c(x,y), matches(paste0(year)))
mammal_sr_gam <- grabRemote(paste0(filedir, taxa[2], "_prob_GAM_", disp, ".csv.xz")) %>% 
  select(c(x,y), matches(paste0(year)))
mammal_sr_gbm <- grabRemote(paste0(filedir, taxa[2], "_prob_GBM_", disp, ".csv.xz")) %>% 
  select(c(x,y), matches(paste0(year)))
bird_sr_gam <- grabRemote(paste0(filedir, taxa[3], "_prob_GAM_", disp, ".csv.xz")) %>% 
  select(c(x,y), matches(paste0(year)))
bird_sr_gbm <- grabRemote(paste0(filedir, taxa[3], "_prob_GBM_", disp, ".csv.xz")) %>% 
  select(c(x,y), matches(paste0(year)))

# Merge predicted richness
amphi_sr_gam$model <- "GAM"
amphi_sr_gam$group <- "amphibians"
mammal_sr_gam$model <- "GAM"
mammal_sr_gam$group <- "mammals"
bird_sr_gam$model <- "GAM"
bird_sr_gam$group <- "birds"
amphi_sr_gbm$model <- "GBM"
amphi_sr_gbm$group <- "amphibians"
mammal_sr_gbm$model <- "GBM"
mammal_sr_gbm$group <- "mammals"
bird_sr_gbm$model <- "GBM"
bird_sr_gbm$group <- "birds"

sr_predicted <- rbind(amphi_sr_gam, mammal_sr_gam, bird_sr_gam, amphi_sr_gbm, mammal_sr_gbm, 
                      bird_sr_gbm)
rm(amphi_sr_gam, mammal_sr_gam, bird_sr_gam, 
   amphi_sr_gbm, mammal_sr_gbm, bird_sr_gbm)

readr::write_csv(sr_predicted, paste0("data/sr_predicted_ssdm_1995_", disp, ".csv.xz"))

#Load Probabilities

#Set Year and Dispersal
year <- 2080 
disp <- "disp1"
taxa <- c("Amphibian", "Ter_Mammal", "Ter_Bird")

# Predicted SR
amphi_sr_gam <- grabRemote(paste0(filedir, taxa[1], "_prob_GAM_", disp, ".csv.xz")) %>% 
  select(c(x,y), matches(paste0(year)))
amphi_sr_gbm <- grabRemote(paste0(filedir, taxa[1], "_prob_GBM_", disp, ".csv.xz")) %>% 
  select(c(x,y), matches(paste0(year)))
mammal_sr_gam <- grabRemote(paste0(filedir, taxa[2], "_prob_GAM_", disp, ".csv.xz")) %>% 
  select(c(x,y), matches(paste0(year)))
mammal_sr_gbm <- grabRemote(paste0(filedir, taxa[2], "_prob_GBM_", disp, ".csv.xz")) %>% 
  select(c(x,y), matches(paste0(year)))
bird_sr_gam <- grabRemote(paste0(filedir, taxa[3], "_prob_GAM_", disp, ".csv.xz")) %>% 
  select(c(x,y), matches(paste0(year)))
bird_sr_gbm <- grabRemote(paste0(filedir, taxa[3], "_prob_GBM_", disp, ".csv.xz")) %>% 
  select(c(x,y), matches(paste0(year)))

# Merge predicted richness
amphi_sr_gam$model <- "GAM"
amphi_sr_gam$group <- "amphibians"
mammal_sr_gam$model <- "GAM"
mammal_sr_gam$group <- "mammals"
bird_sr_gam$model <- "GAM"
bird_sr_gam$group <- "birds"
amphi_sr_gbm$model <- "GBM"
amphi_sr_gbm$group <- "amphibians"
mammal_sr_gbm$model <- "GBM"
mammal_sr_gbm$group <- "mammals"
bird_sr_gbm$model <- "GBM"
bird_sr_gbm$group <- "birds"

sr_predicted <- rbind(amphi_sr_gam, mammal_sr_gam, bird_sr_gam, 
                      amphi_sr_gbm, mammal_sr_gbm, bird_sr_gbm)
rm(amphi_sr_gam, mammal_sr_gam, bird_sr_gam, amphi_sr_gbm, 
   mammal_sr_gbm, bird_sr_gbm)
readr::write_csv(sr_predicted, paste0("data/sr_predicted_ssdm_", disp, "_", year, ".csv.xz"))
