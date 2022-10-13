--1. List all customers who live in Texas (use JOINs)
--Answer: Kim Cruz, Jennifer Davis, Bryan Hardison, Ian Still, Richard Mccrary
SELECT first_name, last_name
FROM customer
INNER JOIN address 
ON customer.address_id = address.address_id
WHERE district = 'Texas';
--2. Get all payments above $6.99 with the Customer's Full Name
-- Answer: There is way too many to list 
SELECT first_name, last_name, amount
FROM customer
INNER JOIN payment 
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99; 
--3. Show all customers names who have made payments over $175(use subqueries)
-- Answer: Harold Martino, Jennifer Davis, Mildred Bailey
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    WHERE amount > 175
);
--4. List all customers that live in Nepal (use the city table)
--Answer: Kevin Schuler
-- first part to help find what Nepal's country id would be 
SELECT *
FROM country
WHERE country = 'Nepal';
--plugging in country id to help find individuals living in Nepal
SELECT first_name, last_name
FROM customer
WHERE address_id in (
    SELECT address_id
    FROM address
    INNER JOIN city
    ON city.city_id = address.city_id
    WHERE country_id = 66
);
--5. Which staff member had the most transactions?
-- Jon Stephens 
SELECT first_name, last_name
FROM staff
WHERE staff_id IN (
    SELECT staff_id
    FROM payment
    GROUP BY staff_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);
--6. How many movies of each rating are there?
-- Answer: a lot. (PG-13: 223, NC-17: 209, R: 195, PG: 194, G: 179)
SELECT rating, COUNT(*)
FROM film 
GROUP BY rating
ORDER BY COUNT(*) DESC;
--7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    WHERE amount > 6.99
    ORDER BY customer_id
);
--8. How many free rentals did our stores give away?
--Answer: None 
SELECT *
FROM payment 
WHERE amount = 0;
