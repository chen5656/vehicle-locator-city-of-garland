--	============================================================================
--	Update block side & intersection police districts according to police beat	
--	Beat to District Mapping is obtained by an extract from CDRELPAR
--	==============================================================================

	truncate table	gis_temp4		reuse storage;
	
	insert into gis_temp4	(item01, item02)
	select distinct police_beat, police_district
	from cdrelpar
	where	police_beat > '0'
	and	police_district > '0'
	order by 1,2;

	commit;

--	==============================================================

	update block_side
	set	police_district =
(
	select	item02
	from		gis_temp4
	where		item01 = rtrim(police_beat)
);


	select distinct police_district from block_side;

--	rollback;
	commit;


--	==============================================================

	update intersection
	set	police_district =
(
	select	item02
	from		gis_temp4
	where		item01 = rtrim(police_beat)
);


	select distinct police_district from intersection;

--	rollback;
	commit;


--	==============================================================
