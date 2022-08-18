select website_pageviews.website_session_id,
	website_pageviews.pageview_url,
    order_id
from website_pageviews
 left join orders
 on website_pageviews.website_session_id=orders.website_session_id
where pageview_url in ('/billing', '/billing-2')    
and website_pageview_id  > 53550
and website_pageviews.created_at < '2012-11-10';


select billing_version,
count(websession) as sessions,
count(order_id) orders,
count(order_id)/count(websession) as billing_to_order

from

(select website_pageviews.website_session_id websession,
	website_pageviews.pageview_url billing_version,
    order_id
from website_pageviews
 left join orders
 on website_pageviews.website_session_id=orders.website_session_id
where pageview_url in ('/billing', '/billing-2')    
and website_pageview_id  > 53550
and website_pageviews.created_at < '2012-11-10') as billing_to_order

group by billing_version;
