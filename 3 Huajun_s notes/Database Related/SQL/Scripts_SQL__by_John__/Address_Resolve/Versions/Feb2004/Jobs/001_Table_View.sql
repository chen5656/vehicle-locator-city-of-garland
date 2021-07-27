	set echo	off;
	set timing	off;
--	=================================================================================================
	select '*** Specify View & Exits ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " " from dual;
--	=================================================================================================
--	SPECIFY APPLICATION NAME (TAX, UMS, CODE, etc)
--	=================================================================================================

	variable	 application_name		varchar2(20);
	execute	:application_name	:= 	''	;  --  SPECIFY

--	=================================================================================================
--	SPECIFY UNPARSED USER EXIT		***   CHOOSE ONE  ***
--	=================================================================================================
	select 'Unparsed Exit' " " from dual;

	@c:\deacutis\scripts\address_resolve\user_exits\01_DEFAULT_UNPARSED_EXIT.sql;	

--	@c:\deacutis\scripts\address_resolve\user_exits\ANIMAL_UNPARSED_EXIT.sql;	

--	@c:\deacutis\scripts\address_resolve\user_exits\MLS_UNPARSED_EXIT.sql;		ERRORS

--	-------------------------------------------------------------------------------------------------
--	SPECIFY PARSED USER EXIT 		***   CHOOSE ONE  ***
--	=================================================================================================
	select 'Parsed Exit' " " from dual;

--	@c:\deacutis\scripts\address_resolve\user_exits\01_DEFAULT_PARSED_EXIT.sql;	

	@c:\deacutis\scripts\address_resolve\user_exits\UMS_PARSED_EXIT.sql;	

--	@c:\deacutis\scripts\address_resolve\user_exits\WATER_PARSED_EXIT.sql;	

--	@c:\deacutis\scripts\address_resolve\user_exits\ANIMAL_PARSED_EXIT.sql;	
--	@c:\deacutis\scripts\address_resolve\user_exits\DCAD_PARSED_EXIT.sql;		ERRORS

--	=================================================================================================
--	SPECIFY APP TABLE VIEW			***   CHOOSE ONE  ***
--	=================================================================================================
	select 'App View' " " from dual;

--	@c:\deacutis\scripts\address_resolve\views\vw_GDS_Account.sql;	

	@c:\deacutis\scripts\address_resolve\views\vw_UMS_LOCATION.sql;	-- excluding bad num format
--	@c:\deacutis\scripts\address_resolve\views\vw_UMS_FOR_WATER.sql;	

--	@c:\deacutis\scripts\address_resolve\views\vw_CODEADDR.sql;			
--	@c:\deacutis\scripts\address_resolve\views\vw_CODEADDR_CONV.sql;			


--	@c:\deacutis\scripts\address_resolve\views\vw_ADRRESULT_APPL.sql;	
--	@c:\deacutis\scripts\address_resolve\views\vw_GIS_OBJECTS.sql;	

--	--------------------------------------------------------------------------------------------------

--	@c:\deacutis\scripts\address_resolve\views\vw_adrRESULT_APPL.sql;		
--	@c:\deacutis\scripts\address_resolve\views\vw_adrRESULT_FORM.sql;		

--	@c:\deacutis\scripts\address_resolve\views\vw_ADDRESS_COMPLEX.sql;	
--	@c:\deacutis\scripts\address_resolve\views\vw_ADDRESS_UNIT.sql;	

--	@c:\deacutis\scripts\address_resolve\views\vw_BLDG_PERMIT.sql;		TIME OUT ERROR

--	@c:\deacutis\scripts\address_resolve\views\vw_DCAD.sql;			ERROR

--	@c:\deacutis\scripts\address_resolve\views\vw_GIS_Objects.sql;		

--	@c:\deacutis\scripts\address_resolve\views\vw_MULTI_FAMILY.sql;	

--	@c:\deacutis\scripts\address_resolve\views\vw_NSA_CODE_INSPECT.sql;	
--	@c:\deacutis\scripts\address_resolve\views\vw_NSA_CRIME.sql;	

--	@c:\deacutis\scripts\address_resolve\views\vw_RENTAL_REGISTRATION.sql;	

--	@c:\deacutis\scripts\address_resolve\views\vw_STREET_SIGN.sql;		

--	@c:\deacutis\scripts\address_resolve\views\vw_TAX.sql;	

--	@c:\deacutis\scripts\address_resolve\views\vw_WATER_METER.sql;		
--	@c:\deacutis\scripts\address_resolve\views\vw_WATER_CUSTODY.sql;		

--	@c:\deacutis\scripts\address_resolve\views\vw_WORKORDER_STREET.sql;		

--	@c:\deacutis\scripts\address_resolve\views\vw_TAX_Commercial.sql;		ERROR
--	@c:\deacutis\scripts\address_resolve\views\vw_TAX_TIF.sql;			ERROR

--	=================================================================================================
--	Describe contents of adrResult (GIS_Verify_Addr)

	select table_name, comments from all_tab_comments where table_name = 'GIS_VERIFY_ADDR';

	spool	c:\deacutis\scripts\EXECUTE.sql
	select '	COMMENT ON TABLE GIS_VERIFY_ADDR IS ''' 	||  
			:application_name					|| ' '  ||
			referenced_name					|| '   '||
			to_char(sysdate,'Mon dd yyyy hh24:mi') 	|| ''';'
	" "	from	all_dependencies
	where	name 			= 'ADRRESULT_USER'
	and	type 			= 'VIEW'
	and	referenced_type	= 'TABLE';
	spool off;
	@c:\deacutis\scripts\EXECUTE.sql

--	select table_name, comments from all_tab_comments where table_name = 'GIS_VERIFY_ADDR';

--	=================================================================================================
--	select * from all_tab_comments	where table_name = 'GIS_VERIFY_ADDR';
--	select * from all_tab_comments	where table_name = 'ADRRESULT_INPUT';
--	select * from all_tab_comments	where table_name = 'ADRRESULT_EXTRACT';
--	=================================================================================================
	set echo	on;
