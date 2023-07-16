# Hostname: 92.249.44.156
# Schema: u433398063_ie
# User: u433398063_group6
# Password: E7KGuhWe|

#drop database group_assignment;
#create database group_assignment;

#use group_assignment;

#Address
create table address_type(
type_id char(1) primary key,
description varchar(40)
);

create table zip_code(
zipcode int,
country varchar(20),
city varchar(20),
state varchar(20),
PRIMARY KEY(zipcode,country)
);

create table address(
address_id bigint primary key auto_increment,
type_id char(1),
name varchar(40),
number int,
zipcode int,
country varchar(20)
);

alter table address add foreign key(type_id) references address_type(type_id);
alter table address add foreign key(zipcode,country) references zip_code(zipcode,country);

create table location_type(
type_id char(1) primary key,
description varchar(40)
);

create table location(
location_id bigint primary key auto_increment,
type_id char(1),
address_id bigint
);

alter table location add foreign key(type_id) references location_type(type_id);
alter table location add foreign key(address_id) references address(address_id);

create table contact_type(
contact_type_id char(1) primary key,
name varchar(50)
);

create table contact_info(
location_id bigint,
numseq int,
contact_type_id char(1),
value varchar(50),
description varchar(50),
PRIMARY KEY (location_id,numseq)
);

alter table contact_info add foreign key(location_id) references location(location_id);
alter table contact_info add foreign key(contact_type_id) references contact_type(contact_type_id);

#Cinema
create table cinema(
cinema_id bigint primary key auto_increment,
name varchar(50) unique,
location_id bigint
);

alter table cinema add foreign key(location_id) references location(location_id);

#People
create table people(
dni varchar(50) primary key,
name varchar(50),
surname varchar(50),
birthdate date
);

create table staff_status(
staff_status_id char(1) primary key,
name varchar(50)
);


create table staff(
staff_id bigint primary key auto_increment,
dni varchar(50),
cinema_id bigint,
join_date date not null,
left_date date,
staff_status_id char(1),
hours_per_week int
);

alter table staff add foreign key(dni) references people(dni);
alter table staff add foreign key(cinema_id) references cinema(cinema_id);
alter table staff add foreign key(staff_status_id) references staff_status(staff_status_id);


create table seat(
row_key varchar(2),
row_num int,
PRIMARY KEY(row_key,row_num)
);

create table room(
cinema_id bigint,
numroom int,
PRIMARY KEY(cinema_id,numroom)
);

alter table room add foreign key(cinema_id) references cinema(cinema_id);

create table room_seat(
cinema_id bigint,
numroom int,
row_key varchar(2),
row_num int,
PRIMARY KEY(cinema_id,numroom,row_key,row_num)
);

alter table room_seat add foreign key(cinema_id,numroom) references room(cinema_id,numroom);
alter table room_seat add foreign key(row_key,row_num) references seat(row_key,row_num);

#Movies
create table language(
id_language varchar(6) primary key,
name varchar(20)
);

create table star(
id_star bigint primary key auto_increment,
name varchar(30),
surname varchar(30)
);

create table film_genre(
id_film_genre bigint primary key auto_increment,
name varchar(50)
);

create table unit_measure(
metric_code char(2) primary key,
name varchar(20),
description varchar(128)
);

create table film(
id_film bigint primary key auto_increment,
name varchar(128),
release_date date,
id_language varchar(6),
duration_code char(2),
duration_decimal decimal(10,2),
director bigint,
synopsis text,
cover blob
);

alter table film add foreign key(id_language) references language(id_language);
alter table film add foreign key(duration_code) references unit_measure(metric_code);
alter table film add foreign key(director) references star(id_star);

create table film_cast(
id_film bigint,
id_star bigint,
PRIMARY KEY(id_film,id_star)
);

alter table film_cast add foreign key(id_film) references film(id_film);
alter table film_cast add foreign key(id_star) references star(id_star);

create table film_genre_assignation(
id_film bigint,
id_film_genre bigint,
PRIMARY KEY(id_film,id_film_genre)
);

alter table film_genre_assignation add foreign key(id_film_genre) references film_genre(id_film_genre);
alter table film_genre_assignation add foreign key(id_film) references film(id_film);

create table film_picture(
id_picture bigint primary key auto_increment,
id_film bigint,
picture blob
);

alter table film_picture add foreign key(id_film) references film(id_film);

create table film_session(
cinema_id bigint,
numroom int,
id_film bigint,
date date,
time time,
id_language varchar(6),
PRIMARY KEY(cinema_id,numroom,id_film,date,time)
);

alter table film_session add foreign key(cinema_id,numroom) references room(cinema_id,numroom);
alter table film_session add foreign key(id_film) references film(id_film);
alter table film_session add foreign key(id_language) references language(id_language);


#Ticket
create table ccpayment_type(
cctype char(2) primary key,
description varchar(40)
);

create table ccentry_method(
ccmethod char(2) primary key,
description varchar(40)
);

create table ccpayment_state(
ccstate char(1) primary key,
description varchar(40)
);

create table currency(
currency_id char(3) primary key,
currency_code smallint,
description varchar(40)
);

create table ccpayment(
ccpayment_id bigint primary key auto_increment,
ccpaytran_id bigint,
currency_id char(3),
ccpayment_state char(1),
expected_amount decimal(20,5),
approving_amount decimal(20,5),
approved_amount decimal(20,5),
timecreated timestamp,
timeupdated timestamp,
timeexpired timestamp
);

alter table ccpayment add foreign key(currency_id) references currency(currency_id);
alter table ccpayment add foreign key(ccpayment_state) references ccpayment_state(ccstate);

create table ccpayment_card(
ccpayment_id bigint primary key,
payment_type char(2),
ccentry_method char(2),
is_encrypt char(1),
card_number varchar(64),
bankname varchar(64),
ccexpdate char(6)
);

alter table ccpayment_card add foreign key(ccpayment_id) references ccpayment(ccpayment_id);
alter table ccpayment_card add foreign key(payment_type) references ccpayment_type(cctype);
alter table ccpayment_card add foreign key(ccentry_method) references ccentry_method(ccmethod);


create table ticket(
ticket_id bigint primary key auto_increment,
timeplaced timestamp,
cinema_id bigint,
staff_id bigint,
total_product decimal(20,5),
total_tax decimal(20,5),
total_order decimal(20,5),
currency_id char(3),
payment_id bigint
);

alter table ticket add foreign key(cinema_id) references cinema(cinema_id);
alter table ticket add foreign key(staff_id) references staff(staff_id);
alter table ticket add foreign key(currency_id) references currency(currency_id);
alter table ticket add foreign key(payment_id) references ccpayment(ccpayment_id);

create table family( #Films or Restaurant
family_id bigint primary key auto_increment,
name varchar(40),
description varchar(128)
);

create table class( #Tickets or Food, drinks, etc
class_id bigint primary key auto_increment,
name varchar(40),
description varchar(128),
family_id bigint
);
alter table class add foreign key(family_id) references family(family_id);

create table category(#Types of tickets, food, drinks, etc. For instance, adult ticket, kid ticket, pop corn, soda
category_id bigint primary key auto_increment,
name varchar(80),
description varchar(128),
class_id bigint
);
alter table category add foreign key(class_id) references class(class_id);

create table product(
product_id bigint primary key auto_increment,
category_id bigint,
metric_code char(2),
metric_decimal decimal(10,2),
description text,
thumbnail blob,
fullimage blob
);
alter table product add foreign key(category_id) references category(category_id);
alter table product add foreign key(metric_code) references unit_measure(metric_code);

create table price( 
product_id bigint primary key,
price_currency char(3),
price_decimal decimal(10,2),
taxes decimal(10,2)
);

alter table price add foreign key(product_id) references product(product_id);
alter table price add foreign key(price_currency) references currency(currency_id);


create table ticket_item(
ticket_id bigint,
numseq int,
product_id bigint,
quantity smallint,
price decimal(20,5),
tax_amount decimal(20,5),
product_amount decimal(20,5),
PRIMARY KEY(ticket_id,numseq)
);

alter table ticket_item add foreign key(ticket_id) references ticket(ticket_id);
alter table ticket_item add foreign key(product_id) references product(product_id);

create table film_ticket(
film_ticket_id bigint primary key,
cinema_id bigint,
numroom int,
id_film bigint,
date date,
time time
);

alter table film_ticket add foreign key(film_ticket_id) references ticket(ticket_id);
alter table film_ticket add foreign key(cinema_id,numroom,id_film,date,time) references film_session(cinema_id,numroom,id_film,date,time);

create table film_ticket_seat(
film_ticket_id bigint,
cinema_id bigint,
numroom int,
row_key varchar(2),
row_num int,
PRIMARY KEY(film_ticket_id,cinema_id,numroom,row_key,row_num)
);

alter table film_ticket_seat add foreign key(film_ticket_id) references film_ticket(film_ticket_id);
alter table film_ticket_seat add foreign key(cinema_id,numroom,row_key,row_num) references room_seat(cinema_id,numroom,row_key,row_num);