
drop table first_pageviews1;

create temporary table first_pageviews1
select website_session_id,
		min(website_pageview_id) as min_page_id ,
        pageview_url
        from website_pageviews
        where created_at <'2012-07-28'
        group by website_session_id
        ;
select * from first_pageviews1;

drop table session_w_home_landing_page;
create temporary table session_w_home_landing_page
			select fp.website_session_id,
				fp.pageview_url as landing_page
            from first_pageviews1 as fp    
             join website_sessions ws on ws.website_session_id=fp.website_session_id
            where fp.min_page_id > 23504
            and utm_source='gsearch'
            and utm_campaign= 'nonbrand';
            
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
  
  select swhlp.landing_page,
         count(swhlp.website_session_id) as total_sessions,
		 count(bs.website_session_id) as bounced_sessions,
         count(bs.website_session_id)/count(swhlp.website_session_id) as bounced_rate
         from session_w_home_landing_page as swhlp
         left join bounced_session bs
         on swhlp.website_session_id=bs.website_session_id
         group by swhlp.landing_page;
         

         
