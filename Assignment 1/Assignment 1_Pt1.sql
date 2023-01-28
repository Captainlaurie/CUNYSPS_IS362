/* Assignment #1 */

-- How many planes have listed speeds? Answer = 23
SELECT COUNT(*) AS "Flights w Speed" 
FROM planes
WHERE speed IS NOT NULL;

-- What are the minimum and maximum listed speeds? Answer Min = 90, Max = 432
SELECT MIN(speed) FROM planes;
SELECT MAX(speed) FROM planes;


-- What is the total distance flown by all planes in Jan 2013? Answer = 27188805
SELECT SUM(distance) FROM flights
WHERE year = '2013' 
AND month = '1';

-- What is the total distance flown by all planes in January 2013 where the tailnum is missing?
/* Note: I kept getting a null return for this, because when I ran loadflights.sql it  did not properly convert blank spaces to null values. 
   I can't figure out why. */

SELECT SUM(distance) FROM flights
WHERE year = '2013'
AND month = '1'
AND tailnum IS NULL;


-- What is the total distance flown for all planes on July 5, 2013 grouped by aircraft manufacturer?
-- Write this statement first using an INNER JOIN, then using a LEFT JOIN. How do your results compare?
-- Answer = INNER JOIN returns 14 manufacturers with distance for each listed below:
/*
335028 - BOEING
195089 - AIRBUS
78786 - AIRBUS INDUSTRIE
77909 - EMBRAER
31160 - BOMBARDIER INC
15690 - MCDONNELL DOUGLAS AIRCRAFT CO
7486 - MCDONNELL DOUGLAS
4767 - MCDONNELL DOUGLAS CORPORATION
2898 - CESSNA
2199 - AMERICAN AIRCRAFT INC
1157 - GULFSTREAM AEROSPACE
1142 - CANADAIR
1089 - DOUGLAS
937 - BARKER JACK L

The difference is that the LEFT JOIN returns an additional flight that has a NULL value for the manufacturer:
127671 - NULL */


-- INNER JOIN:
SELECT SUM(distance), manufacturer AS 'Manufacturer'
FROM flights
INNER JOIN planes ON flights.tailnum = planes.tailnum
WHERE flights.year = '2013'
AND flights.month = '7'
AND flights.day = '5'
GROUP BY manufacturer;

-- LEFT JOIN (there is no LEFT OUTER JOIN in MySQL):
SELECT SUM(distance), manufacturer AS 'Manufacturer'
FROM flights
LEFT JOIN planes ON flights.tailnum = planes.tailnum
WHERE flights.year = '2013'
AND flights.month = '7'
AND flights.day = '5'
GROUP BY manufacturer;


-- Write and answer at least one question of your own choosing that joins information from at least three of the tables in the flights database.
-- What is the Airline with the most delays on January 1st 2013?
-- Answer = 851 - MQ - Envoy Air


SELECT MAX(arr_delay), flights.carrier AS 'Carrier', airlines.name AS 'Carrier Name'
FROM flights
LEFT JOIN airlines ON flights.carrier = airlines.carrier
WHERE flights.year = '2013'
AND flights.month = '1'
AND flights.day = '1'
GROUP BY flights.carrier;

