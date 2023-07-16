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