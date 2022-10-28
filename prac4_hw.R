library(tidyverse)
library(here)
install.packages("janitor")
library(janitor)
library(sf)
library(dplyr)

##read gender inequality csv data
genderdata <- read.csv(here::here("HDR21-22_Composite_indices_complete_time_series.csv"), 
                       header = TRUE, sep = ",",  
                       encoding = "latin1")
##read spatial data (shp)
worlddata <- st_read(here::here("World_Countries__Generalized_.shp"))
worlddata <- worlddata %>%
  clean_names()
world_gender1 <- worlddata %>%
  left_join(., 
            genderdata,
          by = c("country" = "country"))%>%
  dplyr::select(c(`country`,`gii_2010`,`gii_2019`))
world_gender2 <- world_gender1 %>%
  mutate(difference = gii_2019 - gii_2010)
