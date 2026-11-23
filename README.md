# Pentaho-project
# 🛒 BelleVue Distribution Algeria: ETL (Pentaho) & Business Intelligence (Power BI)

A Business Intelligence project completed for the Data Warehouse / Decision Support course (4th-year Computer Science Engineering, Saïda University, 2024/2025).

The project covers the full BI pipeline: **extracting heterogeneous data → transformation and loading (ETL) with Pentaho → MySQL Data Warehouse → Power BI dashboards**.

![Pentaho](https://img.shields.io/badge/Pentaho-Data%20Integration-orange?style=flat-square)
![MySQL](https://img.shields.io/badge/MySQL-Data%20Warehouse-4479A1?style=flat-square&logo=mysql&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboards-F2C811?style=flat-square&logo=powerbi&logoColor=black)
![MongoDB](https://img.shields.io/badge/MongoDB-Source-47A248?style=flat-square&logo=mongodb&logoColor=white)

---

## 📖 Context

**BelleVue Distribution** is a retail distribution company with several stores across Algeria. Its sales data is scattered across **four different systems**, one per city, each with its own format and data quality. The goal is to consolidate everything into a single Data Warehouse so that managers can analyze commercial performance.

| City | Source format |
|---|---|
| Algiers | Excel file |
| Oran | CSV file |
| Constantine | MySQL database |
| Annaba | MongoDB |

## 🏗️ Architecture

```
 ┌───────────────┐
 │ Algiers (Excel)│──┐
 ├───────────────┤  │
 │ Oran (CSV)    │──┤      ┌─────────────────┐      ┌──────────────────┐      ┌────────────┐
 ├───────────────┤  ├────► │ Pentaho PDI     │ ───► │ MySQL Data       │ ───► │ Power BI   │
 │ Constantine   │──┤      │ (ETL: jobs +    │      │ Warehouse        │      │ Dashboards │
 │ (MySQL)       │  │      │ transformations)│      │ (dw_bellevue)    │      │            │
 ├───────────────┤  │      └─────────────────┘      └──────────────────┘      └────────────┘
 │ Annaba        │──┘
 │ (MongoDB)     │
 └───────────────┘
```

## 📁 Repository structure

```
.
├── data/              # Source data (sample / anonymized data)
├── jobs/              # Pentaho jobs (.kjb): ETL orchestration
├── transformation/    # Pentaho transformations (.ktr): extraction, cleaning, loading
├── powerbi/           # Power BI file (.pbix), if included
├── docs/              # Lab report (PDF) and screenshots
└── README.md
```

---

## ⚙️ Part 1: ETL process with Pentaho Data Integration (Lab 4)

The Pentaho transformations and jobs:

1. **Extract** data from the four sources (Excel, CSV, MySQL, MongoDB).
2. **Harmonize** the structures: column names, formats, and products and stores entered differently in each city.
3. **Load** the consolidated data into the MySQL Data Warehouse `dw_bellevue`.
4. Keep **traceability** of each row's origin through the `source_systeme` column.

## 🗄️ Part 2: Data Warehouse model

The model follows a **star schema**.

**Fact table**
- `fait_ventes`: 90 sales transactions

**Dimension tables**

| Table | Content |
|---|---|
| `dim_temps` | 731 days (01/01/2024 → 31/12/2025) |
| `dim_magasin` | stores (Carrefour, Express, Akid Lotfi, etc.) |
| `dim_produit` | 48 products |
| `dim_client` | customers + 1 "UNKNOWN" member |
| `dim_paiement` | payment methods + 1 "UNKNOWN" member |

**Relationships**: each dimension is linked to `fait_ventes` through its key (`temps_key`, `magasin_key`, `produit_key`, `client_key`, `paiement_key`), with many-to-one cardinality and single-direction filtering.

---

## 📊 Part 3: Visualization with Power BI (Lab 5)

### Connection
- Power BI Desktop → *Get data* → **MySQL database**
- Server: `localhost` · Database: `dw_bellevue` · Mode: **Import**
- All 6 tables loaded, relationships auto-detected and checked in the *Model* view.

### Page 1: Sales overview

| Visualization | Type | Purpose |
|---|---|---|
| Sales by month and store | Matrix | Cross analysis of month × store |
| Breakdown by source system | Pie chart | Weight of each source in revenue |
| Products by cumulative purchases | Horizontal bar chart | Identify the products that weigh the most |
| Sales by store and floor area | Donut / pie chart | Relate store size to sales volume |

### Page 2: Detailed product analysis
- **Table** listing the 48 products with quantity sold (230 units in total).

### Preview
> Add your screenshots here, for example:
> `![Dashboard page 1](docs/dashboard_page1.png)`
> `![Dashboard page 2](docs/dashboard_page2.png)`

---

## 🔍 Key findings

- **Total revenue**: about 2.6 M DZD across 90 transactions
- **Dominant source**: Annaba accounts for 93.23% of revenue (2.44 M DZD), Constantine for 3.04%
- **Best-selling products**: whole-grain bread (23 units), mineral water 1.5 L (18), Candia milk 1 L (11)
- **Low-rotation products**: natural honey and white bread 400 g (1 unit each)
- **Top-performing categories**: staple products (bread, milk, water), cooking oils, fresh products

## ⚠️ Limitations

- Short analysis period (data is mostly concentrated in January 2024)
- Strong imbalance between sources (93% Annaba), which limits comparisons between cities
- Small data volume (90 transactions): seasonal trends cannot be analyzed

## 🚀 Future work

- Enrich the Data Warehouse with more historical data
- Rebalance and improve data collection (Annaba, Oran)
- Add trend and seasonality indicators
- Add interactive filters/slicers (period, store, product category)

---

## ▶️ Reproduce the project

**Requirements**: Pentaho Data Integration (Spoon), MySQL, Power BI Desktop, and MongoDB if you want to replay the Annaba source.

1. Create the MySQL database: `CREATE DATABASE dw_bellevue;`
2. Create the Data Warehouse tables (add the SQL script to the repository if available).
3. Open Pentaho (Spoon), then open the job in the `jobs/` folder.
4. Adjust the source file paths and connection settings for your machine.
5. Run the job to populate the Data Warehouse.
6. Open Power BI Desktop, connect to `dw_bellevue` and load the tables.

> 🔒 Connection credentials are not included in this repository. Enter your own in Pentaho.

---

## 👩‍💻 Authors

- **Amina Meroua BOUHMIDI** ([@AminaMar](https://github.com/AminaMar))
- **Nabila Nour Elhouda LABANI** ([@labaninabila193-code](https://github.com/labaninabila193-code))

Supervisor: **Dr. Moulay Tahar**
Faculty of Mathematics, Computer Science and Telecommunications, Department of Computer Science, Saïda University
Academic year 2024 / 2025

## 📄 Note

This project was carried out for educational purposes. The data used comes from a case study.
