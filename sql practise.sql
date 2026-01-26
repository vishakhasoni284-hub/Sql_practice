-- -------------------------
-- Create table: events
-- -------------------------

use sakila;
show databases;
use regex;
CREATE TABLE events (
  event_id   INT PRIMARY KEY,
  event_name VARCHAR(100) NOT NULL,
  city       VARCHAR(50)  NOT NULL
);

-- -------------------------
-- Create table: ticket_sales
-- -------------------------
CREATE TABLE ticket_sales (
  sale_id          INT PRIMARY KEY,
  event_id         INT NOT NULL,
  sale_date        DATE NOT NULL,
  ticket_type      VARCHAR(20) NOT NULL,
  qty              INT NOT NULL,
  price_per_ticket INT NOT NULL,
  CONSTRAINT fk_ticket_sales_event
    FOREIGN KEY (event_id) REFERENCES events(event_id)
);

-- -------------------------
-- Insert data: events
-- -------------------------
INSERT INTO events (event_id, event_name, city) VALUES
(1, 'Music Fest', 'Mumbai'),
(2, 'Tech Summit', 'Bengaluru'),
(3, 'Food Carnival', 'Delhi'),
(4, 'Startup Meetup', 'Mumbai');

-- -------------------------
-- Insert data: ticket_sales
-- -------------------------
INSERT INTO ticket_sales (sale_id, event_id, sale_date, ticket_type, qty, price_per_ticket) VALUES
(101, 1, '2025-01-05', 'Regular', 2, 1500),
(102, 1, '2025-01-10', 'VIP',     1, 5000),
(103, 2, '2025-02-03', 'Regular', 3, 2000),
(104, 2, '2025-02-10', 'VIP',     1, 6000),
(105, 3, '2025-03-01', 'Regular', 5,  800),
(106, 3, '2025-03-15', 'VIP',     2, 2500),
(107, 4, '2025-01-20', 'Regular', 4, 1200),
(108, 4, '2025-02-05', 'Regular', 1, 1200);

-- Quick check
SELECT * FROM events ORDER BY event_id;
SELECT * FROM ticket_sales ORDER BY sale_id;
select*from events;


-- Q1 find the total quantity sold per event_id
select event_id,count(qty) from ticket_sales group by event_id;

-- Q2 total revenue per event_id
select event_id , sum(qty*price_per_ticket) from ticket_sales group by event_id;

-- Q3 monthly total revenue 
select month(sale_date) , sum(qty*price_per_ticket) from ticket_sales group by month(sale_date);

-- Q4 Find the maximum price_per_ticket per event_id. 
select event_id ,max(qty*price_per_ticket) from ticket_sales group by event_id;

-- Q5Find total revenue per month and ticket_type. 
select month(sale_date),ticket_type ,sum(qty*price_per_ticket) from ticket_sales group by month(sale_date) ,ticket_type;

-- Q6 List all sales with event_name and sale_date
select t.sale_id , e.event_name ,t.sale_date from events as e join ticket_sales as t where e.event_id=t.event_id;

-- Q7 Show event_name, ticket_type, qty for each sale. 
select e.event_name , t.ticket_type , t.qty from events as e  join ticket_sales as t where  e.event_id=t.event_id ;

-- Q8 Show sales where the event city is Mumbai. 
select t.sale_id ,e.event_name,t.sale_date, e.city from events as e join ticket_sales as t where e.event_id = t.event_id and city ='Mumbai';

-- Q9 Show all events and matching sales 

select e.event_name , t.sale_id, t.sale_date from events e join ticket_sales t where e.event_id = t.event_id ;

-- Q10 Show distinct event names that have at least one sale. 

select distinct(e.event_name) from events as e join ticket_sales as t where e.event_id = t.event_id and sale_id is not null;

-- Q11 Show each sale’s computed revenue with event name.
select t.sale_id , e.event_name , (t.qty*t.price_per_ticket) from events as e join ticket_sales as t where e.event_id = t.event_id;

-- Q12 Find total quantity per event_name
select e.event_name , sum(t.qty)  from events as e join ticket_sales as t where e.event_id = t.event_id group by e.event_name;

-- Q13 Find total VIP revenue per event_name. 
select e.event_name , sum(t.qty*t.price_per_ticket) as vip_revenue from events as e join ticket_sales as t
 where  e.event_id = t.event_id  and ticket_type = 'VIP' group by e.event_name order by e.event_name;
 
 -- Q14 Find monthly revenue per city.
 
 select*from events;
select * from ticket_sales;

select e.city ,month(t.sale_date) ,sum(t.qty*t.price_per_ticket) as total_revenue from events as e join ticket_sales as t 
where  e.event_id = t.event_id  group by e.city , month(t.sale_date) order by e.city;

-- Q 15
-- Find total quantity per city and ticket_type.
select e.city , t.ticket_type ,sum(t.qty) as total_quantity from events as e join ticket_sales as t 
where e.event_id = t.event_id group by e.city ,t.ticket_type order by e.city;

-- Q16
-- Find sales that happened on the latest sale_date in the table. 
select * from ticket_sales where sale_date =( select max(sale_date) from ticket_sales);

-- Q17 
-- Find sales where revenue is greater than the overall average sale revenue. 
select sale_id , event_id , (qty*price_per_ticket)from ticket_sales 
where (qty*price_per_ticket) > ( select avg(qty*price_per_ticket) from ticket_sales);

-- Q18 Find events that have at least one VIP sale. 
select e.event_id , e.event_name from events as e join ticket_sales as t where e.event_id = t.event_id and ticket_type ='VIP' ;

-- Q19
-- Find events in cities that have at least one VIP sale.
select * from events;
select * from ticket_sales;

select e.event_name , e.city from events as e where e.city in (select e.city from events as e join ticket_sales as t on  e.event_id = t.event_id 
where  t.ticket_type ='VIP');

-- Q20 Find events that have at least one sale in February 2025. 
select distinct(e.event_id) , e.event_name , e.city from events as e join ticket_sales as t on e.event_id = t.event_id  where month(sale_date) =02;

-- Q21 For each event, return the highest price_per_ticket sale row. 
select * from ticket_sales where price_per_ticket in (select max(price_per_ticket) from ticket_sales group by event_id);

-- Q22 Show monthly total revenue and monthly total quantity, but only include months where total revenue is at least 10,000.
select month(sale_date)  as month_ofsale , sum(qty) as total_qty, sum(qty*price_per_ticket) as total_revenue from ticket_sales
 group by month(sale_date) having sum(qty*price_per_ticket) > 10000;
 
-- Q23 Show month-wise count of sales rows, but only include months that have at least 3sales rows. 
select month(sale_date) as sale_month , count(sale_id) as sales_rows from ticket_sales group by month(sale_date) having count(sale_id)>=3;

-- Q24 Show average revenue per sale row per month, but only include months where average sale revenue is above 4000. 
select month(sale_date) as sale_month , avg(qty*price_per_ticket) as sales_rows from ticket_sales group by month(sale_date) having avg(qty*price_per_ticket)>4000;

-- Q25 Show revenue per month and ticket_type, but only include groups where total revenue is at least 5000. 
select month(sale_date),sum(qty*price_per_ticket) as total_revenue , ticket_type from ticket_sales
 group  by month(sale_date), ticket_type having sum(qty*price_per_ticket)>=5000;
 
 








 






