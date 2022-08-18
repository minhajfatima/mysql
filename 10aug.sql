select utm_content,
count( website_sessions.website_session_id) as sessions,
count(orders.order_id) orders,
count(orders.order_id)/count( website_sessions.website_session_id) conv_rate
from website_sessions 
left join orders 
on website_sessions.website_session_id=orders.website_session_id
where website_sessions.created_At between '2014-01-01' and '2014-02-01'
group by 1 order by 2 desc;

select * from website_sessions where website_session_id=1059;

select date(min(created_at)) as week_start_date,
count(distinct website_session_id) as total_sessions,
        count(distinct case when utm_source='gsearch' then website_session_id else null end) gsearch_sessions,
        count(distinct case when utm_source='bsearch' then website_session_id else null end) bsearch_sessions
 from website_sessions
 where created_at between '2012-08-22' and '2012-11-29'
 and utm_campaign='nonbrand'
 group by week(created_at);
 
 select utm_source,
 count(distinct website_session_id) as total_sessions,
 count(distinct case when device_type='mobile' then website_session_id else null end) as mobile_sessions,
 count(distinct case when device_type='desktop' then website_session_id else null end) as desktop_sessions
 from website_sessions
 where created_at between '2012-08-22' and '2012-11-30'
 and utm_Source in ('bsearch','gsearch') and utm_campaign='nonbrand'
 group by 1;
 
 select utm_source,
 count(distinct website_session_id) as total_sessions,
 count(distinct case when device_type='mobile' then website_session_id else null end) as mobile_sessions,
 count(distinct case when device_type='mobile' then website_session_id else null end)/count(distinct website_session_id) pct,
 count(distinct case when device_type='desktop' then website_session_id else null end) as desktop_sessions
 from website_sessions
 where created_at between '2012-08-22' and '2012-11-30'
 and utm_Source in ('bsearch','gsearch') and utm_campaign='nonbrand'
 group by 1;
 
 select device_type,
		utm_source,
        count(distinct website_sessions.website_session_id) as sessions,
        count(orders.order_id) as orders,
        count(orders.order_id)/count(distinct website_sessions.website_session_id) as conv_rate
  from website_sessions
  left join orders
  on website_sessions.website_session_id=orders.website_session_id
  where website_sessions.created_at between '2012-08-22' and '2012-09-18'
and utm_campaign='nonbrand'
group by 1,2; 

select date(min(created_at)) week_start_date,
       count(distinct case when utm_source='gsearch' and device_type='desktop' then website_session_id else null end) as g_d_sessions,
       count(distinct case when utm_source='bsearch' and device_type='desktop' then website_session_id else null end) as b_d_sessions,
       count(distinct case when utm_source='bsearch' and device_type='desktop' then website_session_id else null end)/count(distinct case when utm_source='gsearch' and device_type='desktop' then website_session_id else null end) b_to_d_pct,
       count(distinct case when utm_source='gsearch' and device_type='mobile' then website_session_id else null end) as g_m_sessions,
       count(distinct case when utm_source='bsearch' and device_type='mobile' then website_session_id else null end) as g_d_sessions,
       count(distinct case when utm_source='bsearch' and device_type='mobile' then website_session_id else null end)/count(distinct case when utm_source='gsearch' and device_type='mobile' then website_session_id else null end) b_to_d_mob_pct
       
from website_sessions
where created_at between '2012-11-04' and '2012-12-22'
and utm_campaign='nonbrand'
group by week(created_at);

select distinct utm_source,utm_campaign, http_referer from website_sessions;

select year(created_at) as yr,
       month(created_at) as mnth,
       count(distinct case when utm_campaign='nonbrand' then website_session_id else null end) nonbrand_sessions,
       count(distinct case when utm_campaign='brand' then website_session_id else null end) brand_sessions,
       count(distinct case when utm_campaign='brand' then website_session_id else null end)/ count(distinct case when utm_campaign='nonbrand' then website_session_id else null end) pct_brand,
       count(distinct case when http_referer='https://www.gsearch.com' and utm_source is null then website_session_id else null end) gsearch_organic,
       count(distinct case when http_referer='https://www.gsearch.com' and utm_source is null then website_session_id else null end)/count(distinct case when utm_campaign='nonbrand' then website_session_id else null end) pct_org_gsearch,
       count(distinct case when http_referer='https://www.bsearch.com' and utm_source is null then website_session_id else null end) bsearch_organic,
       count(distinct case when http_referer='https://www.bsearch.com' and utm_source is null then website_session_id else null end)/count(distinct case when utm_campaign='nonbrand' then website_session_id else null end) pct_org_bsearch,
       count(distinct case when http_referer is null and utm_source is null then website_session_id else null end) direct_traffic,
       count(distinct case when http_referer is null and utm_source is null then website_session_id else null end)/count(distinct case when utm_campaign='nonbrand' then website_session_id else null end) pct_direct
from 
     website_sessions
     where created_at<'2012-12-23'
     group by 2;
     
     select hour,
    round( avg(sessions),1) avg_sessions,
    round(avg( case when wdy=0 then sessions else null end),1) mon, 
      round(avg( case when wdy=1 then sessions else null end),1) tue,
        round(avg( case when wdy=2 then sessions else null end),1) wed,
          round(avg( case when wdy=3 then sessions else null end),1) thur,
            round(avg( case when wdy=4 then sessions else null end),1) fri,
              round(avg( case when wdy=5 then sessions else null end),1) sat,
                round(avg( case when wdy=6 then sessions else null end),1) sun
                     
     from (
     select date(created_at) date,
            weekday(created_at) wdy,
            hour(created_at) hour,
            count(distinct website_session_id) sessions
     from website_sessions 
	where created_at between '2012-09-15' and '2012-11-15'
    group by 1,2,3
       ) daily_hourly_sessions
       group by 1
       order by 1
       ;
select distinct pageview_url
from website_pageviews;

select year(created_at) yr,
	month(created_At) mon,
    count(ordeR_id) total_sales,
    sum(price_usd) total_revenue,
    sum(price_usd - cogs_usd) total_margin
from orders 
where created_At < '2013-01-04'
group by 1,2
;    
    select min(orders.created_at) month,
		count(order_id) total_count,
        count(order_id)/count(website_sessions.website_session_id) conv_rate,
        sum(price_usd)/count(website_sessions.website_session_id) revenue_per_session,
 count(case when primary_product_id=1 then order_id else null end) product_one_revenue,
 count(case when primary_product_id=2 then order_id else null end) product_two_revenue
 from website_sessions
 left join orders
 on website_sessions.website_session_id=orders.website_session_id
 where orders.created_at between '2012-04-01' and '2013-04-05'
 group by month(orders.created_At);
 
 
 
 
        
        
  
    
    