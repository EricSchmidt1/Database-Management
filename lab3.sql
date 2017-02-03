select ordNumber, totalUSD --1
from Orders;

select name, city--2
from Agents
where name = 'Smith';

select pid, name, priceUSD --3
from Products
where quantity > 200100;

select name, city --4
from Customers
where city = 'Duluth';

select name --5
from Agents
where city <> 'New York' 
and city <> 'Duluth';

select * --6
from Products
where city <> 'Dallas' 
and city <> 'Duluth' 
and priceUSD >= 1;

select *  --7
from Orders
where month = 'Feb' or month =  'May';

select *  --8
from Orders
where month = 'Feb'
and totalUSD >= 600;

select * --9
from Orders
where cid = 'c005';