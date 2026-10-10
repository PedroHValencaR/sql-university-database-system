# University Relational Database Management System (PostgreSQL / SQL)

A production-grade relational database architecture engineered according to Software Engineering database curriculum standards (*Database Systems: Conceptual, Logical & Physical Modeling*, *Object Creation in PostgreSQL*, and *Relational Normalization from 1NF to 3NF*).

---

## 🏗️ Architectural Overview & Design

### Relational Schema & Normalization
The database models an academic enterprise tracking students, departments, faculty instructors, courses, term enrollments, and academic evaluations.
* **1NF (First Normal Form):** All column attributes are strictly atomic; no repeating groups.
* **2NF (Second Normal Form):** Every non-key attribute is fully functionally dependent on the entire primary key (elimination of partial dependencies in junction tables like `enrollments`).
* **3NF (Third Normal Form):** All transitive dependencies are decoupled into normalized lookup and domain entities (`departments`, `instructors`, `courses`).

---

## 📂 Repository Layout

```text
sql-university-database-system/
├── .gitignore
├── README.md
├── docs/
│   └── ERD_ARCHITECTURE.md              # Conceptual entity relationships & integrity rules
├── schema/
│   ├── 01_ddl_tables.sql                # Physical schema: tables, constraints, indexes & foreign keys
│   └── 02_dml_seed_data.sql             # Real-world seed data for testing
└── queries/
    ├── 03_analytical_reporting_queries.sql  # Complex multi-table JOINs, aggregations & subqueries
    └── 04_acid_transactions_procedures.sql # ACID transactions (COMMIT/ROLLBACK) & trigger logic
```

---

## 🚀 Execution Guide

Compatible with **PostgreSQL 14+** (and standard SQL dialects).

```bash
# 1. Create the database
createdb university_db

# 2. Run DDL schema creation
psql -d university_db -f schema/01_ddl_tables.sql

# 3. Seed sample dataset
psql -d university_db -f schema/02_dml_seed_data.sql

# 4. Run analytical queries
psql -d university_db -f queries/03_analytical_reporting_queries.sql
```

---

## 📄 License
MIT License. Created by Pedro Henrique Valença Ramos.
