/* LIMIT usage*/

SELECT occurred_at,account_id,channel
FROM web_events
LIMIT 15

/* Write a query to return the 10 earliest orders in the orders table. Include the id, occurred_at, and total_amt_usd.


Write a query to return the top 5 orders in terms of largest total_amt_usd. Include the id, account_id, and total_amt_usd.


Write a query to return the lowest 20 orders in terms of smallest total_amt_usd. Include the id, account_id, and total_amt_usd.

*/

SELECT id, occurred_at,total_amt_usd
FROM orders
ORDER BY occurred_at
LIMIT 10;

SELECT id, account_id,total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5;

SELECT id, account_id,total_amt_usd
FROM orders
ORDER BY total_amt_usd 
LIMIT 20;

/*
Write a query that displays the order ID, account ID, and total dollar amount for all the orders, sorted first by the account ID (in ascending order), and then by the total dollar amount (in descending order).

Now write a query that again displays order ID, account ID, and total dollar amount for each order, but this time sorted first by total dollar amount (in descending order), and then by account ID (in ascending order).

Compare the results of these two queries above. How are the results different when you switch the column you sort on first?

*/


SELECT id,account_id,total_amt_usd
FROM orders
ORDER BY account_id,total_amt_usd DESC;


SELECT id,account_id,total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC,account_id;

/*
Pulls the first 5 rows and all columns from the orders table that have a dollar amount of gloss_amt_usd greater than or equal to 1000.

Pulls the first 10 rows and all columns from the orders table that have a total_amt_usd less than 500. */

SELECT *
FROM orders
WHERE gloss_amt_usd >=1000
LIMIT 5;

/*Filter the accounts table to include the company name, website, and the primary point of 
contact (primary_poc) just for the Exxon Mobil company in the accounts table.*/


SELECT name,website, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil';


/*Create a column that divides the standard_amt_usd by the standard_qty to find the unit price for standard paper for each order. Limit the results to the first 10 orders, and include the id and account_id fields.

Write a query that finds the percentage of revenue that comes from poster paper for each order. You will need to use only the columns that end with _usd. (Try to do this without using the total column.) Display the id and account_id fields also.
*/

SELECT id,account_id,standard_amt_usd/standard_qty
FROM orders
LIMIT 10;


SELECT id, account_id, 
   poster_amt_usd/(standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS post_per
FROM orders
LIMIT 10;

/*All the companies whose names start with 'C'.

All companies whose names contain the string 'one' somewhere in the name.

All companies whose names end with 's'.*/

SELECT name
FROM accounts
WHERE name LIKE 'C%'

SELECT name
FROM accounts
WHERE name LIKE '%one%'

SELECT name
FROM accounts
WHERE name LIKE '%s';


/*
Questions using IN operator
Use the accounts table to find the account name, primary_poc, and sales_rep_id for Walmart, Target, and Nordstrom.


Use the web_events table to find all information regarding individuals who were contacted via the channel of organic or adwords.

*/


SELECT name,primary_poc,sales_rep_id
FROM accounts
WHERE name IN ('Walmart','Target','Nordstrom');

SELECT *
FROM web_events
WHERE channel IN ('organic','adwords');



/* NOT IN */

SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom');


SELECT *
FROM accounts
WHERE name NOT LIKE '%one%'


/*  AND and BetweeN */

SELECT *
FROM orders
WHERE standard_qty >= 1000 AND poster_qty = 0 AND gloss_qty = 0

SELECT *
FROM accounts
WHERE name NOT LIKE 'C%s' AND name LIKE '%s';


SELECT occurred_at,gloss_qty
FROM orders
WHERE gloss_qty BETWEEN 24 AND 29;


/* Use the web_events table to find all information regarding individuals who were contacted
 via the organic or adwords channels, and started their account at any point in 2016, sorted from newest to oldest.*/



SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
ORDER BY occurred_at DESC;



/* OR */

SELECT id
FROM orders
WHERE standard_qty = 0
	OR gloss_qty >1000
    OR poster_qty >1000
	
	
/* Find all the company names that start with a 'C' or 'W', and the primary contact contains 'ana' or 'Ana', but it doesn't contain 'eana'.
*/

SELECT *
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%') 
           AND ((primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%') 
           AND primary_poc NOT LIKE '%eana%');
		   


SELECT	SELECT Col1, Col2, ...	Provide the columns you want
FROM	FROM Table	Provide the table where the columns exist
LIMIT	LIMIT 10	Limits based number of rows returned
ORDER BY	ORDER BY Col	Orders table based on the column. Used with DESC.
WHERE	WHERE Col > 5	A conditional statement to filter your results
LIKE	WHERE Col LIKE '%me%'	Only pulls rows where column has 'me' within the text
IN	WHERE Col IN ('Y', 'N')	A filter for only rows with column of 'Y' or 'N'
NOT	WHERE Col NOT IN ('Y', 'N')	NOT is frequently used with LIKE and IN
AND	WHERE Col1 > 5 AND Col2 < 3	Filter rows where two or more conditions must be true
OR	WHERE Col1 > 5 OR Col2 < 3	Filter rows where at least one condition must be true
BETWEEN	WHERE Col BETWEEN 3 AND 5



/* JOIN */

SELECT orders.*
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;


SELECT orders.standard_qty, orders.gloss_qty, orders.poster_qty, accounts.website, accounts.primary_poc
FROM accounts
JOIN orders
ON orders.account_id = accounts.id
LIMIT 10;



/* Provide a table for all web_events associated with account name of Walmart. There should be three columns. Be sure to include the primary_poc, time of the event, and the channel for each event. Additionally, you might choose to add a fourth column to assure only Walmart events were chosen.

Provide a table that provides the region for each sales_rep along with their associated accounts. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.

Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. Your final table should have 3 columns: region name, account name, and unit price. A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero.
*/


SELECT a.primary_poc,w.occurred_at,w.channel,a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
WHERE a.name = 'Walmart';



SELECT r.name region ,s.name sales ,a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON s.id = a.sales_rep_id
ORDER BY a.name;


SELECT r.name region_name,a.name account_name, (o.total_amt_usd/(o.total+0.01)) unit_price
FROM accounts a
JOIN orders o 
ON a.id = o.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON s.region_id = r.id;




/* INNER OUTER LEFT JOINS */

SELECT r.name rname, s.name sname, a.name aname 
FROM sales_reps s
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
WHERE r.name = 'Midwest'
ORDER BY aname;

/* Provide a table that provides the region for each sales_rep along with their 
associated accounts. This time only for accounts where the sales rep has a last name starting 
with K and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.
*/


SELECT r.name rname, s.name sname, a.name aname 
FROM sales_reps s
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
WHERE r.name = 'Midwest' AND s.name LIKE '% K%'
ORDER BY aname;


/*//................*/

SELECT actorid, full_name, 
       COUNT(filmtitle) film_count_peractor
FROM
    (SELECT a.actor_id actorid,
            a.first_name, 
            a.last_name,
            a.first_name || ' ' || a.last_name AS full_name,
            f.title filmtitle
    FROM    film_actor fa
    JOIN    actor a
    ON      fa.actor_id = a.actor_id
    JOIN    film f
    ON      f.film_id = fa.film_id) t1
GROUP BY 1, 2
ORDER BY 3 DESC
