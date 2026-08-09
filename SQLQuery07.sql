select 
	country,
	SUM(score) as totalScore,
	COUNT(id) as totalCustomers
from customers
group by country