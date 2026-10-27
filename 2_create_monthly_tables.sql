CREATE TABLE monthly_financials AS             -- Create a clean table for monthly data
select 
    "Demarcation_Code" as municipality_id,     -- Keeps the clean name for the city code
    "Name" as municipality_name,               -- Keeps the clean city name
    "Code" as item_code,                       -- Keeps the financial account code
    "Label" as item_description,               -- Keeps the description text
    "Year_End" AS financial_year,              -- Tracks the parent year this month belongs to
    "Period" AS month_number,                  -- Tracks the month number (1 for Jan, 2 for Feb, etc.)
    "Code_1" AS status_code,                   -- Keeps the code for the status
    "Label_1" AS status_description,           -- Keeps the text name for the status label
    "Amount"::NUMERIC AS total_amount          -- Forces the amount to be a clean number
from repairs_maintenance_facts_v2
where "Length" = 'month'                       -- ONLY takes the rows that represent a single month
