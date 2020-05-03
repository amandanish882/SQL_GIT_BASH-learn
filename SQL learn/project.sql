/*

Create a query that lists each movie, the film category it is classified in, and the number of times it has been rented out
*/

SELECT f.title film_title, c.name category_name, COUNT(r.rental_id) rental_count
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category c
ON c.category_id = fc.category_id
JOIN inventory i
ON i.film_id = f.film_id
JOIN rental r
ON r.inventory_id = i.inventory_id
WHERE c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
GROUP BY film_title, category_name
ORDER BY category_name, film_title;	

/* MINE */

SELECT f.title Movie_title, c.name family_movie_category, COUNT(r.rental_id) times_rented
 FROM category c
 JOIN film_category fc
 ON c.category_id = fc.category_id
 JOIN film f
 ON fc.film_id = f.film_id
JOIN inventory i
 ON  f.film_id = i.film_id
JOIN rental r
 ON i.inventory_id = r.rental_id
 WHERE c.name IN ('Animation','Children','Classics','Comedy','Family','Music')
 GROUP BY 1,2
 ORDER BY 2,1
 
 
 #1
 
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
 
 
	
	
#2

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

/*Year, month, storeID , count_rental*/

SELECT YEAR_MONTH, store_ID, COUNT(*) Rental_count
FROM
(SELECT  DATE_PART('year', r.rental_date) ||'-'|| DATE_PART('month', r.rental_date) AS YEAR_MONTH , s.store_id
FROM rental r
JOIN staff s
ON r.staff_id = s.staff_id 
) t1 
GROUP BY 1,2
ORDER BY 1,2


#4


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



