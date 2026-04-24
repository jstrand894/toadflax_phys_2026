library(dplyr)
library(spectrolab)
library(dplyr)
library(tidyr)
library(ggplot2)


# Tell R the path to your folder with asd data
data_path <- "data_in/ASD_data/"

# Load that data in!
asd_files <- list.files(data_path, 
                        pattern = "\\.asd$", 
                        recursive = TRUE, 
                        full.names = TRUE)
spec <- read_spectra(asd_files, format = "asd")

# clean up the ends
spec <- spec[, 400:2400] # only take the wvls from 400-2400
# water_bands <- (1350:1460, 1790:1960) 
# spec <- spec[, !wavelengths(spec) %in% water_bands] # optional clean up of atmospheric bands

# Get an interactive plot window!
plot_interactive(spec) # You should be able to see the 2 samples... but there are still 5 files for each...

# Create a dataframe 
spec_df <- as.data.frame(spec, metadata = TRUE)

str(spec_df)



library(tidyverse)
str_extract <- stringr::str_extract
str_remove <- stringr::str_remove

# Add base sample name (strip replicate suffix)
spec_df <- spec_df %>%
  mutate(sample_name_clean = tolower(sub("_\\d+$", "", sample_name)))

# Drop references and test rows
refs <- c("br", "wr", "wb", "dr", "br2", "wr2", "wb2", "dwr2")
spec_df_clean <- spec_df %>%
  filter(!grepl("^test", sample_name_clean)) %>%
  filter(!sub("^[a-h]wk\\d+", "", sample_name_clean) %in% refs)

# Parse metadata
spec_df_clean <- spec_df_clean %>%
  mutate(
    rep       = str_extract(sample_name_clean, "^[a-h]"),
    week      = as.integer(str_extract(sample_name_clean, "(?<=wk)\\d+")),
    exp_group = if_else(rep %in% c("a","b","c","d"), "ad", "eh"),
    remainder = str_remove(sample_name_clean, "^[a-h]wk\\d+")
  )

# Split into two experiment dataframes
spec_ad <- spec_df_clean %>%
  filter(exp_group == "ad") %>%
  mutate(
    species   = str_extract(remainder, "^[yd]"),
    plant_num = as.integer(str_extract(remainder, "(?<=[yd])\\d+")),
    treatment = str_extract(remainder, "[ic]$")
  )

spec_eh <- spec_df_clean %>%
  filter(exp_group == "eh") %>%
  mutate(
    plant_num = as.integer(str_extract(remainder, "\\d+")),
    treatment = str_extract(remainder, "[cmrj](?=l|$)"),
    leaf      = str_extract(remainder, "l\\d+")
  )

spec_df_clean %>%
  filter(exp_group == "ad") %>%
  mutate(
    species   = str_extract(remainder, "^[yd]"),
    plant_num = as.integer(str_extract(remainder, "(?<=[yd])\\d+")),
    treatment = str_extract(remainder, "[ic]$")
  ) %>%
  filter(!is.na(species)) %>%
  select(sample_name, sample_name_clean, rep, week, species, plant_num, treatment) %>%
  distinct() %>%
  head(20)
spec_eh %>% select(sample_name_clean, rep, week, plant_num, treatment, leaf) %>% 
  distinct() %>% head(20)



# average the 5 files per sample
spec_avg <- spec_df %>% 
  mutate(ID = gsub("_.*", "", sample_name)) %>% 
  pivot_longer(cols = -c(sample_name, ID),
               names_to = "wavelength", 
               values_to = "reflectance") %>% 
  mutate(wavelength = as.numeric(wavelength)) %>% 
  group_by(ID, wavelength) %>% 
  summarise(mean_refl = mean(reflectance, na.rm = TRUE), .groups = "drop")