# dbt Analytics Project (PostgreSQL)
### Overview

This project demonstrates how to use dbt (data build tool) to transform raw operational data into analytics-ready tables using a layered modeling approach.
The project is developed locally using dbt Core, PostgreSQL, and VS Code.

It follows common analytics engineering best practices, including:

- source definitions

- staging, intermediate, and mart layers

- tests and seeds
  
- snapshots and macros

- version-controlled transformations

### Project Structure
```
├── analyses/        # Ad-hoc analysis queries
├── macros/          # Reusable dbt macros
├── models/
│   ├── staging/     # Cleaned, lightly transformed source data
│   ├── intermediate/# Business logic transformations
│   └── mart/        # Final analytics-ready models
├── seeds/           # Static reference data (CSV → tables)
├── snapshots/       # Slowly changing dimension tracking
├── tests/           # Generic and custom tests
├── dbt_project.yml  # dbt project configuration
└── README.md
```
### Data Layers

**Landing (outside dbt)**

- Raw data loaded into PostgreSQL under the l1_landing schema.

**Staging layer**
- Standardized column names, data types, and basic cleaning.

**Intermediate layer**
- Business logic and transformations that combine multiple sources.

**Mart layer**
- Final fact and dimension tables designed for analytics and reporting.
