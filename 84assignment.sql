drop table t1;
create temporary table t1
select case when created_at < '2013-12-12' then 'A.pre_birthday_bear' 
            when created_At >= '2013-12-12' then 'B.post_birthday_bear'
            else 'check logic' end time_period,
            website_session_id
             from 
        website_sessions
        where created_at between '2013-11-12' and '2014-1-12'
      ;
        
   select * from t1;     
   select time_period,
count(distinct order_id)/count(distinct website_session_id) conv_rt,
sum(price_usd)/count(order_id) as AOV,
sum(items_purchased)/count(order_id) products_per_order,
sum(price_usd)/count(distinct website_session_id) as revenue_per_session
   from
   (
   select t1.time_period,
   t1.website_session_id,
   order_id,
   items_purchased,
   price_usd
   from t1
   left join orders on t1.website_Session_id=orders.website_session_id
   ) t2
   group by time_period;
   
   select t1.time_period,
   t1.website_session_id,
   order_id,
   items_purchased,
   price_usd
   from t1
   left join orders on t1.website_Session_id=orders.website_session_id;
   
   select count(distinct website_session_id) from t1;
   