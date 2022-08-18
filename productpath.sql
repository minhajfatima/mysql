create temporary table products_page
 select website_pageview_id,
        website_session_id,
        created_at,
        case when created_At< '2013-01-06' then 'A.pre-product-2'
		when created_at>='2013-01-06' then 'B.post-product-2' 
        else 'check logic'
        end as time_period
 from website_pageviews
 where created_at < '2013-04-06' -- date of request
            and created_at > '2012-10-06'
            and pageview_url= '/products'; 
            
            select * from products_page;
            
 create temporary table next_page_id
select     products_page.time_period,
           products_page.website_session_id,
           min(website_pageviews.website_pageview_id) as min_next_page
from  products_page
left join website_pageviews
on  products_page.website_session_id = website_pageviews.website_session_id
and website_pageviews.website_pageview_id>products_page.website_pageview_id
group by 1,2;
            
 create temporary table next_page_url
select    next_page_id.time_period,
          next_page_id.website_session_id,
          website_pageviews.pageview_url as next_page_url
 from next_page_id
 left join website_pageviews
 on website_pageviews.website_pageview_id=next_page_id.min_next_page;
 
 select time_period,
 count(distinct website_session_id) as sessions,
 count(distinct case when next_page_url.next_page_url is not null then website_session_id else null end) as w_next,
 count(distinct case when next_page_url.next_page_url is not null then website_session_id else null end)/ count(distinct website_session_id) as pct_x_next_page,
 count(distinct case when next_page_url.next_page_url='/the-original-mr-fuzzy' then website_session_id else null end) as mr_fuzzy_product,  
  count(distinct case when next_page_url.next_page_url='/the-original-mr-fuzzy' then website_session_id else null end)/count(distinct website_session_id) as pct_mr_fuzzy,
count(distinct case when next_page_url.next_page_url='/the-forever-love-bear' then website_session_id else null end) as love_bear_product,   
count(distinct case when next_page_url.next_page_url='/the-forever-love-bear' then website_session_id else null end)/count(distinct website_session_id) as pct_love_bear_product
from next_page_url
group by 1;