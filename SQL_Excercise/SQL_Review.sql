Two types of SQL commands
	1. DDL (Data Definition Language)
		CREATE
		ALTER 
		DROP
	2. DML (Data Manipulation Language)
		INSERT
		UPDATE
		DELETE
		
		SELECT

--String
select * from products
where category = 'Furniture' AND (product_cost_to_consumer = 53.04 AND 
								  product_cost_to_consumer = 53.04 OR 
								  product_cost_to_consumer = 54)

--Numeric
select * from products
where product_cost_to_consumer = 53.04

--Date

select * from orders 
where order_date  = '2016-09-28' -- dates need to be within single quotes

select cast ('2016-09-28' as date) -- type-casted to date datatype

select  ('2016-09-28') --date but for sql the data type is text/string

select  cast(100.0/11 as float )


select strpos('abcd', 'ca')

SELECT SUBSTRING( 'abc, def', 1,3);

select STRPOS( 'abc, def', ',' )-1

--       name                     first_name           last_name
-- 	  ----                     
-- 'Srikanta, Patra'                srikanta               patra
-- 'Bill, Gates'


SELECT product_name, 
	SUBSTRING( product_name, 1,
	STRPOS( product_name, ',' ) -1 ) as first_name,
	
	SUBSTRING( product_name, 
	STRPOS( product_name, ',' ) +2, length(product_name)-strpos(product_name, ',')+ 2) as last_name
	
	FROM products LIMIT 10;
	
	
	
-- -----------------
-- --if sales >100 then 1 else 0...........having

-- select sales,
-- 	case 
-- 		when sales > 100 then 1
-- 		else 0
-- 	end as sales_category
-- from orders
-- limit 100

-- having with group by
select region_id, sum(sales) as total_sales
from orders
group by region_id
having sum(sales) > 139456.16
limit 10


select profit, NULLIF(profit, 0) from orders limit 1000

select coalesce(NULL, NULL, 'hello', 'world')



----------------------------SUBQUERY------------------------

--TYPE-3 --usually used for comparison
--------
SELECT AVG(total_cases) 
FROM covid; --scalar

--TYPE-2 -- usually, with an in operator
--------
SELECT location 
FROM covid;--Vector

--TYPE-1 -- usually used with exists or FROM 
--------
SELECT location, total_cases
FROM covid;--Matrix

--Practice Question
 --top 5 products by sales under each category in superstore dataset.


