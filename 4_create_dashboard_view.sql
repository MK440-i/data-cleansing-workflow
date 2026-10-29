CREATE OR REPLACE VIEW vw_dashboard_annual_comparison AS            -- Create or replace a virtual database view named vw_dashboard_annual_comparison
SELECT 
    actuals.municipality_id,                                        -- Pull the clean unique code for the city (e.g., BUF, CPT)
    actuals.municipality_name,                                      -- Pull the official text name of the municipality
    actuals.item_code,                                              -- Pull the accounting line item classification code
    actuals.item_description,                                       -- Pull the text description of what the financial item is
    actuals.financial_year,                                         -- Pull the calendar reporting year for this financial row
    budgets.total_amount AS budgeted_amount,                        -- Isolate the original budget amount column side-by-side
    actuals.total_amount AS actual_amount,                          -- Isolate the final audited actual spending column side-by-side
    (actuals.total_amount - budgets.total_amount) AS spend_variance -- Calculate the exact difference (Over-spending or Under-spending)
FROM annual_financials actuals                                      -- Start with your clean annual table, filtering for actual spending
JOIN annual_financials budgets                                      -- Join the same table back to itself to extract the budget side
    ON actuals.municipality_id = budgets.municipality_id            -- Match the records on the exact same city code
    AND actuals.item_code = budgets.item_code                       -- Match the records on the exact same accounting code
    AND actuals.financial_year = budgets.financial_year             -- Match the records on the exact same reporting calendar year
WHERE actuals.status_code = 'AUDA'                                  -- Ensure the actuals side strictly pulls Audited Actual records
  AND budgets.status_code = 'ORGB';                                 -- Ensure the budgets side strictly pulls Original Budget records
