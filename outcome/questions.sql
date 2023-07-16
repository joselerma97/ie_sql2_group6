#For the Questions 1 - 4 we are using information about the cinema SP1

# 1.  Which is the most profitable title?
# Product Ticket Family = 1
select cin.name as cinema_name, fi.name as film_name, sum(t.total_order) as total
from family f inner join class c on (f.family_id = c.family_id) inner join category cat on (cat.class_id = c.class_id)
inner join product p on (cat.category_id = p.category_id) inner join ticket_item ti on (p.product_id = ti.product_id)
inner join ticket t on (t.ticket_id = ti.ticket_id) inner join film_ticket ft on (ft.film_ticket_id = t.ticket_id)
inner join film fi on (fi.id_film = ft.id_film) inner join cinema cin on (t.cinema_id = cin.cinema_id)
where f.family_id = 100 and cin.cinema_id =1 
group by cin.name, fi.name
having sum(t.total_order) >= ALL(
select sum(t.total_order)
from family f inner join class c on (f.family_id = c.family_id) inner join category cat on (cat.class_id = c.class_id)
inner join product p on (cat.category_id = p.category_id) inner join ticket_item ti on (p.product_id = ti.product_id)
inner join ticket t on (t.ticket_id = ti.ticket_id) inner join film_ticket ft on (ft.film_ticket_id = t.ticket_id)
inner join film fi on (fi.id_film = ft.id_film) inner join cinema cin on (t.cinema_id = cin.cinema_id)
where f.family_id = 100 and cin.cinema_id =1
group by cin.name, fi.name
)
order by film_name;

# 2. Percentaje of people that buys popcorn & soft drinks?
# Family of Beverages and Prepared Food: 50200000 , 50190000
# Class of Soft Drink and PopCorn: 50202300, 50192100
select cin.name as cinema_name, ifnull(
count(t.cinema_id) / (select count(t.cinema_id) from product p inner join category cat on (p.category_id = cat.category_id) inner join class c on (cat.class_id = c.class_id)
inner join ticket_item ti on (ti.product_id = p.product_id) inner join ticket t on (ti.ticket_id = t.ticket_id)
where c.family_id in (50200000,50190000) and t.cinema_id = cin.cinema_id) * 100 ,0) as percentage_popcorn_softdrinks 
from product p inner join category cat on (p.category_id = cat.category_id) inner join class c on (cat.class_id = c.class_id)
inner join ticket_item ti on (ti.product_id = p.product_id) inner join ticket t on (ti.ticket_id = t.ticket_id) inner join cinema cin on (cin.cinema_id = t.cinema_id)
where cin.cinema_id = 1 and (c.class_id = 50202300 or c.class_id = 50192100) 
group by cin.name
order by percentage_popcorn_softdrinks desc;

# 3. At which session is there the most number of people.
select c.name as cinema_name, fs.numroom, fs.date, fs.time, f.name as film_name, count(ft.film_ticket_id) as attendance
from film_session fs inner join film_ticket ft on (fs.cinema_id = ft.cinema_id and fs.numroom = ft.numroom and fs.id_film = ft.id_film
and fs.date = ft.date and fs.time = ft.time) inner join film f on (ft.id_film = f.id_film)
inner join room r on (r.cinema_id = fs.cinema_id) inner join cinema c on (c.cinema_id = r.cinema_id)
where c.cinema_id = 1
group by c.name, fs.numroom, fs.date, fs.time, f.name
having count(ft.film_ticket_id) >= ALL(
select count(ft.film_ticket_id)
from film_session fs inner join film_ticket ft on (fs.cinema_id = ft.cinema_id and fs.numroom = ft.numroom and fs.id_film = ft.id_film
and fs.date = ft.date and fs.time = ft.time) inner join film f on (ft.id_film = f.id_film)
inner join room r on (r.cinema_id = fs.cinema_id) inner join cinema c on (c.cinema_id = r.cinema_id)
where c.cinema_id = 1
group by c.name, fs.numroom, fs.date, fs.time, f.name
)
order by fs.date desc,fs.numroom desc;

# 4. Show the revenue per session.
select c.name as cinema_name, fs.numroom, fs.date, fs.time, f.name as film_name, sum(t.total_order) as total
from film_session fs inner join film_ticket ft on (fs.cinema_id = ft.cinema_id and fs.numroom = ft.numroom and fs.id_film = ft.id_film
and fs.date = ft.date and fs.time = ft.time) inner join film f on (ft.id_film = f.id_film)
inner join room r on (r.cinema_id = fs.cinema_id) inner join cinema c on (c.cinema_id = r.cinema_id)
inner join ticket t on (t.ticket_id = ft.film_ticket_id)
where c.cinema_id = 1
group by c.name, fs.numroom, fs.date, fs.time, f.name
order by total desc;

# 5 Tickets sold per staff using MasterCard in the cinema SP2
select cin.name as cinema_name, concat(peo.name,' ',peo.surname) as staff_name,
count(ti.ticket_id) as total_tickets
from ticket_item ti inner join product p on (ti.product_id = p.product_id) 
inner join category cat on (p.category_id = cat.category_id) inner join class c on (cat.class_id = c.class_id)
inner join ticket t on (ti.ticket_id = t.ticket_id) inner join ccpayment cp on (t.payment_id = cp.ccpayment_id)
inner join ccpayment_card cpi on (cp.ccpayment_id = cpi.ccpayment_id) inner join staff s on (t.staff_id = s.staff_id)
inner join people peo on (s.dni = peo.dni) inner join cinema cin on (t.cinema_id = cin.cinema_id)
where c.family_id = 100 and cpi.payment_type = 'MC' and cin.cinema_id = 4 
group by cin.name, concat(peo.name,' ',peo.surname)
order by total_tickets desc, staff_name asc;
