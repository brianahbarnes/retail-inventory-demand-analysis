# Retail Inventory & Demand Forecasting Analysis

Statistical analysis of 72,427 retail transactions in R, examining how 
well demand forecasts, inventory levels, and replenishment decisions 
align with actual sales.

## Business Question
How well does the retail system align forecasts, inventory, and 
replenishment with actual sales?

## Key Findings
- Demand forecasts are highly correlated with actual sales (r = 0.997), 
  but consistently overestimate demand by ~5.1 units on average
- Inventory constrains sales in ~3.6% of cases where forecasted demand 
  exceeded available stock
- Order quantities show essentially no relationship with actual sales 
  or forecast demand (r = -0.001)
- A regression model shows inventory adds a statistically significant 
  but practically negligible improvement in explaining sales (R² 
  unchanged at 0.9937)

## Tech Stack & Methods
- **Language:** R
- **Methods:** correlation analysis, linear regression, comparing models to see if inventory adds anything beyond demand forecasts, checking for forecast bias
- **Visuals & Presentation:** R base plots, Canva
  
## Files
- `analysis.R` — full data cleaning and analysis script
- `presentation.pdf` — slides summarizing findings


## Data Source
[Kaggle: Retail Store Inventory and Sales Data](https://www.kaggle.com/datasets/sandhyapeesara/retail-store-inventory)
