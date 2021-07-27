
--	select * from garland.WMS_Address_view  where rownum < 11;

	select distinct zone		from garland.WMS_Address_view;
	select distinct meter		from garland.WMS_Address_view;
	select distinct basin		from garland.WMS_Address_view;
	select distinct grid		from garland.WMS_Address_view;
	select distinct mappage		from garland.WMS_Address_view;

	select count(distinct UMS) 	 UMS			from garland.WMS_Address_view;
	select count(distinct BANNER)  BANNER		from garland.WMS_Address_view;
	select count(distinct pipe_id) pipe_id		from garland.WMS_Address_view;
	select count(distinct sewer)	 sewer		from garland.WMS_Address_view;
	select count(distinct water)	 water		from garland.WMS_Address_view;
	
