Objective:To analyze historical macroeconomic data and identify patterns, correlations, and lagged relationships among key indicators such as interest rates, inflation, unemployment, GDP growth, retail sales, and the stock market.

Data Sources (assumed from table names):
fed_rates: Interest rates (Fed)
inflation: Inflation rate data
unemployment: Unemployment rate
gdp_growth: Quarterly GDP growth
retail_sales: Monthly retail sales
sp500_close_px: S&P 500 closing prices

Key Analyses Performed:
Descriptive Statistics: Calculated count, mean, standard deviation, min, and max for interest rates and GDP growth.
Correlation Analyses:
- Interest rates vs. inflation
- Interest rates vs. unemployment
- Interest rates vs. S&P 500
- Interest rates & retail sales vs. GDP growth
All correlations computed using SQL-based Pearson correlation logic over quarterly averages.

Lag Analysis (using LAG()):
Detected delayed impact of interest rate changes on retail sales by comparing quarterly differences.

Techniques Used:
Common Table Expressions (CTEs)
SQL Window Functions (LAG())
Aggregate Functions (AVG(), STDDEV())
Manual computation of Pearson correlation
