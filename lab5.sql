-- Question 1
select city
from agents inner join orders on orders.aid = agents.aid
where orders.cid  = 'c006';

-- Question 2
select distinct pid
from orders inner join customers on orders.cid = customers.cid
where customers.city = 'Kyoto'
order by pid DESC;

-- Question 3
select name
from customers 
where cid not in (select distinct cid
					from orders
              	  );
                  
-- Question 4
select name
from customers left outer join orders on orders.cid = customers.cid
where orders.ordNumber is null;

-- Question 5
select distinct customers.name,
	   			agents.name
from customers inner join orders on orders.cid = customers.cid
			   inner join agents on orders.aid = agents.aid
where customers.city = agents.city;

-- Question 6 
select customers.name,
	   agents.name,
       customers.city as "Shared City"
from customers inner join agents on customers.city = agents.city
where customers.city = agents.city;

-- Question 7
select name,
       city
from customers
where city in (select city
              from (select city,
                    	   count(*)
                    from products
                    group by city
                    order by count(*) ASC,
                    	     city
                    limit 1
                    )sub2
              )
group by city, name;





