-- Amount of tickets from 2015-2017
select Count(*) as Ticket_amount, YEAR(IssueDate) as Ticket_year
from [DWH_DATA_ANALYST].[dbo].[FactParkingViolation]
where YEAR(IssueDate) in (2015,2016,2017)
group by YEAR(IssueDate)
order by Ticket_year

-- Ratio betweem amount of tickets from 2017 and 2015
SELECT 
    (CAST(COUNT(CASE WHEN YEAR(IssueDate) = 2017 THEN 1 END) AS decimal(18, 6)) /
    NULLIF(CAST(COUNT(CASE WHEN YEAR(IssueDate) = 2015 THEN 1 END) AS decimal(18, 6)), 0)) * 100 AS Ratio
FROM [DWH_DATA_ANALYST].[dbo].[FactParkingViolation];

-- Amount of tickets per year per state
select Count(*) as Ticket_amount, YEAR(IssueDate) as Ticket_year , DS.StateName
from [DWH_DATA_ANALYST].[dbo].[FactParkingViolation] As PV
LEFT JOIN [DWH_DATA_ANALYST].[dbo].[DimLocation] As DL ON PV.LocationKey = DL.LocationKey
LEFT JOIN [DWH_DATA_ANALYST].[dbo].[DimState] As DS ON DL.StateCode = DS.StateCode
group by DS.StateName, YEAR(IssueDate)
order by Ticket_year