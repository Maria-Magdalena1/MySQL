create table countries 
(
id int primary key auto_increment,
name varchar(30) not null unique,
description text,
currency varchar(5) not null
);

create table airplanes 
(
id int primary key auto_increment,
model varchar(50) not null unique,
passengers_capacity int not null,
tank_capacity decimal(19,2) not null,
cost decimal(19,2) not null
);

create table passengers
(
id int primary key auto_increment,
first_name varchar(30) not null,
last_name varchar(30) not null,
country_id int not null,
constraint fk_countries_passengers foreign key(country_id) references countries(id) 
);

create table flights
(
id int primary key auto_increment,
flight_code varchar(30) not null unique,
departure_country int not null,
destination_country int not null,
airplane_id int not null,
has_delay bool ,
departure datetime,
constraint fk_countries_flight_departure foreign key(departure_country) references countries(id),
constraint fk_countries_flight_destination foreign key(destination_country) references countries(id),
constraint fk_airplanes_flight foreign key(airplane_id) references airplanes(id)
);

create table flights_passengers
(
flight_id int ,
passenger_id int,
constraint fk_flights foreign key(flight_id) references flights(id),
constraint fk_passengers foreign key(passenger_id) references passengers(id)
);

insert into airplanes (model,passengers_capacity,tank_capacity,cost)
select 
	concat (reverse(first_name),'797') as model,
    char_length(last_name)*17 as passengers_capacity,
    id*790 as tank_capacity,
    char_length(first_name)*50.6 as cost
from passengers
where id<=5;

update flights f
join countries c on f.departure_country=c.id
join airplanes a on f.airplane_id=a.id
set f.airplane_id=f.airplane_id+1
where c.name='Armenia';

delete f
from flights f
left join flights_passengers fp on f.id=fp.flight_id
left join passengers p on fp.passenger_id=p.id
where p.id is null;

select * from airplanes
order by cost desc,id desc;

select flight_code,departure_country,airplane_id,departure
from flights
where year(departure)=2022
order by airplane_id , flight_code
limit 20;

select concat(upper(left(p.last_name,2)),p.country_id) as flight_code,
concat(p.first_name,' ',p.last_name) as full_name,
p.country_id
from passengers p
left join flights_passengers fp on p.id=fp.passenger_id
where fp.flight_id is null
order by country_id;

select c.name,c.currency,count(fp.passenger_id) as booked_tickets
from countries c
join flights f 
on c.id=f.destination_country
group by c.id,c.name,c.currency
having booked_tickets >=20
order by booked_tickets desc;

select flight_code,departure,
case 
	when hour(departure) >=5 and hour(departure)<12 then 'Morning'
    when hour(departure)>=12 and hour(departure) <17 then 'Afternoon'
    when hour(departure)>=17 and hour(departure) <21 then 'Evening'
    else 'Night'
end as day_part
from flights
order by flight_code desc;

delimiter $$
create function udf_count_flights_from_country(country VARCHAR(50)) 
returns int
deterministic
begin
	return (select count(*)
    from countries c
    join flights f on c.id=f.departure_country
    where c.name=country);
end $$

delimiter $$
create procedure udp_delay_flight(in code varchar(50))
begin
	update flights
    set has_delay=1, departure=departure+interval 30 minute
    where code=flight_code;
end $$