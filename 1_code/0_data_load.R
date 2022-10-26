# Version 20221019


# set up ---------------------------------------------

# packages
library(tidyverse)


# folder 
folder_data <- '3_data'
folder_extractdata <- '3_data/extract_data'



# import monthly data ------------------------------

# list files of monthly trip data
monthly_files <-
  list.files(folder_data, pattern = '*data.zip')


# import data
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



# unzip and copy data ----------------------------------

# list files
data_files <- 
  list.files(folder_data, pattern = 'Divvy_*')


# unzip files
filename <-
  lapply(data_files, function(x) {
    unzip(file.path(folder_data, x), exdir = folder_extractdata)
  }) %>%
  unlist() %>%
  as.data.frame() %>%
  rename(FileName = '.') %>% 
  mutate(
    FileName = str_split(FileName, "/") %>% map_chr(~last(.))
  ) %>% 
  filter(str_detect(FileName, 'Divvy_'))


# list unzip folders
unzip_folders <- 
  list.dirs(folder_extractdata)
  

# filter unzipped folders
unzip_folders <- 
  unzip_folders[grepl("Divvy_", unzip_folders)]


# function copy files
copyEverything <- function(from, to){
  
  # search all the files in from directories
  files <- 
    list.files(from, pattern = 'Divvy_')

  
  # copy the files
  file.copy(paste(from, files, sep = '/'), 
            paste(to, files, sep = '/'))
}


# copy all files
for (i in 1:length(unzip_folders)) {
    
  copyEverything(unzip_folders[i], folder_extractdata)
    
  }
  


# import quarterly data ---------------------------------------



# import stations ---------------------------------------------



# load to db -------------------------------------------------
 

