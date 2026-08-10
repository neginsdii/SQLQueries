select FirstName
from DimCustomer
where LEFT( FirstName,1) NOT IN ('A','B', 'C', 'D', 'E','F','G')