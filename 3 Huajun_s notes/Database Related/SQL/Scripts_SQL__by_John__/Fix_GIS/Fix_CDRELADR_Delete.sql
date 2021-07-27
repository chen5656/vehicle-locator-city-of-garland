	set echo	off;
--	===========================================================================
--	Delete from cdreladr records that match gis_objects
--	==============>>>>>>>	check ROLLBACK at bottom	<<<<<================
--	===========================================================================
--	truncate table	garland.gis_objects	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	explain plan set statement_id =	'xxx'		into garland.plan_table	for
--	===========================================================================

--	select count(*)	

	delete
	from garland.cdreladr	a
	where	
(
	 rtrim(mslink) 
	,parcel_id  
	,rtrim(nvl(addr_num,0))  
	,addr_pfx 
	,addr_name 
	,addr_type 
--	,addr_sfx
)
	in
(
	select item01 				-- mslink
		,nvl(item02,' ')  		-- parcel id
		,nvl(item03,'0') 			-- addr num
		,nvl(item04,' ') 			-- addr pfx
		,nvl(item05,' ') 			-- addr name
		,nvl(item06,' ') 			-- addr type
--		,nvl(item07,' ')			-- addr sfx

	from	 garland.gis_objects
	where	 item01 = rtrim(a.mslink)
);

--	===========================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_constraint;
--	select * from garland.explain_column;
--	select * from garland.explain_analyze;

	ROLLBACK;
	commit;

	alter rollback segment rb1 offline;

--	===========================================================================
/*
	5100106.000,419,,GAUTNEY,ST,,23173
	5100106.000,421,,GAUTNEY,ST,,23174
	5100107.000,425,,GAUTNEY,ST,,23177
	5100107.000,427,,GAUTNEY,ST,,23178
*/
--	===========================================================================
