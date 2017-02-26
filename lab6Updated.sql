-- Question 1
select distinct customers.name,
	   customers.city
from customers inner join products on customers.city = products.city
where products.city in (select city
               from products 
               group by city
               order by count(quantity) DESC
               limit 1
               )
;
               
-- Question 2 
select name
from products
where priceUSD > (select avg(priceUSD)
                   from products
                 )
order by name DESC
;

-- Question 3
select customers.name,
	   orders.pid,
       sum(orders.totalUSD)
from orders inner join customers on orders.cid = customers.cid
group by customers.name, orders.pid
order by sum(orders.totalUSD) DESC
;

-- Question 4
select customers.name,
	   coalesce(sum(orders.totalUSD),0)
from customers full join orders on customers.cid = orders.cid
group by customers.name
order by customers.name ASC
;

-- Question 5
select customers.name as "Customer Name",
	   products.name as "Product Name",
       agents.name as "Agent Name"
from orders inner join customers on customers.cid = orders.cid
            inner join agents on agents.aid = orders.aid
            inner join products on products.pid = orders.pid
where agents.city = 'Newark'
;

-- Question 6
select orders.*,
      (orders.qty * products.priceUSD * (1-customers.discount / 100)) as "Check Price"
from orders inner join customers on customers.cid = orders.cid
            inner join agents on agents.aid = orders.aid
            inner join products on products.pid = orders.pid
where orders.totalUSD <>  (orders.qty * products.priceUSD * (1-customers.discount / 100))
;

-- Question 7
-- Left Outer Join takes all the values from the left of the join function and and add values from
-- right hand side that correspond with those values.
-- Right Outer Join takes all the values from the right of the join
-- function and adds the values of the left hand side that correspond with it.
-- Example of Left Outer Join 
-- select *
-- from customers left outer join orders on customers.cid = orders.cid;
-- This would put all the values of orders onto customers. This makes customer c005 appear even though they 
-- did not make any orders.
-- Example of Right Outer Join 
-- select * 
-- from orders right outer join agents on orders.aid = agents.aid;
-- This would take all the values from order onto the values within agents. This shows agents who did not make
-- any orders, which in this case would be agent a08.





                              