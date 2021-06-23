-- Query all columns for all American cities in the CITY table with populations larger than 100000. The CountryCode for America is USA.

select * 
from city 
where CountryCode = 'USA' and
population > 100000

-- Query the NAME field for all American cities in the CITY table with populations larger than 120000. The CountryCode for America is USA.

select name 
from city
where countrycode='USA' and
population > 120000

-- Query all columns (attributes) for every row in the CITY table.

select * from city

-- Query all columns for a city in CITY with the ID 1661.

select * from city
where id=1661

-- Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.

select * from city
where COUNTRYCODE ='JPN';

-- Query a list of CITY and STATE from the STATION table.

select city, state
from station

-- Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.

select distinct city
from station
where mod(id, 2) = 0;

-- Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.
-- The STATION table is described as follows:

select count(city) - count(distinct city) 
from station

--Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.

select distinct city
from station
where lower(substr(city, 1, 1)) in ('a', 'e', 'i', 'o', 'u');

--Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.

select distinct city
from station
where substr(city, -1) in ('a', 'e', 'i', 'o', 'u');

-- Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.

select distinct city
from station
where substr(city, -1) in ('a', 'e', 'i', 'o', 'u') and
substr(city, 1, 1) in ('A', 'E', 'I', 'O', 'U');

-- Query the total population of all cities in CITY where District is California.

select sum(population)
from city
where district='California';

-- Given the CITY and COUNTRY tables, query the names of all cities where the CONTINENT is 'Africa'.
-- Note: CITY.CountryCode and COUNTRY.Code are matching key columns.

select c.name
from city c join country co on (c.countrycode = co.code)
where co.CONTINENT = 'Africa';

-- Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) and their respective average city populations (CITY.Population) rounded down to the nearest integer.
-- Note: CITY.CountryCode and COUNTRY.Code are matching key columns.

select country.CONTINENT, floor(avg(city.population))
from country join city on (city.countrycode = country.code)
group by country.CONTINENT;


-- url -> https://www.hackerrank.com/challenges/more-than-75-marks/problem?h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen

select name
from students
where marks > 75
order by substr(name, -3), id;