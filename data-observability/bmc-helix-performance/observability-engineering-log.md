# Engineering Log: BMC Helix Dashboard Integration

**Tooling:** Microsoft Copilot (Enterprise) + BMC Helix SQL

## 🧪 The Challenge: Non-Standard SQL

The BMC AR System SQL dialect does not support modern features like CTEs (Common Table Expressions) or `date_trunc` functions. This initially caused "Row Drift," where a single technician would have multiple entries for a single month due to time-of-day timestamp variations.

## 🛠️ The Solution: Gated Iteration

1. **Gate 1 (MTTR Logic):** Validated the `DATEDIFF` arithmetic to ensure accurate day-counts between `Submit Date` and `Last Resolved Date`.
2. **Gate 2 (Aggregation):** Implemented a `GROUP BY` on `MONTH()` and `YEAR()` functions to force a single, consolidated record per technician, per month.
3. **Gate 3 (Literal Parsing):** Solved a parsing error by refactoring the date filter to use explicit DD/MM/YYYY HH:MM:SS strings, which the legacy parser could interpret without crashing.
