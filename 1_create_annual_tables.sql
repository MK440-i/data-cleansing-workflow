CREATE TABLE annual_financials AS              -- Create a clean table for yearly data
select 
    "Demarcation_Code" as municipality_id,     -- Fixed: Added double quotes around the uppercase name
    "Name" as municipality_name,
    "Code" as item_code,
    "Label" as item_description,
    "Year_End" AS financial_year,              -- Fixed: Added double quotes around the uppercase name
    "Code_1" AS status_code,                   -- Fixed: Added double quotes around the uppercase name
    "Label_1" AS status_description,           -- Fixed: Added double quotes around the uppercase name
    "Amount"::NUMERIC AS total_amount          -- Fixed: Added double quotes around the uppercase name
from repairs_maintenance_facts_v2
where "Length" = 'year'



