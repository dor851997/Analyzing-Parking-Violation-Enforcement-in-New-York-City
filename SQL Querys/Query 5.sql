--Query 5 - Quantity of vehicles with more than 10 / between 5 to 9/ under 5 violations between 2015 to 2017:

SELECT range,
       Count(vehiclekey) AS NumofVehicles
FROM   (
		SELECT vehiclekey,
               numofviolations,
               CASE
                 WHEN numofviolations >= 10 THEN 'MORE THAN 10'
                 WHEN numofviolations >= 5 AND numofviolations < 9 THEN 'BETWEEN 5 AND 9'
                 ELSE 'LESS THAN 5'
               END AS Range
        FROM   (
				SELECT vehiclekey,
                       Count(parkingviolationkey) AS NumofViolations
                FROM   factparkingviolation
                WHERE  Year(Cast(issuedate AS DATE)) BETWEEN 2015 AND 2017
                GROUP  BY vehiclekey
				) AS Sub1
		) AS Sub2
GROUP  BY range 