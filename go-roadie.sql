create database go_roadie;

create table cities
(id int primary key auto_increment,
name varchar(40) not null unique
);

create table cars
(id int primary key auto_increment,
brand varchar(20) not null,
model varchar(20) not null unique
);

create table instructors
(id int primary key auto_increment,
first_name varchar(40) not null,
last_name varchar(40) not null unique,
has_a_license_from date not null
);

create table driving_schools
(id int primary key auto_increment,
name varchar(40) not null unique,
night_time_driving bool not null,
average_lesson_price decimal(10,2),
car_id int not null,
city_id int not null,
constraint fk_cars foreign key(car_id) references cars(id),
constraint fk_cities foreign key(city_id) references cities(id)
);

create table students
(
id int primary key auto_increment,
first_name varchar(40) not null,
last_name varchar(40) not null unique,
age int,
phone_number varchar(20) unique
);

create table instructors_driving_schools
(
instructor_id int ,
driving_school_id int not null,
constraint fk__dr_instructors foreign key(instructor_id) references instructors(id),
constraint fk_driving_school foreign key(driving_school_id) references driving_schools(id)
);

create table instructors_students
(instructor_id int not null,
student_id int not null,
constraint fk_st_instructors foreign key(instructor_id) references instructors(id),
constraint fk_students foreign key(student_id) references students(id)
);

insert into students (first_name,last_name,age,phone_number)
select reverse(lower(first_name)),
	reverse(lower(last_name)),
	age+left(phone_number,1),
	concat('1+',phone_number)
from students
where age<20;

update driving_schools ds
join cities c on ds.city_id=c.id
set ds.average_lesson_price=ds.average_lesson_price+30
where c.name='London' and night_time_driving=1;

delete from driving_schools
where night_time_driving=0;

select 
concat(first_name,' ',last_name) as full_name,
age
from students
where age=(
	select min(age)
    from students) 
and first_name like '%a%'
order by id;

select ds.id,ds.name,c.brand
from driving_schools ds
join cars c on ds.car_id=c.id
left join instructors_driving_schools ids on ds.id=ids.driving_school_id
where ids.instructor_id is null
order by c.brand,ds.id
limit 5;

select i.first_name,i.last_name,count(s.id) as student_count,c.name as city
from instructors i
join instructors_students ins
on i.id=ins.instructor_id
join students s on ins.student_id=s.id
join instructors_driving_schools ids on i.id=ids.instructor_id
join driving_schools ds on ids.driving_school_id=ds.id
join cities c on ds.city_id=c.id
group by i.id,i.first_name,i.last_name,c.name
having count(s.id) >1
order by student_count desc,i.first_name;

select c.name,count(distinct ids.instructor_id) as instructors_count
from cities c
join driving_schools ds on c.id=ds.city_id
join instructors_driving_schools ids on ds.id=ids.driving_school_id
where ids.instructor_id>0
group by c.name
order by instructors_count desc;

select concat(first_name,' ',last_name) as full_name,
case 
	when year(has_a_license_from)>=1980 and year(has_a_license_from)<1990 then 'Specialist'
    when year(has_a_license_from)>=1990 and year(has_a_license_from)<2000 then 'Advanced'
    when year(has_a_license_from)>=2000 and year(has_a_license_from)<2008 then 'Experienced'
    when year(has_a_license_from)>=2008 and year(has_a_license_from)<2015 then 'Qualified'
    when year(has_a_license_from)>=2015 and year(has_a_license_from)<2020 then 'Provisional'
    else 'Trainee'
end as level
from instructors
order by year(has_a_license_from),first_name;

delimiter $$
create function udf_average_lesson_price_by_city (city_name VARCHAR(40))
returns decimal(10,2)
deterministic
begin
	return (select avg(average_lesson_price)
    from driving_schools ds
    join cities c on ds.city_id=c.id
    where c.name=city_name);
end $$

delimiter $$
create procedure udp_find_school_by_car(in car_brand varchar(40))
begin
	select ds.name,ds.average_lesson_price
    from driving_schools ds
    join cars c on ds.car_id=c.id
    where c.brand=car_brand
    order by ds.average_lesson_price desc;
end $$