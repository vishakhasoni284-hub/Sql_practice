use sakila;
select * from actor ;
select * from film_actor; -- here film_id and actor_is combine to make primary key composite key 
select count(actor_id) , count(distinct(actor_id)) from actor;
select a.first_name, a.actor_id from actor as a 
join 
film_actor as fa 
where a.actor_id = fa.actor_id;
select * from film;

select fa.film_id , fa.actor_id , f.film_id , f.title from film_actor as fa
join film as f
where fa.film_id = f.film_id; -- many actors can work in one movie so many to one

-- how to join multiple table together 
-- table join table 2 , join table 3 where table 1=table 2 and table 2 = table 3

-- actor -- actor id , film_actor-- film id + actor _id , film -- > film id 
select a. actor_id , a.first_name , fa.film_id , f.film_id , f.title from actor as a 
join 
film_actor as fa 
join
film as f
where a.actor_id = fa.actor_id and f.film_id = fa.film_id ;








