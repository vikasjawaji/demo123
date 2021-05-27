use orderdatabase;
create table salesperson(s_id int primary key, s_name varchar(20),s_city varchar (20), s_earning float);

select * from salesperson;
create table customer(c_id int primary key, cust_name varchar(20), city varchar(20), grade int , s_id int, foreign key (s_id) references salesperson(s_id));
select * from customer;
select * from customer where c_id=11;
delete from customer where cust_name ='Sonia';
update customer set city ='Chennai' where c_id=11;
create table orders(ord_no int primary key, purchase_amt int , ord_date varchar(20), c_id int, s_id int,  foreign key (c_id) references customer(c_id), foreign key(s_id) references salesperson(s_id));
select * from orders;
-- ++++++++++++++ Display all the data++++++++++++++++++++++
select  s.s_id,  s.s_name, s.s_earning, c.c_id, c.cust_name, c.city,c.grade, o.ord_no, o.purchase_amt, o.ord_date from salesperson as s  JOIN customer AS c  
ON s.s_id=c.s_id   join orders as o on c.c_id=o.c_id ;
-- +++++++++++++++++Count the customers with grades above Delhi’s  average. +++++++++++++++++++
 select count(c_id) from customer where grade >(select avg(grade) from customer where city ='Delhi' group by city );
select city,avg(grade) from customer where city ='Delhi' group by city;
-- 
-- saleperson number and name having more than one customer 
select s.s_id,s.s_name from salesperson as s where 1<(select count(*) from customer where s_id=s.s_id);

-- 
select s.s_id, s.s_name, c.cust_name from salesperson as s, customer as c where s_city = city union (select s_id, s_name, 'No customer' from salesperson where not s_city = ANY (SELECT city FROM customer)) order by s_id;

create view high_orders
as select o.ord_date, s.s_id, s.s_name
from salesperson as s, orders as o
WHERE s.s_id = o.s_id
AND o.purchase_amt =
    (SELECT MAX(purchase_amt)
       FROM orders c
       WHERE c.ord_date = o.ord_date);
select * from high_orders order by ord_date;
create index demoIndex on orders (ord_no, purchase_amt);
show index from  orders;
-- SELECT * FROM orders  with (INDEX(demoIndex))
use sakila;
select first_name from actor  order by first_name limit  20 offset 10 ;