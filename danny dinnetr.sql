USE dannys_diner;

SELECT * FROM sales;
SELECT * FROM menu;
SELECT * FROM members as m;


### What is the total amount each customer spent at the restaurant?

select s.customer_id, sum(m.price) as total_amount_spent
from sales as s
join menu as m
on s.product_id  = m.product_id
group by customer_id;

# how many days have each customers visited the resturant
select s.customer_id,
count(distinct(order_date)) as no_of_days_visited
from sales as s
group by customer_id;

# what was the first item from the menu purchased by the customer
select s.customer_id,
sum(price) as total_amount_spent
from sales as s
join menu
on s.product_id = menu.product_id
group by customer_id;

#
select m.product_name, count(s.product_id) as product_count
from sales as s
join menu as m
on s.product_id = m.product_id
group by m.product_id
order by count(s.product_id) desc
limit 3;

#which item was the most popular for each customer

## stage 1: create a CTE for grouoping customers and their products
with popularity_cte as (
select sales.customer_id, 
	menu.product_name,
	count(sales.product_id) as total_no
from sales 
join menu
on menu.product_id = sales.product_id
group by sales.customer_id, sales.product_id
)
## stage 2: find the group with the highest count
select customer_id,
	product_name,
    max(total_no) as maximum_order_count
from popularity_cte
group by customer_id ;


#### subquery

select customer_id,
	product_name,
    max(total_no) as maximum_order_count
from
(select sales.customer_id, 
	menu.product_name,
	count(sales.product_id) as total_no
from sales 
join menu
on menu.product_id = sales.product_id
group by sales.customer_id, sales.product_id)
as popularity_subquery
group by customer_id ;




###################    which product was purchased by the customer after joining
select s.customer_id, mn.product_name, s.order_date, mm.join_date
from sales as s
join menu as mn
on s.product_id = mn.product_id
join members as mm
on  s.customer_id = mm.customer_id
where s.order_date >= mm.join_date 
GROUP BY customer_id
order by customer_id, order_date ASC
;



####### 7 