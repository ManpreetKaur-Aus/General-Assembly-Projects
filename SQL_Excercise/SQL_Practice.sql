--Write a query that returns
--furniture products that were not sold in 2020


--2228 total number of Furniture products/master listing 
--    select 2228 - 1859 = 369 furniture products were sold in 2020
--1859 Furniture products did not sell in 2020
SELECT product_id
FROM products
WHERE category = 'Furniture'

	EXCEPT
--18777 duplicates products that were sold in 2020
--1738 Unique products that were sold in 2020
SELECT DISTINCT product_id
FROM orders
WHERE DATE_PART('year', order_date) = '2020';


---------------------------------------------------------NULLIF, COALESCE, CASE-------------------
-- NULLIF
SELECT
product_id,
quantity/NULLIF(discount,0) AS discount_per_item, discount
FROM orders
WHERE ship_mode = 'Standard Class'
LIMIT 100;

-- CASE
SELECT
	product_id,
		CASE WHEN discount = 0 THEN NULL
			 ELSE discount
		END AS disc, discount
FROM orders
WHERE ship_mode = 'Standard Class'
LIMIT 100;

--COALESCE
SELECT 	order_id, 
		product_id, 
		sales, 
		postal_code, 
		region_id,
		COALESCE(postal_code, region_id::TEXT) AS coalesced
FROM orders
LIMIT 100;