# 📈 FED Rate Exploratory Data Analysis

This project performs an exploratory data analysis (EDA) to understand how the Federal Reserve's interest rate changes affect key macroeconomic indicators over time. The analysis uses SQL and structured datasets from 2015 to 2023 to visualize and interpret relationships between monetary policy and the broader U.S. economy.

---

##  Datasets Used

- **fed_rates.csv**: Monthly Federal Funds target rate
- **gdp_growth.csv**: Monthly GDP growth rate (approximated)
- **inflation.csv**: CPI index and inflation rate
- **unemployment.csv**: Monthly U.S. unemployment rate
- **retail_sales.csv**: Monthly total U.S. retail sales
- **sp500_close_px.csv**: S&P 500 monthly closing prices

---

##  Tools & Skills

- **SQL**: Aggregations, JOINs, date-time transformations, subqueries
- **Python/Pandas** *(optional extension)*: For data cleaning and advanced analysis
- **Excel/CSV**: Data source formatting

---

##  Key Analytical Focus

- Track Fed rate changes alongside:
  - GDP growth trends
  - Inflation spikes and drops
  - Retail activity fluctuations
  - Labor market responses (unemployment)
  - Equity market movement (S&P 500)
- Investigate **lag effects** between rate hikes/cuts and downstream economic responses
- Use SQL queries to create metrics like rate change deltas, moving averages, and economic divergence markers

---

##  Results Summary

- Interest rate hikes tend to be **followed by declines in GDP growth and retail sales**, though with lags of several months.
- **Unemployment increases modestly** after rate hikes, confirming the cooling effect on the labor market.
- Inflation tends to **peak before rate hikes**, aligning with policy reaction timing.
- The **S&P 500** often shows initial dips after rate increases but rebounds as market expectations reset.
- Retail sales and equity performance showed **the strongest sensitivity** to interest rate direction changes.

---

##  Conclusion

This project highlights how U.S. monetary policy flows through the economy via consumption, labor, and capital markets. SQL was used to orchestrate cross-variable comparisons, helping identify the timing and strength of relationships between central bank decisions and macroeconomic responses.

---
