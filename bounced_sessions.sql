create temporary table first_pageviews
select website_session_id,
		min(website_pageview_id) as min_page_id 
        from website_pageviews
        where created_at <'2012-06-14'
        group by website_session_id
        ;

create temporary table session_w_home_landing_page
			select fp.website_session_id,
				wp.pageview_url as landing_page
            from first_pageviews fp    
            left join website_pageviews wp
            on wp.website_session_id=fp.website_session_id
            where wp.pageview_url='/home';
            
             select * from session_w_home_landing_page;
             
          --  drop table session_w_home_landing_page;
            
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
  
  select count(swhlp.website_session_id) as total_sessions,
		 count(bs.website_session_id) as bounced_sessions,
         count(bs.website_session_id)/count(swhlp.website_session_id) as bounced_rate
         from session_w_home_landing_page as swhlp
         left join bounced_session bs
         on swhlp.website_session_id=bs.website_session_id;
         

         
