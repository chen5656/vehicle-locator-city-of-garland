--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================

--	=====================================================================

--	execute	garland.CCS_LINK_Views

	create or replace procedure garland.CCS_LINK_Views		as

--	DECLARE

--	=====================================================================

	compile_only	integer	:= 0;

	total_processed	integer	:= 0;
	title			varchar2(100);
	heading		varchar2(100);
	script		varchar2(2000);

BEGIN
	if	compile_only > 0		then
		return;
	end if;

	select 'CCS LINK Views   ' into heading from dual; 
	dbms_output.put_line(heading);

--	=================================================================================

	script :=
	'create or replace view garland.Extract1_Address_Keys	as select '
||	'item01 addr_name,'
||	'item02 addr_num,'
||	'item03 addr_type,'
||	'item04 addr_pfx,'
||	'item05 addr_sfx,'
||	'item06 addr_code,'		
||	'item07 addr_bldg,'		
||	'item08 addr_unit,'		
||	'item09 GIS_key,'
||	'item10 TAX_key,'
||	'item11 UMS_key,'
||	'item12 UNIT_key,'
||	'item13 CODE_key,'	
||	'item14 Parcel_ID,'
||	'item15 Source,'
||	'item16 Sequence '
||	'from garland.GIS_Temp1';

	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);

--	=================================================================================

	script :=
	'create or replace view garland.Extract2_Address_Keys	as select '
||	'item01 addr_name,'
||	'item02 addr_num,'
||	'item03 addr_type,'
||	'item04 addr_pfx,'
||	'item05 addr_sfx,'
||	'item06 addr_code,'		
||	'item07 addr_bldg,'		
||	'item08 addr_unit,'		
||	'item09 GIS_key,'
||	'item10 TAX_key,'
||	'item11 UMS_key,'
||	'item12 UNIT_key,'
||	'item13 CODE_key,'	
||	'item14 Parcel_ID,'
||	'item15 Source,'
||	'item16 Sequence '
||	'from garland.GIS_Temp2';

	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);

--	=================================================================================

END;
