drop table if exists funnel1;

select * from funnel1;
 
(
select website_session_id,
     max(product_page) as products_made_it,
     max(mrfuzzy_page) as mr_fuzzy_made_it,
     max(cart_page) as cart_made_it
     
from(

select 
ws.website_session_id,
wp.pageview_url,
wp.created_at as page_created_at,
case when pageview_url='/products' then 1 else 0 end as product_page,
case when pageview_url='/the-original-mr-fuzzy' then 1 else 0 end as mrfuzzy_page,
case when pageview_url='/cart' then 1 else 0 end as cart_page
from website_sessions ws
left join website_pageviews wp
on wp.website_session_id=ws.website_session_id
where 
wp.created_at between '2014-01-01' and '2014-02-01'
and wp.pageview_url in ( '/lander-2','/products','/the-original-mr-fuzzy','/cart')
order by ws.website_session_id,
         wp.created_at) as funnel
         group by website_session_id) ;
         
         select * from funnel1;
 select count(distinct website_session_id) as total_sessions,
	count(distinct case when products_made_it=1 then website_session_id else null end) as product_page,
	count(distinct case when mr_fuzzy_made_it=1 then website_session_id else null end) as mrfuzzy_page,
    count(distinct case when cart_made_it=1 then  website_session_id else null end) as cart_page
    from funnel1 fn;
    
    select * from website_pageviews where website_session_id=1059;
    
    create temporary table funnel2
   
   select website_session_id,
     max(product_page) as products_made_it,
     max(mrfuzzy_page) as mr_fuzzy_made_it,
     max(cart_page) as cart_made_it
     
from(

select 
ws.website_session_id,
wp.pageview_url,
wp.created_at as page_created_at,
case when pageview_url='/products' then 1 else 0 end as product_page,
case when pageview_url='/the-original-mr-fuzzy' then 1 else 0 end as mrfuzzy_page,
case when pageview_url='/cart' then 1 else 0 end as cart_page
from website_sessions ws
left join website_pageviews wp
on wp.website_session_id=ws.website_session_id
where 
wp.created_at between '2014-01-01' and '2014-02-01'
and wp.pageview_url in ( '/lander-2','/products','/the-original-mr-fuzzy','/cart')
order by ws.website_session_id,
         wp.created_at) as funnel
         group by website_session_id ;
         
         select * from funnel2;
   select
 count(distinct website_session_id) as total_sessions,
	count(distinct case when products_made_it=1 then website_session_id else null end)/count(distinct website_session_id) as clicked_to_product_page,
	count(distinct case when mr_fuzzy_made_it=1 then website_session_id else null end)/count(distinct case when products_made_it=1 then website_session_id else null end) as clicked_to_mrfuzzy_page,
    count(distinct case when cart_made_it=1 then  website_session_id else null end)/count(distinct case when mr_fuzzy_made_it=1 then website_session_id else null end) as clicked_to_cart_page
    from funnel2;      