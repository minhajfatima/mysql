create temporary table t1
select case when created_at < '2013-09-25' then 'A.pre_product_launch' 
            when created_At > '2013-09-25' then 'B.post_product_launch'
            else 'check logic' end time_period,
            website_session_id,
            website_pageview_id
  from 
        website_pageviews
        where created_at between '2013-08-25' and '2013-10-25'
        and pageview_url='/cart';
        
create temporary table t2_
select time_period,
	   t1.website_session_id,
       min(website_pageviews.website_pageview_id) next_page_id
from t1
left join website_pageviews
on t1.website_session_id=website_pageviews.website_session_id
and t1.website_pageview_id<website_pageviews.website_pageview_id
group by 1,2
having min(website_pageviews.website_pageview_id) is not null;

create temporary table t3
select t1.time_period,
       t1.website_session_id,
       order_id,
       items_purchased,
       price_usd
 from t1
 inner join orders
 on orders.website_session_id=t1.website_session_id;
 
 select * from t1;
select time_period,
count(distinct website_Session_id) as cart_session,
sum(clicked_to_another_page) as click_through,
round(sum(clicked_to_another_page)/count(distinct website_session_id),2) as cart_ctr,
sum(placed_order) order_placed,
sum(items_purchased) products_purchased,
round(sum(items_purchased)/sum(placed_order),2) cross_sell_rt,
sum(price_usd) revenue,
round(sum(price_usd)/sum(placed_order),2) AOV,
round(sum(price_usd)/count(distinct website_session_id),3) rev_per_cart_session
 
from
( select t1.time_period,
        t1.website_session_id,
       case when t2.website_session_id is null then 0 else 1 end clicked_to_another_page,
       case when t3.order_id is null then 0 else 1 end placed_order,
        t3.items_purchased,
        t3.price_usd
 from t1
 left join t2 on t1.website_session_id=t2.website_session_id
 left join t3 on t2.website_session_id=t3.website_session_id
 order by t1.website_session_id
 ) as t4 group by time_period;