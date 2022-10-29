```{r}
library(tidyverse)
library(here)
install.packages("janitor")
library(janitor)
library(sf)
library(dplyr)
library(tmap)
library(tmaptools)
install.packages("RColorBrewer")
library(RColorBrewer)

```

```{r}
##read gender inequality csv data
genderdata <- read.csv(here::here("HDR21-22_Composite_indices_complete_time_series.csv"), 
                       header = TRUE, sep = ",",  
                       encoding = "latin1")
##read spatial data (shp)
worlddata <- st_read(here::here("World_Countries__Generalized_.shp"))
worlddata <- worlddata %>%
  st_set_crs(4326) %>%
  clean_names()
```

```{r}
##join data and calculate gii difference between 2010 and 2019
world_gender1 <- worlddata %>%
  left_join(., 
            genderdata,
          by = c("country" = "country"))%>%
  dplyr::select(c(`country`,`gii_2010`,`gii_2019`))
world_gender2 <- world_gender1 %>%
  mutate(difference = gii_2019 - gii_2010)
```

```{r}
tm_shape(world_gender2) + 
  tm_polygons("difference", 
              style="pretty",
              palette="YlGnBu",
              midpoint=NA,
              title="Differences of Gender Inequality Index",
              alpha = 0.5) + 
  tm_compass(position = c("left", "bottom"),type = "arrow",size = 1) + 
  tm_scale_bar(position = c("left", "bottom")) +
  tm_layout(title = "Differences of Gender Inequality Index between 2010 and 2019", legend.position = c("right", "bottom"))

```

