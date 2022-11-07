/*
 Lab| SQL Queries - Lesson 2.5
*/
USE sakila;
/*
Select all the actors with the first name ‘Scarlett’.
*/
select * from actor
where first_name = "scarlett";

/*
How many films (movies) are available for rent and how many films have been rented?
*/
-- assuming inventory_id and customer_id are unique
select inventory_id,customer_id from rental
order by inventory_id,customer_id; 
-- the records in inventory coloumns are not unique
-- so apply a unique function to inventory_id
select count(inventory_id) - count(distinct inventory_id) from rental; -- available movies
/*
What are the shortest and longest movie duration? Name the values max_duration and min_duration.
*/
select max(length) as max_duration, min(length) as min_duration from film;

/*
What's the average movie duration expressed in format (hours, minutes)?
*/

select  round (avg(length),2)  as "AVG movie duration" 
from sakila.film;

-- SELECT DATE_FORMAT(avg(length), '%H:%i') as "AVG movie duration"
SELECT time_format(round (avg(length),2), '%H:%i') as "AVG movie duration"
from sakila.film
limit 3;


/*
How many distinct (different) actors' last names are there?
*/
select distinct(last_name) from sakila.actor;

/*
Since how many days has the company been operating (check DATEDIFF() function)?
*/
-- my approach: find out the first and the latest customer and their purchasing records
select DATEDIFF('2006/02/14', '2006/02/14') as "operating years" from sakila.customer;
SELECT abs(DATEDIFF(min(rental_date), max(rental_date))) FROM rental;
    
-- Show rental info with additional columns month and weekday. Get 20 results.
SELECT *, month(rental_date), weekday(rental_date) as weekday FROM rental;    


-- month and weekday  coloumn
SELECT *, substr(last_update,6,2) AS "months",substr(last_update,9,2) AS "months"  FROM sakila.film
limit 20;

/*
Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
*/
SELECT last_update,
CASE
WHEN DAYOFWEEK(substr(last_update,1,10))  between 1 AND 7  then 'weekday'
ELSE 'Weekend'
END AS 'day_type'
FROM sakila.film
limit 50;

/*
Get release years.
*/
select distinct release_year from sakila.film;

/*
Get all films with ARMAGEDDON in the title.
*/
-- the following did not work :(
select film_id as "title_id", title from sakila.film
WHERE title IN ('ARMAGEDDON');
-- this worked ;)
select film_id as "title_id", title from sakila.film
WHERE title LIKE 'ARMA%';

/*
Get all films which title ends with APOLLO.
*/
select film_id as "title_id", title from sakila.film
WHERE title LIKE '%OLLO';
/*
Get 10 the longest films.
*/
--  I tried the following but I got NULL returns, so i had to do something like in STEP 2 below :(
select length from sakila.film
HAVING length BETWEEN (MAX(length)) AND (MIN(length))
ORDER BY length
limit 10;

-- STEP 2
select max(length) as "longest_movie", min(length) as "shortest_movie"  from sakila.film; -- 185 and 46
-- step 3
select film_id, length from sakila.film
where length BETWEEN 185 AND 46
-- HAVING length BETWEEN 185 AND 46
ORDER BY film_id desc;

/*
How many films include Behind the Scenes content?
*/
select film_id,special_features as "with Behind the scenes", title from sakila.film
WHERE special_features LIKE '%Behind%'
order by film_id ;
