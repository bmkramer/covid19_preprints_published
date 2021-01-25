covid_preprints_time_to_publish <- 
  read_csv("data/covid19_preprints_time_to_publish.csv")

covid_preprints_time_to_publish_0 <- 
  read_csv("archive/data/covid19_preprints_time_to_publish.csv")

medrxiv <- covid_preprints_time_to_publish %>%
  filter(source == "medRxiv") %>%
  select(1:5)

medrxiv_0 <- covid_preprints_time_to_publish_0 %>%
  filter(source == "medRxiv") %>%
  select(1:5)
  
medrxiv_cf <- medrxiv %>%
  left_join(medrxiv_0, by = c("source","identifier", "posted_date"))

#of 725 added preprints since last time, none with 'is_preprint_of'

medrxiv_cf <- medrxiv_cf %>%
  filter(!is.na(`is_preprint_of.y`)) %>%
  filter(is.na(`is_preprint_of.x`))

medrxiv_cf <- medrxiv_cf %>%
  rename(`20201127_is_preprint_of` = `is_preprint_of.x`,
         `20201127_preprint_of_doi` = `preprint_of_doi.x`,
         `20201024_is_preprint_of` = `is_preprint_of.y`,
         `20201024_preprint_of_doi` = `preprint_of_doi.y`)

write_csv(medrxiv_cf, "data/medrxiv_cf_20201127.csv")

#of 7367 preprints in both sets (NB 3 missing from original 7370), 
#227 with 'is_preprint_of' last time (OK), 87 of which currently with 'is_preprint_of"

#investigate 140 that had 'is_preprint_of' tag, but no longer do

#all 140 prior to 2020-04-11
#all 87 on or after 2020-04-11 (latest 2020-05-29)


#check more dates from Crossref API for 87+140

medrxiv_cr <- medrxiv %>%
  left_join(medrxiv_0, by = c("source","identifier", "posted_date"))

medrxiv_cr <- medrxiv_cr %>%
  filter(!is.na(`is_preprint_of.y`)) %>%
  rename(`20201127_is_preprint_of` = `is_preprint_of.x`,
         `20201127_preprint_of_doi` = `preprint_of_doi.x`,
         `20201024_is_preprint_of` = `is_preprint_of.y`,
         `20201024_preprint_of_doi` = `preprint_of_doi.y`)

dois <- medrxiv_cr %>%
  pull(identifier)

medrxiv_cr_data <- cr_works_(dois, 
                                     parse = TRUE,
                                     .progress = "time")

medrxiv_cr_data <- map(medrxiv_cr_data, "message") %>%
  compact()

# Function to parse deposited "date parts" to more useful YYYY-MM-DD format
parseCrossrefDepositedDate <- function(deposited) {
  if(length(deposited$`date-parts`[[1]]) == 3) {
    ymd(paste0(sprintf("%02d", unlist(deposited$`date-parts`)), collapse = "-"))
  } else {
    NA
  }
}

parseCR <- function(item) {
  tibble(
    DOI = item$DOI,
    deposited_date = if(length(item$deposited)) parseCrossrefDepositedDate(item$deposited) else NA_character_)
}

# Iterate over cr list and build data frame
medrxiv_cr_df <- map_dfr(medrxiv_cr_data, parseCR)

medrxiv_cr_df <- medrxiv_cr_df %>%
  mutate(DOI = str_trim(str_to_lower(DOI))) %>%
  rename(identifier = DOI) %>%
  distinct()

medrxiv_deposited <- medrxiv_cr %>%
  left_join(medrxiv_cr_df, by = "identifier") %>%
  select(1:3,deposited_date, everything())
  
write_csv(medrxiv_deposited, "20201127/medrxiv_checkdata/medrxiv_cf_deposited.csv")

medrxiv_deposited <- read_csv("20201127/medrxiv_check/medrxiv_cf_deposited.csv")