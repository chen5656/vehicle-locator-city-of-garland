	set echo	off;
--------------------------------------------------		
--	update regions in CDRELPAR
--	using ESRI extract on gis_objects
---------------------------------------------------		

	update cdrelpar			p
	set 
(		council_id,		
		police_beat,		
		police_district,	
		fire_district,	
		animal_control,	
		code_inspect_area 	)
	=
(
		select item02, item03, item04, item05, item06, item07
		from	gis_objects		o
		where	p.parcel_id	= o.item01
)

	where exists
(
		select 'x'
		from	gis_objects	
		where	p.parcel_id	= item01
)


--	and	parcel_id < '03'			-- TEST
	;
	
---------------------------------------------------		

	select council_id, police_beat, police_district, fire_district, animal_control, code_inspect_area
	from	cdrelpar
	where	parcel_id < '03';

	select item02, item03, item04, item05, item06, item07
	from	gis_objects
	where	item01 < '03';

---------------------------------------------------		

	rollback;
--	commit;


--	desc cdrelpar;

	set echo	on;
