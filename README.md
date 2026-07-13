# BRFSS-Transgender-Health-Analysis
Analysis of the 2014 BRFSS transgender health dataset using R, including descriptive statistics, demographic summaries, and an R Markdown report.

---

# BRFSS 2014 Transgender Health Analysis
---

## Project Overview

This project analyzes the 2014 Behavioral Risk Factor Surveillance System (BRFSS) dataset to describe demographic characteristics of transgender participants using R.

The analysis includes:

- Age distribution
- Gender identity
- Race/ethnicity
- Education
- Household income
- Summary statistics
- Descriptive tables
- HTML report generated using R Markdown

---

## Dataset

The analysis uses the BRFSS 2014 transgender dataset.

**File**

```
data/transgender_hc_ch2.csv
```

---

## Software

- R 4.5+
- RStudio

Packages used:

- tidyverse
- janitor
- skimr
- gtsummary

---

## Repository Structure

```
BRFSS-Transgender-Health-Analysis/
│
├── data/
├── scripts/
├── output/
├── BRFSS_Transgender_Report.Rmd
├── Assignment2.Rproj
├── README.md
└── .gitignore
```

---

## How to Run

1. Clone the repository.

```
git clone https://github.com/yourusername/BRFSS-Transgender-Health-Analysis.git
```

2. Open

```
Assignment2.Rproj
```

3. Install required packages

```r
install.packages(c(
  "tidyverse",
  "janitor",
  "skimr",
  "gtsummary"
))
```

4. Knit

```
BRFSS_Transgender_Report.Rmd
```

to generate the HTML report.

---

## Author

Kumari Sita

Statistical Computing
