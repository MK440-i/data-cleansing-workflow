# South African Municipality Financial Health Dashboard

An end-to-end data engineering and visualization project that extracts, cleans, and normalizes a messy, unformatted municipal repairs and maintenance dataset. The finalized pipeline loads data into an optimized local PostgreSQL instance via DBeaver and exposes a fully interactive, production-ready executive dashboard in Power BI.

---

## 🚀 Key Features & Project Milestones
* **Data Cleansing & Transformation:** Automated the manual sorting of overlapping temporal granularities (years vs. months) from a single raw text source file.
* **Database Optimization:** Created a normalized, indexable relational schema in PostgreSQL to optimize query execution and eliminate table redundancy.
* **SQL View Engineering:** Structured a unified database `VIEW` utilizing multi-key self-joins to calculate real-time budget variances.
* **Enterprise Power BI Analytics:** Designed a high-impact financial dashboard tracking over 100bn ZAR in municipal expenditures with fully reactive slice-and-dice mechanics.

---

## 🗄️ Database Architecture & Normalization

The primary challenge of the raw dataset (`repairs_maintenance_facts_v2`) was its highly redundant, flat structure. Temporal lines were mixed together: rows tracking complete years duplicated column titles while rows tracking individual months changed the functional definition of tracking variables. 

To resolve this, the data was partitioned into two distinct relational tables inside PostgreSQL:

### 1. Annual Financials (`annual_financials`)
Isolates systemic rows captured purely on a yearly horizon (`Length = 'year'`), preserving auditing statuses like Audited Actuals (`AUDA`) or Original Budgets (`ORGB`).
* **Rows Tracked:** 21,089
* **Data Types Applied:** Explicit `NUMERIC` parsing for currencies and `INT` casting for time parameters.

### 2. Monthly Financials (`monthly_financials`)
Isolates operational rows captured on a monthly scale (`Length = 'month'`), removing redundant structural columns and creating a clean `month_number` index (1-12) for time-series evaluation.
* **Rows Tracked:** 21,685

---

## 💻 SQL Implementations (Executed via DBeaver)

### 📈 Dashboard Variance View Creation
To bypass heavy row filtering on the frontend visualization layer, this query creates a permanent virtual `VIEW` that aligns a municipality's budget and actual spending side-by-side on the exact same record line:

```sql
CREATE OR REPLACE VIEW vw_dashboard_annual_comparison AS
SELECT 
    actuals.municipality_id,
    actuals.municipality_name,
    actuals.item_code,
    actuals.item_description,
    actuals.financial_year,
    budgets.total_amount AS budgeted_amount,
    actuals.total_amount AS actual_amount,
    (actuals.total_amount - budgets.total_amount) AS spend_variance
FROM annual_financials actuals
JOIN annual_financials budgets
    ON actuals.municipality_id = budgets.municipality_id
    AND actuals.item_code = budgets.item_code
    AND actuals.financial_year = budgets.financial_year
WHERE actuals.status_code = 'AUDA'
  AND budgets.status_code = 'ORGB';
```

---

## 📊 Power BI Visualization Layer

The dashboard transforms the optimized database views into interactive data assets across four focal analytic quadrants:

1. **Executive KPI Header Summary:** Real-time metrics cards calculating total cumulative actual spending (~109.2bn), total approved budget (~135.0bn), and net fiscal variance (~-25.8bn).
2. **Municipal Spend Rankings:** A clustered horizontal bar chart ranking the highest spending public entities, directly identifying the *City of Johannesburg*, *City of Cape Town*, and *eThekwini* as the top-tier expenditure centers.
3. **Monthly Trend Line (Time-Series):** A chronological monthly graph mapped from months 1 through 12, exposing seasonal operational spending fluctuations throughout the active fiscal cycle.
4. **Account Category Deep-Dive:** An itemized resource chart breaking down maintenance costs into structural allocations like *Contracted Services* and *Inventory Consumed*.
5. **Interactive Controls:** Docked slicers for **Expense Type** and **Financial Year** enabling instantaneous cloud cross-filtering.

---

## 🛠️ Tech Stack & Tools Used
* **Database Client:** DBeaver Community Edition
* **Database Engine:** PostgreSQL
* **Visualization BI Tool:** Microsoft Power BI Desktop
* **Version Control:** Git & GitHub Desktop
