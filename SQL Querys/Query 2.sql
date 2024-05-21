--Query 2 - Quantity of parking violations per borough and day of the week between 2015 to 2017:

SELECT Count(parkingviolationkey) AS NumOfParkingViolations,
       boroughname,
       Datename(weekday, Cast(issuedate AS DATE)) AS Day
FROM   factparkingviolation F
       INNER JOIN dimlocation L
               ON L.locationkey = F.locationkey
       INNER JOIN dimborough B
               ON B.boroughcode = L.boroughcode
WHERE  Year(Cast(issuedate AS DATE)) BETWEEN 2015 AND 2017
GROUP  BY boroughname, Datename(weekday, Cast(issuedate AS DATE))
ORDER  BY 2, 3 DESC 


--CREATE PROCEDURE:
CREATE PROCEDURE Sp_parkingviolationsperboroughandday
@WeekDay VARCHAR(20)
AS
  BEGIN
      SELECT Count(parkingviolationkey) AS NumOfParkingViolations,
             boroughname,
             Datename(weekday, Cast(issuedate AS DATE)) AS Day
      FROM   factparkingviolation F
             INNER JOIN dimlocation L
                     ON L.locationkey = F.locationkey
             INNER JOIN dimborough B
                     ON B.boroughcode = L.boroughcode
      WHERE  Year(Cast(issuedate AS DATE)) BETWEEN 2015 AND 2017
      GROUP  BY boroughname, Datename(weekday, Cast(issuedate AS DATE))
	  HAVING datename(weekday,cast(IssueDate as date)) = @WeekDay
      ORDER  BY 2, 3 DESC
  END 

--An example of running the procedure with a day:
EXEC Sp_parkingviolationsperboroughandday
  @WeekDay = 'Sunday' 