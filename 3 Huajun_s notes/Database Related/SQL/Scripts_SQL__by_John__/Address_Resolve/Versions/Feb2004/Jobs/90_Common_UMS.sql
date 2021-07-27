--	set echo	off;
	set timing	off;
--	=================================================================================================
	select '*** Start FULL Run  ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " " from dual;

--	=================================================================================================
	select 'APPLICATION VIEW'	" "	from dual;

	@c:\deacutis\scripts\address_resolve\views\vw_UMS_LOCATION.sql;	-- excluding bad num format

--	=================================================================================================
	select 'ALTERATIONS'	" "	from dual;

	delete from garland.adrAlien	where alias_how <= '9';
	delete from garland.adrAlias	where alias_how <= '9';
	delete from garland.adrAlias	where alias_how  in ('A', 'B', 'C');
	commit;

	@c:\deacutis\scripts\address_resolve\Alteration\COMMON_UMS\Insert_Alias_ABC.sql

	@c:\deacutis\scripts\address_resolve\Alteration\COMMON_UMS\Insert_Alias_NonAdr.sql

	@c:\deacutis\scripts\address_resolve\Alteration\COMMON_UMS\Insert_Alias_NonGar.sql

	@c:\deacutis\scripts\address_resolve\Alteration\COMMON_UMS\Insert_Alias_New.sql

	@c:\deacutis\scripts\address_resolve\tables\adrAlias\bld_adrAlias_Compress.sql;


--	=================================================================================================
	select 'RULES'	" "	from dual;

	@c:\deacutis\scripts\address_resolve\rules\Rules_COMMON_UMS.sql;

--	=================================================================================================
	select 'UNPARSED EXIT'	" "	from dual;

	@c:\deacutis\scripts\address_resolve\user_exits\01_DEFAULT_UNPARSED_EXIT.sql;	

--	=================================================================================================
	select 'PARSED EXIT'	" "	from dual;

	@c:\deacutis\scripts\address_resolve\user_exits\UMS_PARSED_EXIT.sql;	

--	=================================================================================================
	select 'COMMENTS'	" "	from dual;

	comment on table GIS_VERIFY_ADDR IS 	'COMMON UMS';
	select table_name, comments from all_tab_comments where table_name = 'GIS_VERIFY_ADDR';


--	=================================================================================================
	select '*** Start RESOLVE ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;

	set timing	on;
	@c:\deacutis\scripts\address_resolve\package\Batch_Address_Resolve.sql;
	set timing	off;

	select '*** Finish RESOLVE ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;

--	=================================================================================================
	select 'FIXES'	" "	from dual;

	@c:\deacutis\scripts\address_resolve\Fix_adrResult_Show.sql;	--	TEMPORARY FIX	--
	@c:\deacutis\scripts\address_resolve\Fix_adrResult.sql;		--	TEMPORARY FIX	--

--	=================================================================================================
	select 'ANALYZE'	" "	from dual;

	analyze table	garland.gis_verify_addr		compute statistics;

--	=================================================================================================
	select 'REPORTS'	" "	from dual;

 	@c:\deacutis\scripts\address_resolve\50_Base_Report.sql;
	@c:\deacutis\scripts\address_resolve\51_Name_Report.sql;

	@c:\deacutis\scripts\address_resolve\reports\quality_control\QC_Parse_Sample.sql;
	@c:\deacutis\scripts\address_resolve\reports\quality_control\QC_Street_Sample.sql;

	@c:\deacutis\scripts\address_resolve\Parse_Refine_Display.sql;


--	=================================================================================================
	select '*** Finish FULL Run ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " " from dual;
--	=================================================================================================
	set echo 	on;
