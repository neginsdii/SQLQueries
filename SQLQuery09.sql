
select 
	country,
	AVG(score) as avg_score
from customers
where score !=0
group by country
having AVG(score)>430

