
--	================================================================================
--	get coordinates from download of parcel_xy created by arcview	(gis_objects)
--	put 1 parcel-xy record for each distinct parcel id			(gis_specs)
--	some parcel ids occur more than once, so take the one with the minimum row id

	truncate table	gis_specs	reuse storage;

	alter rollback segment	rb_large		online;
	set transaction	use rollback segment	rb_large;

	truncate table	plan_table;
	explain plan	set statement_id = 'test'	for

	insert into gis_specs	(spec01, spec02, spec03)
	(
		select	item01, item02, item03
		from		gis_objects
		where		rowid in
		(	
			select	min(rowid)
			from		gis_objects
			group by	item01
		)
	);

	@c:\deacutis\scripts\plans\exhibit.sql;

	commit;
	alter rollback segment	rb_large		offline;

--	================================================================================
--	update arcview coordinates in cdrelpar
--	obtain coordinates for unique parcel ids from gis_specs

	alter rollback segment	rb_large		online;
	set transaction	use rollback segment	rb_large;

	truncate table	plan_table;
	explain plan	set statement_id = 'test'	for

	update cdrelpar		p
	set	( arcview_x, arcview_y ) = 
(
	select	to_number (rtrim(s.spec02), '9999999.99999'),
			to_number (rtrim(s.spec03), '9999999.99999')
	from		gis_specs		s
	where		s.spec01 = p.parcel_id
);
	
	@c:\deacutis\scripts\plans\exhibit.sql;

	commit;
	alter rollback segment	rb_large		offline;

--	================================================================================
