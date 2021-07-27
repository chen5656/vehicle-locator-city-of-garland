	set echo		off;
--	========================================================================================
--	create a new address resolve table
--	keep the address scrubbing results of a particular application (UMS, Code, Permit, etc)
--	========================================================================================

--				****   C H A N G E   ****		

	create table	garland.adrResult_VERIZON

--	storage		(initial 100K	next 100K	pctincrease 0)		
--	storage		(initial 2M		next 100K	pctincrease 0)		
--	storage		(initial 1M		next 1M	pctincrease 0)		

	pctfree		05

	tablespace		gis_data
	nologging

	as select all * 	from garland.adrResult;

--	========================================================================
/*
	create index	garland.adrResult_TAX_GDS_AID				-- CHANGE
		on		garland.adrResult_TAX_GDS (segment_id)		-- CHANGE

	storage		(initial 100K	next 100K	pctincrease 0)
--	storage		(initial 1M		next 1M	pctincrease 0)

	tablespace		gisindx
	nologging;

*/	
--	========================================================================================

	select * from user_segments where segment_name	= 'ADRRESULT_VERIZON';	-- CHANGE

	select * from user_tables   where table_name	= 'ADRRESULT_VERIZON';	-- CHANGE
	
--	========================================================================================
	set echo		on;
