# Post-Earnings Announcement Drift (PEAD) Analysis

This repository contains an academic-style analysis of the Post-Earnings Announcement Drift anomaly. The project includes a full R codebase, detailed results, and research findings aimed at understanding the relationship between Standardized Unexpected Earnings (SUE) and post-earnings abnormal returns.

**Author:** Steven Komárek  
**Date:** May 2024  
**Tools Used:** R, tidyverse, quantmod, ggplot2, rvest, PerformanceAnalytics

## 📈 Project Overview

This project investigates the **Post-Earnings Announcement Drift (PEAD)** anomaly using R and a sample of 50 large and small cap U.S. stocks. The analysis tests whether **Standardized Unexpected Earnings (SUE)** can explain abnormal post-earnings returns, challenging the semi-strong form of market efficiency.

## 🧠 Key Findings

- A strong, statistically significant relationship was found between **SUE and PEAD**, particularly in **2023**, with an adjusted R² of **50.61%**.
- Stocks with **abnormally high SUE** in Period 2 (30–60 days post-earnings) demonstrated the most consistent drift.
- 20% of the sampled stocks showed a statistically significant relationship between SUE and PEAD with **Adjusted R² values from 14% to 49%**.

## 🛠 Methodology

- **Data scraped** from [streetinsider.com](https://www.streetinsider.com) using `rvest`
- Daily returns and S&P 500 data sourced via `quantmod`
- Cumulative return windows analyzed: **1, 2, and 3 months post-announcement**
- Multiple regression models evaluated for different subsamples:
  - By year (2022, 2023, 2024)
  - Abnormal SUE subsets
  - By return period
  - Individual stocks

## 📁 Files

- `PEAD_Komarek.R`: Full analysis pipeline
- `PEAD_Report_Steven.pdf`: Research paper with results and discussion
- `figs/`: Visualizations from regression analysis and exploratory plots

## 🧪 Future Work

- Automate earnings scraping for larger datasets
- Incorporate NLP sentiment scores from earnings call transcripts
- Apply the same methodology to international markets

## 📫 Contact

Feel free to connect on [LinkedIn](https://www.linkedin.com/in/steven-komarek-90a680220)  
Or reach me at: stevenkomarek1@gmail.com

---

> “This nearly 60-year-old anomaly still has a pulse.”
