	set echo 	off;
	set timing	off;
--	=================================================================================================
--	Define adrResult_Local  as adrResult_Source
--	=================================================================================================

	drop synonym	garland.adrResult;
	create synonym	garland.adrResult		for garland.GIS_Verify_Addr;

--	=================================================================================================

	@c:\deacutis\scripts\address_resolve\views\adrResult_Source.sql;	
	@c:\deacutis\scripts\address_resolve\views\adrResult_vw.sql;	
	@c:\deacutis\scripts\address_resolve\views\adrAlter_vw.sql;	

--	=================================================================================================

--	select * from all_tab_comments	where table_name = 'GIS_VERIFY_ADDR';
--	select * from all_tab_comments	where table_name = 'ADRRESULT_INPUT';
--	select * from all_tab_comments	where table_name = 'ADRRESULT_EXTRACT';

--	=================================================================================================

	truncate table	garland.adrResult_Input		reuse storage;

--	alter rollback segment rb1 online;
--	commit;		
--	set transaction use rollback segment rb1;

	insert --+ append
	into	garland.adrResult_Input
	select all *  
	from 	garland.adrResult_Source;

	commit;		
--	alter rollback segment rb1 offline;

--	=================================================================================================
	select '*** Set App RowID ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;

	@c:\deacutis\scripts\address_resolve\12_App_Rowid.sql;

	select '*** Finished ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;

--	===================================================================================
	set echo	on;
	set timing	off;
