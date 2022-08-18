select date( min(created_at)) from
website_pageviews where created_at between '2012-06-01' and '2012-07-31'
group by week(created_at) ;
 
 
drop table first_pageviews1;

create temporary table first_pageviews1
select website_session_id,
		min(website_pageview_id) as min_page_id ,
        created_at,
        pageview_url
        from website_pageviews
        where created_at <'2012-08-31'
        group by website_session_id
        ;
select * from first_pageviews1;

drop table session_w_home_landing_page;
create temporary table session_w_home_landing_page
			select  fp.website_session_id, date(fp.created_at) as created_at,
				fp.pageview_url as landing_page
            from first_pageviews1 as fp    
             join website_sessions ws on ws.website_session_id=fp.website_session_id
            where fp.created_at between '2012-06-01' and '2012-08-31'
            and utm_source='gsearch'
            and utm_campaign= 'nonbrand'
            ;
            
             select * from session_w_home_landing_page;
             
            drop table bounced_session;
            
create temporary table bounced_session
  select swhlp.website_session_id,
		swhlp.landing_page,
        count(wp.website_session_id) as bounced_sessions
   from  session_w_home_landing_page as swhlp
   left join website_pageviews  as wp
   on swhlp.website_session_id = wp.website_session_id
   group by swhlp.website_session_id,
		swhlp.landing_page
  having count(wp.website_session_id)=1;  
  
  select * from bounced_session;
  
  select count(swhlp.website_session_id),
		 count(bs.website_session_id) as bounced_sessions
  from session_w_home_landing_page as swhlp
  left join bounced_session as bs
  on swhlp.website_session_id = bs.website_session_id;
  
  select swhlp.website_session_id,
		 bs.website_session_id as bounced_sessions_id
  from session_w_home_landing_page as swhlp
  left join bounced_session as bs
  on swhlp.website_session_id = bs.website_session_id
  order by swhlp.website_session_id;
  
  select  
         min(swhlp.created_at) as week_start_date,
         count(bs.website_session_id)/count(swhlp.website_session_id) as bounced_rate,
         count(case when swhlp.landing_page='/home' then swhlp.website_session_id else null end) as home_sessions,
          count(case when swhlp.landing_page='/lander-1' then swhlp.website_session_id else null end) as lander_sessions          
         from session_w_home_landing_page as swhlp
         left join bounced_session bs
         on swhlp.website_session_id=bs.website_session_id
         group by swhlp.landing_page, week(swhlp.created_at);
         

         
