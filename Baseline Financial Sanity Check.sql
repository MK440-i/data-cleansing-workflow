SELECT 
    municipality_name AS city,                                       -- Pull the name of the municipality
    financial_year AS year,                                          -- Pull the calendar reporting year
    "status_description" AS audit_status,                            -- Pull the phase label text description
    SUM(total_amount) AS total_spent                                 -- Sum up the amounts to find total spending
FROM annual_financials                                               -- Focus on your cleaned annual dataset
GROUP BY municipality_name, financial_year, "status_description"    -- Group matching fields together to perform the math aggregate
ORDER BY total_spent DESC                                            -- Sort from highest spending record to lowest spending record
LIMIT 5;                                                             -- Look strictly at the top 5 highest results
