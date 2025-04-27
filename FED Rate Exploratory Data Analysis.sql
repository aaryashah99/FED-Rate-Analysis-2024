-- Exploratory Data Analysis


-- 1. Descriptive Statistics for Key Economic Variables

-- a) Summary Statistics for Interest Rates (Quarterly)
SELECT 
    COUNT(*) AS total_records, 
    MIN(interest_rate) AS min_rate, 
    MAX(interest_rate) AS max_rate, 
    ROUND(AVG(interest_rate), 2) AS avg_rate, 
    ROUND(STDDEV(interest_rate), 2) AS std_dev_rate
FROM fed_rates;

-- b) Summary Statistics for GDP Growth (Quarterly)
SELECT 
    COUNT(*) AS total_records, 
    MIN(gdp_growth) AS min_gdp, 
    MAX(gdp_growth) AS max_gdp, 
    ROUND(AVG(gdp_growth), 2) AS avg_gdp, 
    ROUND(STDDEV(gdp_growth), 2) AS std_dev_gdp
FROM gdp_growth;


-- 2. Exploring Relationships Between Economic Indicators

-- a) Interest Rates & Inflation: Correlation Analysis
WITH quarterly_data AS (
    SELECT 
        YEAR(i.date) AS years,  
        CEIL(MONTH(i.date) / 3.0) AS quarter,
        AVG(i.inflation_rate) AS inflation_rate,
        AVG(f.interest_rate) AS interest_rate  
    FROM inflation i
    JOIN fed_rates f ON i.date = f.date
    GROUP BY years, quarter
),
average_values AS (
    SELECT 
        AVG(interest_rate) AS avg_interest, 
        AVG(inflation_rate) AS avg_inflation
    FROM quarterly_data
)
SELECT 
    q.years, q.quarter, 
    q.interest_rate, q.inflation_rate,
    ROUND(
        (SUM((q.interest_rate - a.avg_interest) * (q.inflation_rate - a.avg_inflation)) /
         SQRT(SUM(POW(q.interest_rate - a.avg_interest, 2)) * 
              SUM(POW(q.inflation_rate - a.avg_inflation, 2)))
        ), 3
    ) AS correlation_interest_inflation
FROM quarterly_data q
CROSS JOIN average_values a
GROUP BY q.years, q.quarter
ORDER BY q.years DESC, q.quarter DESC;

-- b) Correlation Between Interest Rates & Unemployment
WITH quarterly_data AS (
    SELECT 
        YEAR(i.date) AS years,  
        CEIL(MONTH(i.date) / 3.0) AS quarter,
        AVG(i.unemployment_rate) AS unemployment_rate,
        AVG(f.interest_rate) AS interest_rate
    FROM unemployment i
    JOIN fed_rates f ON i.date = f.date
    GROUP BY years, quarter
),
average_values AS (
    SELECT 
        AVG(interest_rate) AS avg_interest, 
        AVG(unemployment_rate) AS avg_unemployment
    FROM quarterly_data
)
SELECT 
    q.years, q.quarter, 
    q.interest_rate, q.unemployment_rate,
    ROUND(
        (SUM((q.interest_rate - a.avg_interest) * (q.unemployment_rate - a.avg_unemployment)) /
         SQRT(SUM(POW(q.interest_rate - a.avg_interest, 2)) * 
              SUM(POW(q.unemployment_rate - a.avg_unemployment, 2)))
        ), 3
    ) AS correlation_interest_unemployment
FROM quarterly_data q
CROSS JOIN average_values a
GROUP BY q.years, q.quarter
ORDER BY q.years DESC, q.quarter DESC;


-- 3. Analyzing Market Trends and Reactions

WITH quarterly_data AS (
    SELECT 
        YEAR(f.date) AS years,  
        CEIL(MONTH(f.date) / 3.0) AS quarter,
        AVG(f.interest_rate) AS interest_rate,
        AVG(s.sp500_close_px) AS sp500_close
    FROM fed_rates f
    JOIN sp500_close_px s ON f.date = s.date
    GROUP BY years, quarter
),
average_values AS (
    SELECT 
        AVG(interest_rate) AS avg_interest, 
        AVG(sp500_close) AS avg_sp500
    FROM quarterly_data
)
SELECT 
    q.years, q.quarter, 
    q.interest_rate, q.sp500_close,
    ROUND(
        (SUM((q.interest_rate - a.avg_interest) * (q.sp500_close - a.avg_sp500)) /
         SQRT(SUM(POW(q.interest_rate - a.avg_interest, 2)) * 
              SUM(POW(q.sp500_close - a.avg_sp500, 2)))
        ), 3
    ) AS correlation_interest_sp500
FROM quarterly_data q
CROSS JOIN average_values a
GROUP BY q.years, q.quarter
ORDER BY q.years DESC, q.quarter DESC;


-- 4. Examining Retail Sales Trends and Impact of Interest Rate Hikes

WITH quarterly_data AS (
    SELECT 
        YEAR(f.date) AS years,  
        CEIL(MONTH(f.date) / 3.0) AS quarter,
        AVG(f.interest_rate) AS interest_rate,
        AVG(r.retail_sales) AS retail_sales
    FROM fed_rates f
    JOIN retail_sales r ON f.date = r.date
    GROUP BY years, quarter
)
SELECT 
    years, quarter,
    interest_rate,
    retail_sales,
    LAG(interest_rate) OVER (PARTITION BY years ORDER BY quarter) AS prev_interest_rate,
    LAG(retail_sales) OVER (PARTITION BY years ORDER BY quarter) AS prev_retail_sales,
    ROUND(interest_rate - LAG(interest_rate) OVER (PARTITION BY years ORDER BY quarter), 2) AS interest_rate_change,
    ROUND(retail_sales - LAG(retail_sales) OVER (PARTITION BY years ORDER BY quarter), 2) AS retail_sales_change
FROM quarterly_data
ORDER BY years DESC, quarter DESC;


-- 5. Predicting GDP Growth Using Economic Indicators

WITH quarterly_data AS (
    SELECT 
        YEAR(f.date) AS years,  
        CEIL(MONTH(f.date) / 3.0) AS quarter,
        AVG(f.interest_rate) AS interest_rate,
        AVG(r.retail_sales) AS retail_sales,
        AVG(g.gdp_growth) AS gdp_growth
    FROM fed_rates f
    JOIN retail_sales r ON f.date = r.date
    JOIN gdp_growth g ON f.date = g.date
    GROUP BY years, quarter
),
average_values AS (
    SELECT 
        AVG(interest_rate) AS avg_interest, 
        AVG(retail_sales) AS avg_retail,
        AVG(gdp_growth) AS avg_gdp
    FROM quarterly_data
)
SELECT 
    q.years, q.quarter,
    q.interest_rate, q.retail_sales, q.gdp_growth,
    ROUND(
        (SUM((q.interest_rate - a.avg_interest) * (q.gdp_growth - a.avg_gdp)) /
         SQRT(SUM(POW(q.interest_rate - a.avg_interest, 2)) * 
              SUM(POW(q.gdp_growth - a.avg_gdp, 2)))
        ), 3
    ) AS correlation_interest_gdp,
    ROUND(
        (SUM((q.retail_sales - a.avg_retail) * (q.gdp_growth - a.avg_gdp)) /
         SQRT(SUM(POW(q.retail_sales - a.avg_retail, 2)) * 
              SUM(POW(q.gdp_growth - a.avg_gdp, 2)))
        ), 3
    ) AS correlation_retail_gdp
FROM quarterly_data q
CROSS JOIN average_values a
GROUP BY q.years, q.quarter, q.interest_rate, q.retail_sales, q.gdp_growth
ORDER BY q.years DESC, q.quarter DESC;


-- 6. Identifying Market Reaction to Interest Rate Changes

WITH quarterly_data AS (
    SELECT 
        YEAR(f.date) AS years,  
        CEIL(MONTH(f.date) / 3.0) AS quarter,
        AVG(f.interest_rate) AS interest_rate,
        AVG(r.retail_sales) AS retail_sales,
        AVG(g.gdp_growth) AS gdp_growth
    FROM fed_rates f
    JOIN retail_sales r ON f.date = r.date
    JOIN gdp_growth g ON f.date = g.date
    GROUP BY years, quarter
),
average_values AS (
    SELECT 
        AVG(interest_rate) AS avg_interest, 
        AVG(retail_sales) AS avg_retail,
        AVG(gdp_growth) AS avg_gdp
    FROM quarterly_data
)
SELECT 
    q.years, q.quarter,
    q.interest_rate, q.retail_sales, q.gdp_growth,
    ROUND(
        (SUM((q.interest_rate - a.avg_interest) * (q.gdp_growth - a.avg_gdp)) /
         SQRT(SUM(POW(q.interest_rate - a.avg_interest, 2)) * 
              SUM(POW(q.gdp_growth - a.avg_gdp, 2)))
        ), 3
    ) AS correlation_interest_gdp,
    ROUND(
        (SUM((q.retail_sales - a.avg_retail) * (q.gdp_growth - a.avg_gdp)) /
         SQRT(SUM(POW(q.retail_sales - a.avg_retail, 2)) * 
              SUM(POW(q.gdp_growth - a.avg_gdp, 2)))
        ), 3
    ) AS correlation_retail_gdp
FROM quarterly_data q
CROSS JOIN average_values a  -- Ensure CROSS JOIN is properly defined
GROUP BY q.years, q.quarter, q.interest_rate, q.retail_sales, q.gdp_growth
ORDER BY q.years DESC, q.quarter DESC;