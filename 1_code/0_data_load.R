# Version 20221019

# set up ---------------------------------------------

# packages
library(tidyverse)


# folder 
folder_data <- '3_data'


# import monthly trips ------------------------------

monthly_files <-
  list.files(folder_data, pattern = '*data.zip')


monthly_data <-
  lapply(monthly_files, function(x) {
    read_csv(file.path(folder_data, x)) %>%
      mutate(across(c(start_station_id, end_station_id), ~ as.numeric(.)))
  }) %>%
  bind_rows()


# quick view
glimpse(monthly_data)

addmargins(table(monthly_data$rideable_type))
prop.table(table(monthly_data$rideable_type))

length(unique(monthly_data$start_station_name))

addmargins(table(monthly_data$member_casual))
prop.table(table(monthly_data$member_casual))



# import quarter trips and stations -------------------

quarter_files <- 
  list.files(folder_data, pattern = 'Divvy_*')


# import quarter trips

quarter_data <-
  lapply(quarter_files, function(x){
    read_csv(file.path(folder_data, x)) %>% 
      mutate(start_time = as.character(start_time))
  }) %>% 
  bind_rows()


# import stations


# quick view trips


# quick view stations



