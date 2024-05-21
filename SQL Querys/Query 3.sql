--Query 3 - Five most common parking violations types between 2015 to 2017:

SELECT TOP(5) Count(parkingviolationkey) AS NumOfParkingViolations,
              violationcode
FROM   factparkingviolation
WHERE  Year(Cast(issuedate AS DATE)) BETWEEN 2015 AND 2017
GROUP  BY violationcode
ORDER  BY 1 DESC

--CREATE PROCEDURE:
CREATE PROCEDURE Sp_mostcommonparkingviolationstypes
@TopN INT
AS
  BEGIN
      SELECT TOP(@TopN) Count(parkingviolationkey) AS NumOfParkingViolations,
                    violationcode
      FROM   factparkingviolation
      WHERE  Year(Cast(issuedate AS DATE)) BETWEEN 2015 AND 2017
      GROUP  BY violationcode
      ORDER  BY 1 DESC
  END 

--An example of running the procedure with a number of the most common parking violations types:
EXEC Sp_mostcommonparkingviolationstypes
  @TopN = 3 