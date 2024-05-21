--Query 1 - Quantity of parking violations per borough between 2015 to 2017:

SELECT Count(parkingviolationkey) AS NumOfParkingViolations,
       boroughname
FROM   factparkingviolation F
       INNER JOIN dimlocation L
               ON L.locationkey = F.locationkey
       INNER JOIN dimborough B
               ON B.boroughcode = L.boroughcode
WHERE  Year(Cast(issuedate AS DATE)) BETWEEN 2015 AND 2017
GROUP  BY boroughname
ORDER  BY 1 DESC 


--CREATE PROCEDURE:
CREATE PROCEDURE Sp_parkingviolationsperborough 
@BoroughName VARCHAR(20)
AS
  BEGIN
      SELECT Count(parkingviolationkey) AS NumOfParkingViolations,
             boroughname
      FROM   factparkingviolation F
             INNER JOIN dimlocation L
                     ON L.locationkey = F.locationkey
             INNER JOIN dimborough B
                     ON B.boroughcode = L.boroughcode
      WHERE  Year(Cast(issuedate AS DATE)) BETWEEN 2015 AND 2017
	  and boroughname= @BoroughName
      GROUP  BY boroughname
      ORDER  BY 1 DESC
  END 

--An example of running the procedure with a borough name:
EXEC Sp_parkingviolationsperborough
  @BoroughName = 'Brooklyn' 