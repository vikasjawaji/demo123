use gradedassignment;
create table passenger( Passenger_name varchar(20), Category varchar(20), gender varchar(10), boarding_city varchar(20),
destination_city varchar(20), distance int,  bus_type varchar(20), foreign key(bus_type) references price(bus_type));
insert into passenger (passenger_name, category, gender, boarding_city, destination_city, distance, Bus_type) values
("Sejal","AC","F","Bengaluru","Chennai", 350,"Sleeper"),
("Anmol", "Non-AC", "M","Mumbai", "Hyderabad",700,"Sitting"),
("Pallavi","AC","F","Panaji","Bengaluru",600,"Sleeper"),
("Khusboo","AC","F","Chennai","Mumbai",1500,"Sleeper"),
("Udit","Non-AC","M","Trivandrum","Panaji",1000,"Sleeper"),
("Ankur","AC","M","Nagpur","Hyderabad",500,"Sitting"),
("Hemanth","Non-AC","M","Panaji","Mumbai",700,"Sleeper"),
("Manish","Non-AC","M","Hyderabad","Bengaluru",500,"Sitting"),
("Piyush","Ac","M","Pune","Nagpur",700,"Sitting");
desc passenger;
select * from passenger where category="Non-AC";
create table price(Bus_type varchar(20), distance int ,  price int, primary key(bus_type,distance));
insert into price (Bus_type, distance, price) values ("Sleeper",1500,3000),
("Sleeper",350 ,770),("Sleeper",500,1100),
("Sleeper",600,1320),("Sleeper",700,1540),("Sleeper",1000,2200),("Sleeper",1200,2640),
("Sitting", 350,434),("Sitting",500,620),("Sitting",600,744),("Sitting",700,868),("Sitting",1000,1240),("Sitting",1200,1488),("Sitting",1500,1860);
desc price;
select * from price;

 -- How many females and how many male passengers travelled for a minimum distance of 600 KM s?
 select gender,count(gender) from passenger where distance >= 600 group by gender ;

-- Find the minimum ticket price for Sleeper Bus.  
select min(price) from price where bus_type ="Sleeper";

-- Select passenger names whose names start with character 'S' 
select  passenger_name from passenger where Passenger_name like "S%";

 --   Calculate price charged for each passenger displaying Passenger name, Boarding City, Destination City, Bus_Type, Price in the output
select  a.passenger_name,a.category,a.gender,a.boarding_city,a.destination_city,b.distance,b.bus_type,b.price 
	from passenger as a, price as b	
			where  a.distance=b.distance and a.bus_type=b.bus_type; 
-- What is the passenger name and his/her ticket price who travelled in Sitting bus  for a distance of 1000 KM s 
select a.passenger_name, b.price from passenger as a join price as b on a.distance=b.distance and a.bus_type=b.bus_type where a.bus_type="Sitting" and a.distance=1000;
-- It gives no value as there are no passengers travelling the distance of 1000KM in sitting, below query is an another instance for the question
select a.passenger_name, b.price from passenger as a join price as b on a.distance=b.distance and a.bus_type=b.bus_type where a.bus_type="Sitting" and a.distance=700 ;

-- What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?

create view passenger_view as 
select Passenger_name, boarding_city, destination_city from passenger;
create view bustypes_view as 
select bus_type, distance, price from price;
select a.* , b.* from passenger_view a, bustypes_view as b where passenger_name='pallavi' and distance=(select distance from passenger where boarding_city="Panaji" and destination_city="Bengaluru");


-- List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order.
select distinct distance from passenger order by distance desc;

-- Display the passenger name and percentage of distance travelled by that passenger from the total distance travelled by all passengers without using user variables 
select  passenger_name,distance as distance_travelled, (select sum(distance) from passenger) as total_distance, distance*100/(select sum(distance) from passenger) percentage_from_total_distance
from passenger order by percentage_from_total_distance desc;

