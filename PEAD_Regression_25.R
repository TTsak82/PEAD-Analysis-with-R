library(tidyverse)
library(broom)

#Load Data
pead <- read_csv("PEAD_all_tickers.csv")

#View Data
glimpse(pead)

#Create nested data by ticker and holding period
pead_models <- pead %>%
  group_by(ticker,period_months) %>%
  filter(n() >= 4) %>% #Min Data Requirement
  nest() %>%
  mutate(model = map(data, ~lm(abnormal_return ~ sue, data = .x)),
         tidied = map(model, tidy),
         glanced = map(model, glance)) %>%
  unnest(tidied) %>%
  filter(term == "sue") %>% # on;y keep slope on SUE
  unnest(glanced, names_sep = "_") # brings R2 etc.

#Create Table of Results
pead_results <- pead_models %>%
  select(ticker,period_months,estimate,p.value,glanced_r.squared,glanced_nobs) %>%
  rename(
    coef_sue = estimate,
    r_squared = glanced_r.squared,
    n_obs = glanced_nobs
  )

#Top Significant SUE-PEAD relationships
pead_results %>%
  filter(p.value < 0.10, abs(coef_sue) > 0.05) %>%
  arrange(p.value) %>%
  print(n=20)

#Visualize Distributions

#Histogram of SUE Coefficients
ggplot(pead_results, aes(x = coef_sue)) + 
  geom_histogram(fill = 'steelblue', bins = 30, color= 'white') +
  facet_wrap(~period_months) + 
  labs(title = "Distribution of SUE Coefficients",
       x = "Coefficient on SUE",
       y = 'Count') + 
  theme_minimal()

#Boxplot of Coef by Holding Period
ggplot(pead_results, aes(factor(period_months), coef_sue)) +
  geom_boxplot(fill = 'lightblue') +
  labs(title = "SUE ~ PEAD Coefficients by Holding Period",
       x = "Holding Period (Months)",
       y = "SUE Coefficient") + 
  theme_minimal()

#Create SUE Buckets
library(dplyr)

pead_buckets <- pead %>%
  mutate(
    sue_bucket = ntile(sue, 5) #Create Quantiles from 1 (low) to 5 (High)
  )

#Calculate Mean PEAD per Bucket and Period
pead_summary <- pead_buckets %>%
  group_by(period_months,sue_bucket) %>%
  summarise(
    avg_abnormal_return = mean(abnormal_return, na.rm = TRUE),
    n = n()
  )%>%
  ungroup()

#Plot Average PEAD by SUE Bucket
library(ggplot2)

ggplot(pead_summary, aes( x = factor(sue_bucket), y = avg_abnormal_return, fill = factor(period_months))) +
  geom_col(position = "dodge") + 
  labs(title = " Average PEAD by SUE Quintile and Holding Period",
    x = "SUE Quintile ( 1 = Most Negative Surprise, 5 = Most Positive)",
    y = "Average Abnormal Return",
    fill = "Holding Period (Months)"
  ) +
  theme_minimal()

#T-tests btwn Extreme SUE Buckets (Q1 vs Q5) for each Holding Period
t_test_results <- pead_buckets %>%
  filter(sue_bucket %in% c(1,5)) %>%
  group_by(period_months) %>%
  summarise(
    t_test = list(t.test(abnormal_return ~ sue_bucket)),
    .groups = "drop"
  ) %>%
  mutate(
    p_value = map_dbl(t_test, ~.x$p.value),
    mean_q1 = map_dbl(t_test, ~.x$estimate[1]),
    mean_q5 = map_dbl(t_test, ~.x$estimate[2]),
    mean_diff = mean_q5 - mean_q1
  ) %>%
  select(period_months,mean_q1,mean_q5,mean_diff,p_value)
t_test_results

# Top 5 most Significant Stocks
top5 <- pead_results %>%
  filter(p.value < 0.1) %>%
  arrange(p.value) %>%
  distinct(ticker) %>%
  head(5) %>%
  pull(ticker)
top5


#Visualize PEAD for Top 5
pead %>%
  filter(ticker %in% top5) %>%
  group_by(ticker,period_months) %>%
  summarise(mean_pead = mean(abnormal_return, na.rm = TRUE), .groups = 'drop') %>%
  ggplot(aes(x = factor(period_months), y = mean_pead, group = ticker, color = ticker)) +
  geom_line(size = 1.2) +
  geom_point(size = 3) + 
  labs(title = "Top 5 PEAD-Sensitive Meme Stocks",
    x = "Holding Period (Months)",
    y = "Average Abnormal Return",
    color = "Ticker"
  )+
  theme_minimal()
