#!/usr/bin/env Rscript
suppressMessages(library(tidyverse))
suppressMessages(library(rvest))
library(stringr)
library(httr)

SFSPCA_BASE <- "https://www.sfspca.org"

fetch_cats_helper <- function(page = 0) {
  message("Reading page ", page, " of cats")
  page_query <- if (page < 1) NULL else list(page = page)
  url <- modify_url(SFSPCA_BASE, path = c("adoptions", "cats"),
                    query = page_query)
  cat_ids <- url %>%
    read_html() %>%
    html_nodes("a") %>%
    html_attr("href") %>%
    str_subset("/adoptions/pet-details/\\d+") %>%
    str_extract("\\d+$")
  if (length(cat_ids) < 1) {
    ## base case
    message("  no more cat listings, over and out")
    cat_ids
  } else {
    ## recursive case
    message("  ", length(cat_ids), " cat listings found")
    c(cat_ids, fetch_cats_helper(page + 1))
  }
}

message("Accessing San Francisco SPCA (Cat Department)...")
cat_ids <- fetch_cats_helper() %>% unique()
message("Cat information system accessed.\n  ",
        length(cat_ids), " unique cats found.\nBeginning weighing process...")

cat_calls <-
  tibble(
    id = cat_ids,
    url = map_chr(id,
                  ~ modify_url(SFSPCA_BASE,
                               path = c("adoptions", "pet-details", .x))),
    resp = map(url, GET),
    status = map_chr(resp, status_code)
  ) %>%
  filter(status == "200") %>%
  mutate(content = map(resp, content))

get_field <- compose(str_trim, html_text, html_node)
cats <- cat_calls %>%
  select(url, content, id) %>%
  mutate(name = map_chr(content, get_field, ".field-name-title h1"),
         weight = map_chr(content, get_field, ".field-name-field-animal-weight .field-item"),
         sex = map_chr(content, get_field, ".field-name-field-gender .field-item")) %>%
  select(name, weight, sex, url, id)

cats <- cats %>%
  extract(weight, "oz", "(\\d*)oz\\.$", remove = FALSE) %>%
  extract(weight, "lbs", "(^\\d+)lbs", remove = FALSE) %>%
  replace_na(list(lbs = 0, oz = 0)) %>%
  mutate(wt = as.integer(lbs) + as.integer(oz)/16,
         pronoun = ifelse(sex == "Female", "She", "He"))

tbl <-
  capture.output(
    cats %>%
      select(name, weight, sex, id) %>%
      as.data.frame() %>%
      print()
  ) %>%
  str_c(collapse = "\n")
message(tbl)

fattest_cat <- which.max(cats$wt)
message(
  str_interp("The fattest cat is ${name}. ${pronoun} weighs ${lbs}lbs ${oz}oz.",
             cats[fattest_cat, ])
)
Sys.sleep(0.5)
message("Opening cat profile...")
Sys.sleep(0.5)
browseURL(cats$url[fattest_cat])
