# 📉 BMC Helix: Technician Performance Dashboard

**Domain:** ITSM Telemetry / Post-Merger Integration

## 🏗️ The Challenge

Post-merger data fragmentation made it difficult to track accurate **Mean Time to Resolve (MTTR)**. The primary hurdle was the **AR System SQL** dialect, which lacks modern features (CTEs, date-truncation), causing "Row Drift" and duplicate data in standard monthly reports.

## 🛠️ The Solution: Iterative AI-Assisted Engineering

Using **Microsoft Copilot (Enterprise)**, I navigated the limitations of the legacy SQL parser through a gated, iterative workflow.

- **Dialect Navigation:** Engineered legacy-compliant SQL using `DATEDIFF` and `SUM(CASE)` logic to group 15+ months of data into a single source of truth.
- **Validation Gates:** Systematically solved date-literal parsing errors that previously crashed the dashboard panels.
- **Generative BI:** Utilized AI to rapidly prototype query structures, reducing development time from days to hours.

## 📊 Impact

- **MTTR Visibility:** Contributed to the tracking of a **38.7% reduction in resolution times**.
- **Governance:** Provided distribution of ticket volume by Priority (P1-P4), allowing leadership to reallocate resources based on actual workload.

## 📁 Related Artifacts

- **[Final SQL Query](./technician-metrics.sql)**
- **[Engineering & Troubleshooting Log](./observability-engineering-log.md)**
