select c.first_name, o.sales
from customers as c
inner join orders as o
			on c.id= o.customer_id