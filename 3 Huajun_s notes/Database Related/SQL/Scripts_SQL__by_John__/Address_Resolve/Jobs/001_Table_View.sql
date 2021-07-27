--	=====================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';  
--	=================================================================================================
	select '*** Specify View & Exits ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " " from dual;
--	=================================================================================================
--	SPECIFY APPLICATION NAME (TAX, UMS, CODE, etc)
--	=================================================================================================

	variable	 application_name		varchar2(20);

	execute	:application_name	:= 	'VERIZON_SBC'		--  SPECIFY  <<<<<<<<<<<<<<<<<<<<<<<<<

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

	@c:\deacutis\scripts\address_resolve\user_exits\01_DEFAULT_PARSED_EXIT.sql;	

--	@c:\deacutis\scripts\address_resolve\user_exits\UMS_PARSED_EXIT.sql;	

--	@c:\deacutis\scripts\address_resolve\user_exits\WATER_PARSED_EXIT.sql;	

--	@c:\deacutis\scripts\address_resolve\user_exits\ANIMAL_PARSED_EXIT.sql;	
--	@c:\deacutis\scripts\address_resolve\user_exits\DCAD_PARSED_EXIT.sql;		ERRORS

--	=================================================================================================
--	SPECIFY APP TABLE VIEW			***   CHOOSE ONE  ***
--	=================================================================================================
	select 'App View' " " from dual;

	@c:\deacutis\scripts\address_resolve\views\vw_VERIZON_SBC.sql;

--	@c:\deacutis\scripts\address_resolve\views\vw_GDS_Account.sql;	

--	@c:\deacutis\scripts\address_resolve\views\vw_UMS_LOCATION.sql;	-- excluding bad num format
--	@c:\deacutis\scripts\address_resolve\views\vw_UMS_FOR_WATER.sql;	

--	@c:\deacutis\scripts\address_resolve\views\vw_CODEADDR.sql;			

--	@c:\deacutis\scripts\address_resolve\views\vw_WATER_ALPHA5.sql;		

--	@c:\deacutis\scripts\address_resolve\views\vw_RENTAL_TEEL.sql;	

--	--------------------------------------------------------------------------------------------------

--	@c:\deacutis\scripts\address_resolve\views\vw_GIS_OBJECTS.sql;	
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

--	@c:\deacutis\scripts\address_resolve\views\vw_RENTAL_TEEL.sql;	

--	@c:\deacutis\scripts\address_resolve\views\vw_STREET_SIGN.sql;		

--	@c:\deacutis\scripts\address_resolve\views\vw_TAX.sql;	

--	@c:\deacutis\scripts\address_resolve\views\vw_VERIZON.sql;
--	@c:\deacutis\scripts\address_resolve\views\vw_VERIZON_SBC.sql;

--	@c:\deacutis\scripts\address_resolve\views\vw_WATER_ALPHA5.sql;		
--	@c:\deacutis\scripts\address_resolve\views\vw_WATER_CUSTODY.sql;		

--	@c:\deacutis\scripts\address_resolve\views\vw_WORKORDER_STREET.sql;		

--	@c:\deacutis\scripts\address_resolve\views\vw_TAX_Commercial.sql;		ERROR
--	@c:\deacutis\scripts\address_resolve\views\vw_TAX_TIF.sql;			ERROR

--	=================================================================================================
--	select * from all_tab_comments	where table_name = 'GIS_VERIFY_ADDR';
--	select * from all_tab_comments	where table_name = 'ADRRESULT_INPUT';
--	select * from all_tab_comments	where table_name = 'ADRRESULT_EXTRACT';
--	=================================================================================================
