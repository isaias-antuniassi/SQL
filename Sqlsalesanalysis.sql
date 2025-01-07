	

	CREATE DATABASE Sales_analysis;
	
	USE Sales_analysis;

	CREATE TABLE products (
		product_id INTEGER,
		product_name VARCHAR(100),
		category VARCHAR(50),
		price INTEGER
	);

	INSERT INTO products 
			(product_id, product_name, category, price)
	VALUES
		(1,'Laptop','Eletronics',500),
		(2,'Office desk','Furniture',250),
		(3,'Smartphone','Eletronics',750),
		(4,'Gaming chair','Furniture',150);


	CREATE TABLE stores (
		store_id VARCHAR(3),
		store_name VARCHAR(100),
		store_city VARCHAR(100),
		store_manager VARCHAR(50)
	);
	
	INSERT INTO stores
			(store_id, store_name, store_city, store_manager)
	VALUES
		('S01','Solar Shelves','Dublin','Jhonny'),
		('S02','Elite Emporium','Galway','Bernard'),
		('S03','Infinity Retail','Cork','Joseph');

	 		
	CREATE TABLE sales (
		order_date DATE,
		store_id VARCHAR(3),
		product_id INTEGER
	);

	INSERT INTO sales
			(order_date, store_id, product_id)
	VALUES
		('2023-01-01', 'S03', 1),
		('2023-01-01', 'S03', 2),
		('2023-01-07', 'S02', 2),
		('2023-01-10', 'S01', 4),
		('2023-01-11', 'S02', 3),
		('2023-01-11', 'S02', 3),
		('2023-01-01', 'S01', 2),
		('2023-01-02', 'S01', 4),
		('2023-01-04', 'S03', 1),
		('2023-01-11', 'S02', 1),
		('2023-01-16', 'S03', 4),
		('2023-02-01', 'S03', 3),
		('2023-01-01', 'S02', 3),
		('2023-01-01', 'S01', 4),
		('2023-01-07', 'S01', 3);

		
	UPDATE products
	SET category = 'Electronics'
	WHERE category = 'Eletronics';


	INSERT INTO sales
			(order_date, store_id, product_id)
	VALUES	
		('2023-01-17', 'S02', 2),
		('2023-01-26', 'S03', 3),
		('2023-01-08', 'S02', 1);

	UPDATE products
	SET price = 200
	WHERE product_id = 4;

-- 1. Select all products available in the products table.

SELECT * 
FROM	
	products;

-- 2. List all store names and their respective cities.

SELECT 
	store_name,
	store_city
FROM
	stores;

-- 3. Show all sales made on the date 2023-01-01.

SELECT *
FROM
	sales
WHERE
	order_date = '2023-01-01';

-- 4. Find the name and price of products in the 'Electronics' category.

SELECT 
	product_name,
	price
FROM
	products
WHERE
	category = 'Electronics';

-- 5. Count the total number of stores available in the stores table.

SELECT 
	COUNT(*) AS total_stores
FROM
	stores;

-- 6. List all products sold in the store with ID 'S01'.

SELECT 
	p.product_name,
	p.category,
	p.price
FROM
	sales s
		JOIN products p
		ON s.product_id = p.product_id
WHERE
	s.store_id = 'S01';

-- 7. Find the product sales made in the city of Galway.

SELECT 
	s.order_date,
	p.product_name,
	p.category,
	p.price
FROM
	sales s
		JOIN stores st
		ON s.store_id = st.store_id
		JOIN products p
		ON s.product_id = p.product_id
WHERE
	st.store_city = 'Galway';

-- 8. Count how many times the product 'Gaming chair' was sold.

SELECT 
	COUNT(*) AS gaming_chair_sales
FROM
	sales s
		JOIN products p
		ON s.product_id = p.product_id
WHERE
	p.product_name = 'Gaming chair';

-- 9. List the dates when the product 'Smartphone' was sold.

SELECT 
	s.order_date
FROM
	sales s
		JOIN products p
		ON s.product_id = p.product_id
WHERE
	p.product_name = 'Smartphone';

-- 10. Calculate the total sales (number of records) made by each store.

SELECT 
	s.store_id,
	st.store_name,
	COUNT(*) AS total_sales
FROM
	sales s
		JOIN stores st
		ON s.store_id = st.store_id
GROUP BY 
	s.store_id, st.store_name;

-- 11. List the names of products, stores, and cities where each product was sold.

SELECT 
	p.product_name,
	st.store_name,
	st.store_city
FROM
	sales s
		JOIN stores st
		ON s.store_id = st.store_id
		JOIN products p 
		ON s.product_id = p.product_id;
		
-- 12. Calculate the total sales value (monetary) by product category.

SELECT
	p.category,
	SUM(p.price) AS sales
FROM
	sales s
		JOIN products p
		ON s.product_id = p.product_id
GROUP BY
	p.category;

-- 13. Find the store with the highest number of sales and show the manager's name.

SELECT TOP(1)
	st.store_name,
	st.store_manager,
	COUNT(*) AS total_sales
FROM sales s
		JOIN stores st
		ON s.store_id = st.store_id
GROUP BY 
	st.store_name, st.store_manager
ORDER BY 
	total_sales DESC;

-- 14. Identify product sales that occurred in multiple stores on the same day.

SELECT 
	s.order_date,
	s.product_id,
	p.product_name,
	COUNT(DISTINCT s.store_id) AS store_count
FROM
	sales s
		JOIN products p
		ON s.product_id = p.product_id
GROUP BY 
	s.order_date, s.product_id, p.product_name
	HAVING COUNT(DISTINCT s.store_id) > 1;


-- 15. Show the total sales value made by each store, ordered by the highest total first.

SELECT 
	st.store_name,
	SUM(p.price) AS total_sales_value
FROM
	sales s
		JOIN stores st
		ON s.store_id = st.store_id
		JOIN products p
		ON s.product_id = p.product_id
GROUP BY
	st.store_name
ORDER BY total_sales_value DESC;
