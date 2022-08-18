select min(website_pageview_id) as first_pageview_id,
       min(created_at) as first_created_at
 from website_pageviews
where created_at is not null
 and pageview_url='/lander-1';
 
 select min(wp.website_pageview_id),
		pageview_url as landing_page,
        wp.website_session_id
 from website_pageviews wp
 inner join website_sessions ws
 on wp.website_session_id=ws.website_session_id
 and wp.created_at <'2012-07-28'
 and wp.website_pageview_id > 23504
 and ws.utm_source ='gsearch'
 and ws.utm_campaign = 'nonbrand'
 group by wp.website_session_id;