drop table funnel45;
create temporary table funnel45
select website_session_id, 
	max(product_page) as made_to_product,
        max(mrfuzzy_page) made_to_mrfuzzy,
        max(cart_page) made_to_cart,
        max(shipping_page) shipping,
        max(billing_page) billing,
        max(successfully_ordered) success
from
(   

select 
ws.website_session_id, wp.website_pageview_id,
wp.pageview_url as lander,
wp.created_at as page_created_at,
case when pageview_url='/products' then 1 else 0 end as product_page,
case when pageview_url='/the-original-mrfuzzy' then 1 else 0 end as mrfuzzy_page,
case when pageview_url='/cart' then 1 else 0 end as cart_page,
case when pageview_url='/shipping' then 1 else 0 end as shipping_page,
case when pageview_url='/billing' then 1 else 0 end as billing_page,
case when pageview_url='//thank-you-for-your-order' then 1 else 0 end as successfully_ordered 
from website_sessions ws
left join website_pageviews wp
on wp.website_session_id=ws.website_session_id
where 
wp.created_at >'2012-08-05' and wp.created_at < '2012-09-05' and
ws.utm_source = 'gsearch'
and ws.utm_campaign= 'nonbrand'

order by ws.website_session_id,
         wp.created_at
         ) as pageview_level
         group by website_session_id
         ;
         
         
          select
 count(distinct website_session_id) as total_sessions,
	count(distinct case when made_to_product=1 then website_session_id else null end) product,
	count(distinct case when made_to_mrfuzzy=1 then website_session_id else null end) mrfuzzy,
    count(distinct case when made_to_cart=1 then  website_session_id else null end) cart,
    count(distinct case when shipping=1 then  website_session_id else null end) shipping,
    count(distinct case when billing=1 then  website_session_id else null end) billing,
    count(distinct case when success=1 then  website_session_id else null end) success
    from funnel45
;
         
         
    select * from website_pageviews where website_session_id=1059;
    