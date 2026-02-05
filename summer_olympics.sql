create database summer_olympics;

create table countries
(
id int primary key auto_increment,
name varchar(40) not null unique
);

create table sports 
(
id int primary key auto_increment,
name varchar(20) not null unique
);

create table disciplines 
(
id int primary key auto_increment,
name varchar(40) not null unique,
sport_id int not null,
constraint fk_disciplines_sports foreign key(sport_id) references sports(id)
);

create table athletes 
(
id  int primary key auto_increment,
first_name varchar(40) not null,
last_name varchar(40) not null,
age int not null,
country_id int not null,
constraint fk_athletes_countries foreign key(country_id) references countries(id)
);

create table medals 
(
id int primary key auto_increment,
`type` varchar(10) not null unique
);

create table disciplines_athletes_medals
(
discipline_id int not null,
athlete_id int not null,
medal_id int not null,
primary key (athlete_id,discipline_id),
constraint fk_dis_ath_med_dis foreign key(discipline_id) references disciplines(id),
constraint fk_dis_ath_med_ath foreign key(athlete_id) references athletes(id),
constraint fk_dis_ath_med_med foreign key(medal_id) references medals(id),
unique(discipline_id,medal_id)
);

insert into athletes(first_name,last_name,age,country_id)
select 
	upper(a.first_name),
	concat(a.last_name,' ','comes from',' ',c.name)as last_name,
    a.age + a.country_id as 'age',
    a.country_id
from athletes a
join countries c on a.country_id=c.id
where c.name like 'A%';

update disciplines
set name=replace(name,'weight','')
where name like '%weight%' or name like '%weight';

delete from athletes
where age>35;

select c.id,c.name
from countries c
left join athletes a on a.country_id=c.id
where country_id is null
order by name desc
limit 15;

select concat(first_name,' ',last_name) as full_name ,
age
from athletes a
join disciplines_athletes_medals dam
on a.id=dam.athlete_id
where age=(select min(age) from athletes) and dam.medal_id is not null
order by id
limit 2;

select a.id,a.first_name,a.last_name 
from athletes a
left join disciplines_athletes_medals dam on a.id=dam.athlete_id
where dam.medal_id is null
order by id;

select a.id,a.first_name,a.last_name,count(dam.medal_id) as medals_count,s.name as sport
from athletes a
join disciplines_athletes_medals dam on a.id=dam.athlete_id
join disciplines d on d.id=dam.discipline_id
join sports s on d.sport_id=s.id
group by a.id,a.first_name,a.last_name,s.name
order by medals_count desc,a.first_name
limit 10;

select concat(first_name,' ',last_name) as full_name,
case 
	when age <=18 then 'Teenager'
    when age >18 and age <=25 then 'Young adult'
    else 'Adult'
end as 'age_group'
from athletes
order by age desc,first_name;

delimiter $$
create function udf_total_medals_count_by_country(name varchar(40))
returns int
deterministic
begin
	return (select count(dam.medal_id)
    from countries c
    join athletes a on c.id=a.country_id
    join disciplines_athletes_medals dam
    on dam.athlete_id=a.id
    where c.name=name);
end $$

delimiter $$
create procedure udp_first_name_to_upper_case(in letter char(1))
begin
	update athletes 
    set first_name=upper(first_name)
    where right(first_name,1)=letter;
end $$