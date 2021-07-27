	set echo off;
--	===================================================================
--	Backup Code District New

	Truncate table	garland.GIS_Temp1		reuse storage;

	insert --+ append
	into	 garland.GIS_Temp1  (	item01, item02, item03, item04, item05, item06, 
						item07, item08, item09, item10, item11	)
	select * from garland.Code_District_New;

	commit;
	
--	===================================================================
--	Load Code District New 

	truncate table	garland.Code_District_New		reuse storage;

	insert --+ append
	into	garland.Code_District_New 


	select	item01, 					-- parcel
			item02, item03, item04,			-- nuisance
			item05, item06, item07,			-- rental
			item08,					-- rental switch
			null, null, null				-- regions

	from	garland.GIS_Objects
	where	item10 = 'x'
	order by item01;

	Commit;

--	===================================================================

	select * from garland.Code_District_New		where rownum < 22;

--	===================================================================
	set echo on;

