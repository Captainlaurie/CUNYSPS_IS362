-- Assignment 1 SQL statement for csv file
-- This statement shows the average departure delays in each month of 2013 for NY airports, grouped by airport, ordered by month.

SELECT flights.month,
AVG(flights.dep_delay) AS 'Avg Departure Delay',
airports.name AS 'Airport Name'
FROM flights
LEFT JOIN airports ON flights.origin = airports.faa
WHERE flights.year = 2013
GROUP BY flights.month, airports.name
ORDER BY flights.month;