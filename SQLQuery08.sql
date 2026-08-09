select 
	country,
	SUM(score)
from customers
group by country
having SUM(score)>800
