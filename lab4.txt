select city
from agents
where aid in (select aid
              from orders
              where orders.cid = 'c006'
              );
            
select distinct pid
from orders
where cid in (select cid
              from customers
              where customers.city = 'Kyoto'
              )
order by pid DESC;

select cid, name
from customers
where cid not in (select cid
              	  from orders
                  where orders.aid = 'a01'
              );
              
select cid
from orders 
where pid = 'p07'
and cid in (select cid
            from orders
            where pid = 'p01'
           )
;

select distinct pid
from products
where pid not in (select pid
			      from orders
			      where cid in (select pid
                            from orders
                            where aid = 'a08'
                            )
              	  )
order by pid ASC;

select name, discount, city
from customers
where cid in (select cid 
              from orders 
              where aid in (select aid
             			    from agents
              				where agents.city = 'New York' 
                            or    agents.city = 'Tokyo'
              )
             );

select * 
from customers
where discount in (select discount
				   from customers
				   where city = 'Duluth'
				   or city = 'London'
                   );