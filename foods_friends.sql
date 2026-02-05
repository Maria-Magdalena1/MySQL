create table restaurants 
(
id int primary key auto_increment,
name varchar(40) not null unique,
type varchar(20) not null,
non_stop bool not null
);

create table offerings 
(
id int primary key auto_increment,
name varchar(40) not null unique,
price decimal(19,2) not null,
vegan bool not null,
restaurant_id int not null,
constraint fk_offerings_restaurants foreign key(restaurant_id) references restaurants(id)
);

create table customers 
(
id int primary key auto_increment,
first_name varchar(40) not null,
last_name varchar(40) not null,
phone_number varchar(20) not null unique,
regular bool not null,
unique(first_name,last_name)
);

create table orders 
(
id int primary key auto_increment,
number varchar(10) not null unique,
priority varchar(10) not null,
customer_id int not null,
restaurant_id int not null,
constraint fk_customers_orders foreign key (customer_id) references customers(id),
constraint fk_restaurants_orders foreign key (restaurant_id) references restaurants(id)
);

create table orders_offerings
(
order_id int not null,
offering_id int not null,
restaurant_id int not null,
primary key (order_id,offering_id),
constraint fk_orders foreign key (order_id) references orders (id),
constraint fk_offers foreign key (offering_id) references offerings(id),
constraint fk_restaurants foreign key (restaurant_id) references restaurants(id)
);

insert into offerings(name,price,vegan,restaurant_id)
select concat(name,' ','costs:') as name,price,vegan,restaurant_id
from offerings
where name like 'Grill%';

update offerings
set name=upper(name)
where name like '%Pizza%';

delete from restaurants
where name like '%fast%' or type like '%fast%';

select o.name,o.price 
from offerings o
join restaurants r 
on o.restaurant_id=r.id
where r.name='Burger Haven'
order by o.id;

select c.id,c.first_name,c.last_name
from customers c
left join orders o 
on c.id=o.customer_id
where o.id is null
order by c.id;

select o.id,o.name
from offerings o
join orders_offerings `of` on o.id=`of`.offering_id
join orders ord on ord.id=`of`.order_id
join customers c on c.id=ord.customer_id
where c.first_name= 'Sofia' and c.last_name='Sanchez' and
o.vegan=0
order by o.id;

select distinct r.id, r.name
from restaurants r
join offerings offe on r.id=offe.restaurant_id
join orders o on r.id=o.restaurant_id
join customers c on c.id=o.customer_id
where c.regular=1 and offe.vegan=1 and o.priority='HIGH'
order by r.id;

select name as offering_name,
case 
	when price<=10 then 'cheap'
    when price >10 and price <=25 then 'affordable'
    else 'expensive'
end as price_category
from offerings
order by price desc,name;

delimiter $$
create function udf_get_offerings_average_price_per_restaurant(restaurant_name varchar(40))
returns decimal(10,2)
deterministic
begin
	return (select avg(o.price)
    from offerings o
    join restaurants r 
    on o.restaurant_id=r.id
    where r.name=restaurant_name);
end $$

delimiter $$
create procedure udp_update_prices(in restaurant_type varchar(40))
begin
	update offerings o
    join orders_offerings `of` on o.id=`of`.offering_id
    join orders ord on `of`.order_id=ord.id
    join restaurants r on r.id=`of`.restaurant_id
    set price=price+5
    where r.type=restaurant_type
    and r.non_stop=1;
end $$
