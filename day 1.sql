-- coment

show databases ;

-- to create a database 

create database tata;

-- to use database / to utilize the database for which data will be stored  
use tata;

-- to see table
show tables ;

-- to create table 

create table nexon( price int , color char(20));

use world ;

show tables ;

-- to see the columns of the table 
describe country ;

select * from country ;

 -- to see specific column from the table
 select Name, Region , population from country ;

select population , name , region from country ;
 
select 
population-500
 from country ; 

-- to filter we use where clause 
-- where ::
-- filter only those data which is present in the table 

select * from country where continent ='Asia';

select * from country where indepyear = 1984; 

select name , continent from country where indepyear = 1991 ;

select * from country where continent = 'africa' ;
 