# 📊 Bank Loan Data Analysis
> A comprehensive end-to-end analysis of **38,575 bank loan applications** — covering data cleaning, exploratory data analysis, risk assessment, and interactive Power BI dashboards.

---

## 📋 Table of contents
- [Project overview](#project-overview)
- [Dataset](#dataset)
- [Tech stack](#tech-stack)
- [Key KPIs](#key-kpis)
- [Project structure](#project-structure)
- [How to run](#how-to-run)
- [Key findings](#key-findings)
- [Business recommendations](#business-recommendations)
- [Dashboard preview](#dashboard-preview)
- [Author](#author)

---

## 🔍 Project overview

The banking and financial sector relies heavily on data-driven decisions to manage lending risks and optimize loan portfolios. This project analyzes a real-world bank loan dataset to uncover patterns in **borrower behavior**, **loan performance**, and **risk indicators** that can guide smarter lending strategies.

**Objectives:**
1. Loan portfolio overview — distribution of amounts, terms, and grades
2. Borrower profiling — income, employment, and demographic patterns
3. Loan performance analysis — fully paid vs charged-off vs current
4. Risk assessment — key indicators using DTI, grade, and interest rate
5. Geographic analysis — lending patterns across different states
6. Purpose analysis — why borrowers take loans
7. Financial summary — total disbursed vs total recovered

---

## 📁 Dataset

| Property | Value |
|---|---|
| Total records | 38,575 loan applications |
| Total features | 24 columns |
| Source | Real-world bank dataset (2021) |
| Key columns | loan_amount, int_rate, grade, dti, loan_status, annual_income, purpose |

---

## 🛠️ Tech stack

| Tool | Purpose |
|---|---|
| **Python** (Pandas, Matplotlib, Seaborn) | Data cleaning, EDA, visualization |
| **MySQL** | SQL-based queries and aggregations |
| **Microsoft Excel** | Data exploration and pivot analysis |
| **Power BI** | Interactive dashboard and reporting |

---

## 📊 Key KPIs

| Metric | Value |
|---|---|
| Total loan applications | 38,576 |
| Total funded amount | $435.76M |
| Total amount received | $473.07M |
| Net profit gain | $37.31M |
| Average interest rate | 12.05% |
| Average DTI ratio | 13.33% |

---

## 📂 Project structure

```
bank-loan-analysis/
├── data/
│   └── financial_loan 1.0.csv
├── notebooks/
│   └── Bank Loan Data Analysis .ipynb
├── sql/
│   └── bank_loan_data_analysis SQL.sql
├── excel/
│   └── financial_loan 1.0.csv.xlsx
├── powerbi/
│   └── Bank loan Dashboard Power bi.pbix
├── images/
│   └──Bank loan Dashboard Power bi.pdf
└── README.md
```

---

## 🚀 How to run

```bash
git clone https://github.com/your-username/bank-loan-analysis.git
cd bank-loan-analysis
pip install pandas matplotlib seaborn jupyter
jupyter notebook notebooks/bank_loan_eda.ipynb
```

For SQL analysis, import `loan_data.csv` into your MySQL database and run the scripts in `/sql`.

---

## 💡 Key findings

- **83.3%** of loans are fully paid — indicating a healthy, well-performing portfolio
- **Bad loan rate of 13.8%** (charge-offs), notably higher than the 2–5% industry norm
- Charged-off loans recovered only **56.9%** of funded amount vs **117.7%** for good loans
- **Debt consolidation** drives 47% of applications and **57% of total profit** ($21.34M)
- **Small business loans** are the only loss-making category (-$0.31M) despite a 13% interest rate
- **Grade B borrowers** are the most profitable segment ($10.07M), balancing volume and rate
- **Mortgage holders** have the highest avg income ($83,763) and generate the most profit ($19.15M)
- Loan volume grew steadily from **2,332 in Jan to 4,314 in Dec** — strong Q4 demand spike
- DTI alone is a **weak predictor of default** — all segments show 13–15% DTI regardless of outcome

---

## ✅ Business recommendations

1. **Tighten credit screening** beyond DTI — use loan grade, employment history, and purpose as stronger risk gatekeepers
2. **Focus on debt consolidation and credit card** loan segments — highest return on capital deployed
3. **Implement early repayment incentives** and automated reminder systems to improve collections
4. **Increase Q4 fund allocation** to capitalize on seasonal demand growth
5. **Apply stricter underwriting for small business loans** — loss-making despite highest interest rate
6. **Avoid aggressive interest rate hikes** — use risk-based pricing by grade rather than rate alone
7. **Monitor low-income and early-career borrowers** — higher risk despite strong loan demand

---

---

## 👤 Author

**Bipin Chandra Arya**
Data Analyst · Python · SQL · Power BI · Excel

---

*Thank you and happy learning!* 🎓
