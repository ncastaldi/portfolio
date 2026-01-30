# ⚙️ Infrastructure & Data Automation

> **Production-grade scripts for System Governance and Data Integrity.**

## Overview

This directory contains a collection of scripts designed to eliminate manual toil through automated lifecycle management and data validation. Each tool here was developed using the **AI Orchestration Framework** found in the `/orchestrator` directory to ensure consistent error-handling and logic validation.

## Key Automations

### 🔄 CMDB & Asset Hydration (Python/SQL)

- **Problem**: Manual asset updates were leading to data decay and high MTTR.
- **Solution**: Engineered a Python-based synchronization tool that pulls from SQL/Lansweeper and hydrates the ServiceNow CMDB via REST API.
- **Impact**: Automated 100+ record updates per cycle and contributed to a **38.7% reduction in MTTR**.

### 📊 Office Data Validation (Python/Pandas)

- **Problem**: Inconsistent data in legacy XLSX/CSV office files causing downstream reporting errors.
- **Solution**: Developed validation scripts to perform schema checks, data normalization, and integrity audits on large datasets.
- **Impact**: Reduced stakeholder review time from days to minutes through automated exception reporting.

### 🔐 RBAC Governance (PowerShell)

- **Problem**: Manual audits of Role-Based Access Control were time-consuming and prone to human error.
- **Solution**: Built a PowerShell utility to audit Entra ID (Azure AD) groups and output standardized compliance reports.
