	set echo	off;
	set timing	off;
	set linesize	2000;
	set pagesize	999;
	set sqlblanklines	on;
--	=================================================================================================
	select '*** Start FULL Run  ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " " from dual;

--	=================================================================================================
	select 'ALTERATIONS'	" "	from dual;

	delete from garland.adrAlien	where alias_how <= '9';
	delete from garland.adrAlias	where alias_how <= '9';
	delete from garland.adrAlias	where upper(alias_how)  in ('A', 'B', 'C');
	commit;

	set echo	on;

	@c:\deacutis\scripts\address_resolve\Alteration\COMMON_UMS\Insert_Alias_ABC.sql

	@c:\deacutis\scripts\address_resolve\Alteration\COMMON_UMS\Insert_Alias_NonAdr.sql

	@c:\deacutis\scripts\address_resolve\Alteration\COMMON_UMS\Insert_Alias_NonGar.sql

	@c:\deacutis\scripts\address_resolve\Alteration\COMMON_UMS\Insert_Alias_New.sql

	set echo	off;

	@c:\deacutis\scripts\address_resolve\tables\adrAlias\bld_adrAlias_Compress.sql;

--	=================================================================================================
	select 'APPLICATION VIEW'	" "	from dual;
	select 'LOAD TABLE'		" "	from dual;

	@c:\deacutis\scripts\address_resolve\views\vw_GDS_ACCOUNT.sql;	

	@c:\deacutis\scripts\address_resolve\jobs\002_LOAD_TABLE.sql;	

--	=================================================================================================
	select 'RULES'	" "	from dual;

	@c:\deacutis\scripts\address_resolve\rules\Rules_COMMON_TAX.sql;

--	=================================================================================================
	select 'UNPARSED EXIT'	" "	from dual;
	select 'PARSED EXIT'	" "	from dual;

--	EXECUTE EACH OF THESE SEPARATELY

--	@c:\deacutis\scripts\address_resolve\user_exits\01_DEFAULT_UNPARSED_EXIT.sql;	

--	@c:\deacutis\scripts\address_resolve\user_exits\01_DEFAULT_PARSED_EXIT.sql;	

--	=================================================================================================
	select '*** Start RESOLVE ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;

	set timing	on;
	@c:\deacutis\scripts\address_resolve\package\Batch_Address_Resolve.sql;
	set timing	off;

	select '*** Stop RESOLVE ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;

--	=================================================================================================
	select 'FIXES'	" "	from dual;

	@c:\deacutis\scripts\address_resolve\Fix_adrResult_Show.sql;	
	@c:\deacutis\scripts\address_resolve\Fix_adrResult.sql;		

--	=================================================================================================
	select 'ANALYZE'	" "	from dual;

	analyze table	garland.gis_verify_addr		compute statistics;

--	=================================================================================================
	select 'REPORTS'	" "	from dual;

-- 	@c:\deacutis\scripts\address_resolve\50_Base_Report.sql;
--	@c:\deacutis\scripts\address_resolve\51_Name_Report.sql;

--	@c:\deacutis\scripts\address_resolve\reports\quality_control\QC_Parse_Sample.sql;
--	@c:\deacutis\scripts\address_resolve\reports\quality_control\QC_Street_Sample.sql;

--	@c:\deacutis\scripts\address_resolve\Parse_Refine_Display.sql;

--	=================================================================================================
--	Copy adrResult to adrResult_TAX_GDS

	truncate table	garland.adrResult_TAX_GDS	reuse storage;

	insert --+ append
	into	 garland.adrResult_TAX_GDS
	select * from garland.adrResult;

	analyze table	garland.adrResult_TAX_GDS	compute statistics;

--	=================================================================================================
	select 'COMMENTS'	" "	from dual;

	comment on table GIS_VERIFY_ADDR IS	'adrResult_TAX_GDS';

	select table_name, comments from all_tab_comments where table_name = 'GIS_VERIFY_ADDR';

	select table_name, comments from all_tab_comments where table_name = 'ADRRESULT_TAX_GDS';

--	=================================================================================================
	select '*** Stop FULL Run ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " " from dual;
--	=================================================================================================
	set echo on;
