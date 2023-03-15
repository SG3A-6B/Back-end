drop database if exists partiokauppa;
create database partiokauppa;
use partiokauppa;

create table category (
    id int primary key auto_increment,
    name varchar(50) not null
);

insert into category values ('Saappaat');
insert into category values ('Puukot');
insert into category values ('Teltat');