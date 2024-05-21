--Query 4 - Two most common parking violations types per vehicle color between 2015 to 2017:
 
SELECT rnumber,
       colorname,
       violationcode,
       numofparkingviolations
FROM   (
		SELECT Row_number() OVER (partition BY vehiclecolorcode ORDER BY Count(parkingviolationkey) DESC) AS RNumber,
               vehiclecolorcode,
               Count(parkingviolationkey) AS NumOfParkingViolations,
               violationcode
        FROM   factparkingviolation F
               INNER JOIN dimvehicle V
                       ON F.vehiclekey = V.vehiclekey
        WHERE  vehiclecolorcode IS NOT NULL
               AND vehiclecolorcode NOT IN ( 'UNK', ' ' )
               AND Year(Cast(issuedate AS DATE)) BETWEEN 2015 AND 2017
        GROUP  BY vehiclecolorcode, violationcode
		) AS Sub1
       INNER JOIN dimcolor C
				ON Sub1.vehiclecolorcode = C.colorcode
WHERE  rnumber IN ( 2, 1 )
ORDER  BY colorname, numofparkingviolations DESC 
