# Sales Analysis Database - SQL

### Project Overview
---

This project involves the design of a relational database to support sales analysis across multiple stores. The database captures essential details about products, stores, and sales transactions, enabling data-driven insights through SQL queries.

### Database Design

The database consists of three interrelated tables:
1. **Products**: Stores information about items available for sale, including their names, categories, and prices.
2. **Stores**: Contains data about the retail outlets, including their locations and managers.
3. **Sales**: Tracks individual sales transactions, associating products sold with the store and date of sale.


### Exploratory Data Analysis

EDA involved exploring the sales data to answer key questions, such as:

1. Select all products available in the products table.
2. List all store names and their respective cities.
3. Show all sales made on the date 2023-01-01.
4. Find the name and price of products in the 'Electronics' category.
5. Count the total number of stores available in the stores table.
6. List all products sold in the store with ID 'S01'.
7. Find the product sales made in the city of Galway.
8. Count how many times the product 'Gaming chair' was sold.
9. List the dates when the product 'Smartphone' was sold.
10. Calculate the total sales (number of records) made by each store.
11. List the names of products, stores, and cities where each product was sold.
12. Calculate the total sales value (monetary) by product category.
13. Find the store with the highest number of sales and show the manager's name.
14. Identify product sales that occurred in multiple stores on the same day.
15. Show the total sales value made by each store, ordered by the highest total first.

### Some interesting queries

**Q7 - Find the product sales made in the city of Galway.**

```sql
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
 ```

**Q14 - Identify product sales that occurred in multiple stores on the same day.**

```sql
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
```
