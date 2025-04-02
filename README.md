
**Author:** Steven Komárek  
**Date:** April 2025 
# Post-Earnings Announcement Drift (PEAD) in Meme Stocks (2023-2024)

This project analyzes **Post-Earnings Announcement Drift (PEAD)** across 50 of the most notable "meme stocks" from 2023–2024. The analysis was conducted using Python for data collection and R for statistical modeling and visualization.

## Objective

To evaluate whether meme stocks exhibit statistically significant PEAD behavior following quarterly earnings surprises — and if this drift strengthens over time.
 

## Tools Used:
**Python (`yfinance`, `pandas`)** – data collection: earnings surprises, historical price, benchmark returns
**R (`tidyverse`, `broom`, `ggplot2`)** – regression modeling, visualization, and statistical testing
**Excel / QuiverQuant**– meme stock universe sourcing

## Data

- Earnings data from **Yahoo Finance** (`yfinance`)
- Price data: individual stocks and SPY (S&P 500 ETF)
- Universe: 50 meme stocks from QuiverQuant's 2023–2024 lists

## Methodology

1. **Standardized Unexpected Earnings (SUE)**:
   - `SUE = (Reported EPS - Estimate EPS) / stddev(Surprise)`

2. **Post-Earnings Drift Calculation**:
   - Measured abnormal return vs SPY over 1, 2, and 3 months after earnings

3. **Regression Analysis**:
   - Performed `Abnormal Return ~ SUE` per stock and per holding period

4. **Bucketing**:
   - SUE quintiles used to assess drift patterns across surprise magnitudes

## 📊 Key Results
![image](https://github.com/user-attachments/assets/f5d21728-4d74-45c1-9247-959050530e46)
> **Caption:** Distribution of SUE coefficients across all meme stocks shows a roughly normal pattern centered near zero — but with meaningful outliers driving drift in both directions.
![image](https://github.com/user-attachments/assets/21ea585e-6a80-4818-9882-1d41a23cde44)
>  **Caption:** PEAD sensitivity (SUE coefficient) increases slightly with holding period, with wider variation at 2–3 months — suggesting drift builds slowly and is more pronounced for select stocks.
![image](https://github.com/user-attachments/assets/79878e23-ea6f-4454-97d2-990c9fe7a45d)
> **Caption:** Average abnormal returns increase steadily across SUE quintiles, confirming that stronger earnings surprises drive stronger post-announcement drift — especially over longer holding periods.
![image](https://github.com/user-attachments/assets/3df7764d-9cd9-4e54-8fb6-7d91741dafbb)
> **Caption:** Stocks like HOOD and PANW show strong, consistent PEAD over 3 months, while others like AMD exhibit short-term drift that fades — highlighting opportunities for stock-specific post-earnings strategies.



### ✅ T-Test Between Extreme SUE Quintiles:

| Holding Period | Q1 PEAD | Q5 PEAD | Diff   | p-value |
|----------------|---------|---------|--------|---------|
| 1 month        | -7.56%  | +2.23%  | +9.8%  | 0.036   |
| 2 months       | -5.85%  | +5.74%  | +11.6% | 0.063   |
| 3 months       | -9.67%  | +6.81%  | +16.5% | 0.042   |

> Drift increases with holding period — confirming delayed market reaction in meme stocks.

---

### 📈 PEAD by SUE Quintile:

- Clear monotonic pattern: higher SUE → higher PEAD
- Negative surprises drift **downward**, positive ones drift **upward**
- Most drift materializes over 2–3 months

---

### 🏆 Top PEAD-Sensitive Stocks

Highest `Abnormal Return ~ SUE` sensitivity:
- **HOOD**: +25% PEAD over 3 months
- **PANW**, **IBM**, **AMD**: consistent upward drift

---

## 📌 Next Steps

- Backtest long-Q5 strategy across top drift stocks
- Build volatility- or momentum-adjusted PEAD factors
- Integrate market cap, institutional ownership, and sentiment overlays

---

## 📄 License

MIT License.

---

## 🙋‍♂️ About

Built by Steven Komárek — MS Finance | Quantitative Analytics | Market Behavior

Let’s connect on [LinkedIn](https://linkedin.com/in/www.linkedin.com/in/steven-komarek-90a680220) or collaborate!
