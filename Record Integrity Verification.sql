SELECT 
    (SELECT COUNT(*) FROM annual_financials) AS clean_annual_rows,   -- Count rows in your new annual table (should be 21,089)
    (SELECT COUNT(*) FROM monthly_financials) AS clean_monthly_rows,  -- Count rows in your new monthly table (should be 21,685)
    (SELECT COUNT(*) FROM repairs_maintenance_facts_v2) AS raw_rows;  -- Count total rows in the original raw data table
