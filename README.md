# Impact of Federal Reserve Interest Rate Changes on the U.S. Economy (2015–2023)

This project uses SQL to explore the downstream effects of U.S. Federal Reserve rate hikes and cuts on key macroeconomic indicators like GDP, inflation, unemployment, retail sales, and the stock market.

## Files Included

| File Name                          | Description                                 |
|-----------------------------------|---------------------------------------------|
| `fed_rates.csv`                   | Federal Funds Rate (monthly)                |
| `gdp_growth.csv`                  | Monthly GDP growth rate (%)                 |
| `inflation.csv`                   | Monthly CPI inflation (%)                   |
| `unemployment.csv`                | Monthly unemployment rate (%)               |
| `retail_sales.csv`                | Monthly U.S. retail sales (USD)             |
| `sp500_close_px.csv`             | Monthly closing price of S&P 500            |
| `FED_Rate_Exploratory_Data_Analysis.sql` | SQL analysis of all indicators     |

## Project Objective

To explore how interest rate changes by the Federal Reserve correlate with:

- GDP Growth
- Inflation
- Retail Sales
- Unemployment
- S&P 500 performance

The project is **exploratory**, not predictive — its goal is to understand economic behavior under different monetary policy regimes.

## Key Analysis Components

- Quarterly descriptive stats for each indicator
- Lagged effects of rate hikes on GDP and unemployment
- Correlation between:
  - Interest Rates & Inflation
  - Interest Rates & S&P 500
  - Interest Rates & Retail Sales
- Retail and GDP growth during rate hike periods

## Methodology Summary

- Unified all datasets by date and cleaned formats
- Used SQL to calculate moving averages, rate changes, and lagged impacts
- Segmented data by Fed policy regimes (flat, hike, cut, etc.)
- Analyzed how macroeconomic variables responded to these phases

## Sample Insights

- **GDP:** Responds with 3–6 month lag post-hike
- **Inflation:** Peaks before rate hikes begin
- **Retail Sales:** Immediate drop after hikes
- **Unemployment:** Rises slowly over 9–12 months
- **S&P 500:** Short-term dips, long-term recovery

## 🛠Tools Used

- SQL (MySQL/PostgreSQL syntax)
- CSV files (2015–2023, monthly)
- GitHub for version control


