-- BMC Helix Dashboard: Technician Monthly Performance Aggregation
-- Engineered via Microsoft Copilot to navigate AR System SQL limitations
SELECT 
    T."Assignee" AS Technician,
    -- Aggregating by Month/Year to eliminate time-of-day row drift
    MONTH(T."Last Resolved Date") AS Month_Num,
    YEAR(T."Last Resolved Date") AS Audit_Year,
    -- MTTR Calculation using AR-specific DATEDIFF
    AVG(DATEDIFF('dd', T."Submit Date", T."Last Resolved Date")) AS Avg_MTTR_Days,
    -- Priority Distribution logic via SUM(CASE)
    SUM(CASE WHEN T."Priority" = 'P1' THEN 1 ELSE 0 END) AS P1_Volume,
    SUM(CASE WHEN T."Priority" = 'P2' THEN 1 ELSE 0 END) AS P2_Volume,
    SUM(CASE WHEN T."Priority" = 'P3' THEN 1 ELSE 0 END) AS P3_Volume,
    SUM(CASE WHEN T."Priority" = 'P4' THEN 1 ELSE 0 END) AS P4_Volume
FROM 
    INCIDENT_TABLE T
WHERE 
    T."Assigned Group" = 'TEAM_DESKSIDE'
    AND T."Status" IN ('Resolved','Closed')
    -- Filter logic optimized for AR System Date literals
    AND T."Last Resolved Date" >= '01/01/2025 00:00:00'
GROUP BY 
    T."Assignee", MONTH(T."Last Resolved Date"), YEAR(T."Last Resolved Date")
ORDER BY 
    Technician ASC, Month_Num ASC;