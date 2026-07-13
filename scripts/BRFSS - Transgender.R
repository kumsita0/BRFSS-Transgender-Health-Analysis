# Assignment 2 – BRFSS 2014 Transgender Health
# Author: Kumari Sita
# Date: 7/12/2026
# Purpose: Descriptive statistics of transgender participants


# Load packages
library(tidyverse)
library(janitor)
library(skimr)
library(gtsummary)


# Import CSV file
brfss <- read_csv(
  "Assignment 2/transgender_hc_ch2.csv",
  show_col_types = FALSE
)


# Check dataset structure
names(brfss)


# Select transgender participants and required variables
trans_small <- brfss %>%
  filter(TRNSGNDR %in% c(1, 2, 3)) %>%
  select(
    TRNSGNDR,
    PHYSHLTH,
    X_RACE,
    X_INCOMG,
    X_EDUCAG,
    X_AGE80,
    X_AGEG5YR
  )

# Number of transgender participants
nrow(trans_small)


# Clean and label variables
trans_small <- trans_small %>%
  mutate(
    
    # Gender identity
    TRNSGNDR = factor(
      TRNSGNDR,
      levels = c(1, 2, 3),
      labels = c(
        "Male-to-female",
        "Female-to-male",
        "Gender non-conforming"
      )
    ),
    
    # Race / ethnicity
    X_RACE = factor(
      X_RACE,
      levels = c(1, 2, 3, 4, 5),
      labels = c(
        "White",
        "Black",
        "American Indian/Alaska Native",
        "Asian",
        "Other race"
      )
    ),
    
    # Income
    X_INCOMG = factor(
      X_INCOMG,
      levels = c(1, 2, 3, 4, 5),
      labels = c(
        "< $15,000",
        "$15,000–$24,999",
        "$25,000–$34,999",
        "$35,000–$49,999",
        "≥ $50,000"
      )
    ),
    
    # Education
    X_EDUCAG = factor(
      X_EDUCAG,
      levels = c(1, 2, 3, 4),
      labels = c(
        "Less than high school",
        "High school graduate",
        "Some college or technical school",
        "College graduate"
      )
    ),
    
    # Age
    X_AGE80 = as.numeric(X_AGE80),
    X_AGEG5YR = factor(X_AGEG5YR),
    
    # Physical health missing values
    PHYSHLTH = na_if(PHYSHLTH, 77),
    PHYSHLTH = na_if(PHYSHLTH, 99)
  )


# View cleaned dataset
glimpse(trans_small)


####################################################
# Descriptive Statistics
####################################################


# Numeric variables
numeric_summary <- trans_small %>%
  summarise(
    mean_age = mean(X_AGE80, na.rm = TRUE),
    sd_age = sd(X_AGE80, na.rm = TRUE),
    median_phys = median(PHYSHLTH, na.rm = TRUE),
    iqr_phys = IQR(PHYSHLTH, na.rm = TRUE)
  )

numeric_summary


# Categorical variables

gender_table <- tabyl(trans_small, TRNSGNDR)
race_table <- tabyl(trans_small, X_RACE)
income_table <- tabyl(trans_small, X_INCOMG)
education_table <- tabyl(trans_small, X_EDUCAG)
age_table <- tabyl(trans_small, X_AGEG5YR)


gender_table
race_table
income_table
education_table
age_table


####################################################
# Overall descriptive summary
####################################################

skim(trans_small)


####################################################
# Publication-style summary table
####################################################

table1 <- trans_small %>%
  tbl_summary(
    statistic = list(
      all_continuous() ~ "{mean} ({sd})",
      all_categorical() ~ "{n} ({p}%)"
    ),
    missing = "ifany"
  ) %>%
  bold_labels()


table1


####################################################
# Physical Health Category
####################################################

# Median cutoff
med_phy <- median(
  trans_small$PHYSHLTH,
  na.rm = TRUE
)


# Create health category
trans_small <- trans_small %>%
  mutate(
    phys_health_cat = case_when(
      PHYSHLTH > med_phy ~ "Poor physical health",
      PHYSHLTH <= med_phy ~ "Good physical health",
      TRUE ~ NA_character_
    ),
    phys_health_cat = factor(phys_health_cat)
  )


# Check category counts
table(
  trans_small$phys_health_cat,
  useNA = "ifany"
)


####################################################
# Final summary table including health category
####################################################

table2 <- trans_small %>%
  tbl_summary(
    statistic = list(
      all_continuous() ~ "{median} ({p25}, {p75})",
      all_categorical() ~ "{n} ({p}%)"
    ),
    missing = "ifany"
  ) %>%
  bold_labels()


table2


####################################################
# End of Analysis
####################################################