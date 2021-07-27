
	create or replace	view		tmp_view

	(	key_,		 type_,	schema_,	 prefix_,	suffix_,	 tablespace_,   
		initial_,	 next_,	maxextents_, maxtrans_, pctfree_,	 pctused_, 	
		option1_,	 option2_,	dblink_	
	) 

	as 	select
		item01,	item02,	item03,	item04,	item05,	 item06,
		item07,	item08,	item09,	item10,	item11,	 item12,	
		item13,	item14,	item15

	from	garland.gis_objects;

--	option1 = 'drop'
--	option2 = 

