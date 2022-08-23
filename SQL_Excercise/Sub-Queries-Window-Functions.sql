-----------------------------------ROW-----------------------------------------

SELECT
ROW(covid.location, covid.new_deaths_smoothed_per_million)
FROM covid;

select * from covid;

	------------------------------Equality Comparision------------------------------
SELECT ROW(1,2,3) = ROW(1,2,3);

SELECT ROW(1,2,Null) = ROW(1,2,Null);

SELECT ROW(1,2) = ROW(1,2,3);	

SELECT ROW(3,1,2) = ROW(1,2,3);
	-----------------------------------Greater Than Comparision------------------------
SELECT ROW(1,2,null,4) > ROW(1,2,3,3);
SELECT ROW(1,2,null,4) = ROW(1,2,3,3);
SELECT ROW(1,2,4,null) > ROW(1,2,3,3);
SELECT ROW(1,2,4,null) = ROW(1,2,3,3);


	-------------Countries Greater than UK----------
	
SELECT
	location,
	ROW(ROUND(new_cases_smoothed_per_million), reproduction_rate) = Row(351, 0.65) as a
FROM covid
ORDER BY a DESC;

select ROUND(new_cases_smoothed_per_million), reproduction_rate
FROM covid
WHERE location = 'United Kingdom'


----------------------------SUBQUERY------------------------

--TYPE-3 
--------
SELECT AVG(total_cases) 
FROM covid; --scalar

--TYPE-2 
--------
SELECT location 
FROM covid;--Vector

--TYPE-1 
--------
SELECT location, total_cases
FROM covid;--Matrix


--
SELECT location ---Main/Outer Query
FROM covid						--- subquery/inner query
WHERE reproduction_rate > (SELECT max(reproduction_rate) / 2 
							FROM covid);
							
							
SELECT 
	location, 
	ROW(ROUND(new_cases_smoothed_per_million), reproduction_rate)
			> 
	(
		SELECT 
			ROUND(new_cases_smoothed_per_million), 
			reproduction_rate 
	 	FROM covid
		WHERE location = 'Algeria'
	) 

FROM covid;

-- SELECT
-- 	location,
-- 	ROW(ROUND(new_cases_smoothed_per_million), reproduction_rate) 
	
-- 	> 
	
-- 	Row(351, 0.65)
-- FROM covid;


	---------------------EXISTS--------------

SELECT EXISTS (SELECT * FROM covid WHERE location = 'Azerbaijan')


	------------------IN-----------
SELECT ROW('Azerbaijan', 230296) IN (SELECT location, total_cases FROM covid);

	------------------NOT IN-----------
SELECT ROW('Azerbaijan', 10) NOT IN (SELECT location, total_cases FROM covid);

	---------ALL----------

SELECT 5 > ALL (SELECT reproduction_rate FROM covid order by reproduction_rate desc)
				--Explanation
				--AND (IS (5>NULL), IS (5>NULL),................IS (5>1.31))
				--AND (NULL, NULL,................TRUE........)
				--NULL

				-- SELECT 5> 6


SELECT 0.01 > ANY (SELECT reproduction_rate FROM covid WHERE
					reproduction_rate IS NOT NULL);
					
SELECT 1 < ANY (SELECT reproduction_rate FROM covid WHERE
					reproduction_rate IS NOT NULL);
					
	SELECT MAX(reproduction_rate), MIN(reproduction_rate)
	FROM covid

------------------GROUP EXERCISE----------------




select 4 > 5


SELECT
(SELECT max(reproduction_rate) FROM covid WHERE continent = 'Europe')
< ALL
(SELECT reproduction_rate FROM covid WHERE continent = 'Asia')
;




------------------------------NOTES--------------------------------------------

--Output of a query : Copy/paste
-- 					: Store the output into a temp table
-- 					: Store into a permanent table
-- 					: You can write the query as a VIEW which can be triggered/fired to give you the output whenever you need.
--					: Structure your queries to have subqueries such that the outer query consumes the output of subqueries.
--					: Create a CTE (Common Table Expression )


--------------------CTE-----------------------------
WITH usa_stats AS 	(
		SELECT
				ROUND(new_cases_smoothed_per_million),
				reproduction_rate
		FROM covid
		WHERE location = 'United States'
	)	
select * from usa_stats;

Select * from covid;
select * from usa_stats;

select reproduction_rate * 10 from (
			SELECT
				ROUND(new_cases_smoothed_per_million),
				reproduction_rate
		FROM covid
		WHERE location = 'United States') as a
		
		
-------------------------------------WINDOW FUNCTIONS:3.08-------------------------
-- category 1
-- 	product 1    100  3 
-- 	product 5    500  2
-- 	product 9    900 1
-- category 2
-- 	product 11    1100  3
-- 	product 15    1500   2
-- 	product 19    1900   1
-- category 3
-- 	product 21    2100   3
-- 	product 25    2500   2
-- 	product 29    2900   1


SELECT location,  
		avg(total_cases) OVER(), 
		reproduction_rate 
FROM covid


SELECT avg(total_cases) 
FROM covid;
--544276.378947368421

--544276.378947368421


SELECT location,
		100 * (total_cases / (avg(total_cases) OVER ()))
FROM covid;



SELECT location,
	continent, 
	avg(total_cases) OVER (PARTITION BY continent)
FROM covid



-- SELECT
-- 	continent, 
-- 	avg(total_cases)
-- FROM covid
-- GROUP BY continent;


-- select continent, avg(avg_by_continent) 
-- FROM
-- 	(
-- 		SELECT
-- 		continent, 
-- 		avg(total_cases) OVER (PARTITION BY continent) avg_by_continent
-- 	FROM covid
-- 	) a
-- GROUP BY continent;

-- SELECT location,
-- 	continent, 
-- 	avg(total_cases) OVER (PARTITION BY continent) avg_by_continent
-- FROM covid

SELECT 
	location, 
	continent, 
	total_cases, 
	avg(total_cases) OVER (PARTITION BY LEFT(location, 1)) total_cases_location_start_with_same_letter
FROM covid
ORDER BY location;

SELECT location, new_deaths,
avg(total_cases)
OVER (PARTITION BY
new_deaths)
FROM covid
ORDER BY location;


SELECT location, new_deaths,
continent, avg(total_cases)
OVER (PARTITION BY new_deaths, continent)
FROM covid
ORDER BY location;


SELECT location,
reproduction_rate,
avg(total_cases)
						OVER (PARTITION BY ROUND(reproduction_rate))
FROM covid
ORDER BY reproduction_rate;

select  location, reproduction_rate,ROUND(reproduction_rate), total_cases FROM covid order by ROUND(reproduction_rate )


------------------PARTITION BY....BETWEEN A RANGE---------------------------

SELECT time, avg(volume) OVER (ROWS BETWEEN 5 PRECEDING AND 0 FOLLOWING IF FOUND), volume
FROM ibm_stock
ORDER BY time;

SELECT time, volume FROM ibm_stock


select (150 + 161 + 291 + 841)/4 --360

select (192 + 161 + 291 + 841)/4 -- 371

