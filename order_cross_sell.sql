select * from orders where order_id between 10000 and 11000;
select * from order_items where order_id between 10000 and 11000;

select
orders.primary_product_id,
order_items.product_id cross_sel,
count(distinct orders.order_id) orders,
count(distinct case when order_items.product_id=1 then orders.order_id else null end) X_sell1,
count(distinct case when order_items.product_id=2 then orders.order_id else null end) X_sell2,
count(distinct case when order_items.product_id=3 then orders.order_id else null end) X_sell3

from orders
left join order_items
on orders.order_id=order_items.order_id
and order_items.is_primary_item=0
where orders.order_id between 10000 and 11000
group by 1;

