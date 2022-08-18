create temporary table product_seen_table
select  website_pageview_id,
        website_session_id,
        pageview_url as product_seen
from website_pageviews
where created_at between '2013-01-06' and '2013-04-10'
and pageview_url in('/the-original-mr-fuzzy', '/the-forever-love-bear');

select * from product_seen_table;

select distinct pageview_url from website_pageviews;
create temporary table next_page_made_it
select 
        website_Session_id,
        
     case when product_seen='/the-original-mr-fuzzy' then 'mr-fuzzy'
           when product_seen='/the-forever-love-bear' then 'love-bear'
           else 'check logic' end as product_viewed,
           max(cart_page) as cart_made_it,
           max(billing_page) as billing_made_it,
           max(shipping_page) as shipping_made_it,
           max(thankyou_page) as thankyou_made_it
     from
(
    select product_seen_table.website_session_id,
           product_seen,
           
   case when pageview_url='/cart' then 1 else 0 end as cart_page,        
   case when pageview_url='/shipping' then 1 else 0 end as shipping_page, 
   case when pageview_url='/billing-2' then 1 else 0 end as billing_page,  
   case when pageview_url='/thank-you-for-your-order' then 1 else 0 end as thankyou_page   
   
   from product_seen_table
   left join website_pageviews
   on website_pageviews.website_session_id=product_seen_table.website_session_id
   and website_pageviews.website_pageview_id>product_seen_table.website_pageview_id
) as session_level_pageview
group by 1
;
select * from next_page_made_it;
select 
   product_viewed,
   count( distinct case when cart_made_it=1 then website_session_id else 0 end) as cart_page,        
   count(distinct case when shipping_made_it=1 then website_session_id else 0 end) as shipping_page, 
   count(distinct case when billing_made_it=1 then website_session_id else 0 end) as billing_page,  
   count(distinct case when thankyou_made_it=1 then website_session_id else 0 end) as thankyou_page
   from next_page_made_it
  -- left join product_seen_table
 --  on next_page_made_it.website_session_id=product_seen_table.website_session_id
   group by 1;
   
   select 
   product_viewed,
   count(distinct case when cart_made_it=1 then website_session_id else null end)/count(distinct website_session_id) as product_made_it,        
   count(distinct case when shipping_made_it=1 then website_session_id else null end)/count(distinct case when cart_made_it=1 then website_session_id else null end) as cart_click_rt, 
   count(distinct case when billing_made_it=1 then website_session_id else null end)/count(distinct case when shipping_made_it=1 then website_session_id else null end) as billing_page,  
   count(distinct case when thankyou_made_it=1 then website_session_id else null end)/count(distinct case when billing_made_it=1 then website_session_id else null end) as thankyou_page
   from next_page_made_it
 --  left join product_seen_table
 --  on next_page_made_it.website_session_id=product_seen_table.website_session_id
   group by 1;
   
   
