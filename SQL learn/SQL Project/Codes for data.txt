/*
 #1
We want to understand more about the movies that families are watching. The following categories are considered family movies: Animation, Children, Classics, Comedy, Family and Music.

Create a query that lists each movie, the film category it is classified in, and the number of times it has been rented out.ate a query that lists each movie, the film category it is classified in, and the number of times it has been rented out
*/

 
SELECT family_movie_category, SUM(times_rented) Times_rented
	FROM 
		(SELECT f.title Movie_title, c.name family_movie_category, COUNT(r.rental_id) times_rented
		 FROM category c
		 JOIN film_category fc
		 ON c.category_id = fc.category_id
		 JOIN film f
		 ON fc.film_id = f.film_id
		JOIN inventory i
		 ON  f.film_id = i.film_id
		JOIN rental r
		 ON i.inventory_id = r.inventory_id
		 WHERE c.name IN ('Animation','Children','Classics','Comedy','Family','Music')
		 GROUP BY 1,2
		 ORDER BY 2,1) t1	
GROUP BY 1
ORDER BY 1;
 
 
	
	
/*#2
Now we need to know how the length of rental duration of these family-friendly movies compares to the duration that all movies 
are rented for. Can you provide a table with the movie titles and divide them into 4 levels
 (first_quarter, second_quarter, third_quarter, and final_quarter) based on the quartiles (25%, 50%, 75%) 
 of the rental duration for movies across all categories? Make sure to also indicate the category that these family-friendly movies fall into.
 
 Finally, provide a table with the family-friendly film category, each of the quartiles, and the corresponding count of movies within each combination of film category for each corresponding rental duration category. The resulting table should have three columns:
Category
Rental length category
Count
 
*/

SELECT Category, Quartile, COUNT(Movie_title)
FROM
	(SELECT f.title Movie_title, c.name Category, f.rental_duration Duration, NTILE(4) OVER (ORDER BY f.rental_duration) Quartile
	FROM category c
	 JOIN film_category fc
	 ON c.category_id = fc.category_id
	 JOIN film f
	 ON fc.film_id = f.film_id
	 GROUP BY 1,2,3
	 ORDER BY 4,3) t1
WHERE Category IN ('Animation','Children','Classics','Comedy','Family','Music')
GROUP BY 1,2 
 
#3

/*We want to find out how the two stores compare in their count of rental 
orders during every month for all the years we have data for. Write a query that returns the store ID for the store, 
the year and month and the number of rental orders each store has fulfilled for that month.
 Your table should include a column for each of the following: 
year, month, store ID and count of rental orders fulfilled during that month.*/

SELECT YEAR_MONTH, store_ID, COUNT(*) Rental_count
FROM
	(SELECT  DATE_PART('year', r.rental_date) ||'-'|| DATE_PART('month', r.rental_date) AS YEAR_MONTH , s.store_id
	FROM rental r
	JOIN staff s
	ON r.staff_id = s.staff_id 
	) t1 
GROUP BY 1,2
ORDER BY 1,2


/*#4
We would like to know who were our top 10 paying customers, how many payments they made on a monthly basis during 2007,
 and what was the amount of the monthly payments. Can you write a query to capture the customer name, month and year of payment, 
 and total payment amount for each month by these top 10 paying customers?

*/


SELECT DATE_PART('year', p.payment_date) ||'-'|| DATE_PART('month', p.payment_date) AS YEAR_MONTH , 
CONCAT(c.first_name, ' ', c.last_name) full_name, COUNT(p.amount) count_per_month, SUM(p.amount)  paid_per_month
FROM customer c 
JOIN payment p 
ON c.customer_id = p.customer_id
WHERE CONCAT(c.first_name, ' ', c.last_name) IN
	(SELECT full_name FROM
	(SELECT CONCAT(c.first_name, ' ', c.last_name) full_name, SUM(p.amount) amt_paid
	FROM customer c
	JOIN payment p
	ON c.customer_id = p.customer_id
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 10) t1)
GROUP BY 2,1
ORDER BY 2,1



