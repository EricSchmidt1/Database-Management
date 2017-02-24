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
       sum(orders.qty)
from orders inner join customers on orders.cid = customers.cid
group by customers.name, orders.pid
order by sum(orders.qty) DESC
;

-- Question 4
select customers.name,
       coalesce(sum(orders.qty),0)
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
                              