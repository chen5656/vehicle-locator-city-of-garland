--	=====================================================================
	select * from viewer.me;
--	BEGIN  TEST TEST TEST TEST TEST  TEST TEST TEST TEST TEST  TEST TEST TEST TEST TEST  END;
set	TIMING		OFF;
set	sqlblanklines	on;
set	serveroutput	on	size 99999;
set	linesize		1000;
set	pagesize		0000;
--	execute jdeacutis.show_table_column	('temp_view', 'jdeacutis', '');
--	execute jdeacutis.show_source		('test_proc', 'jdeacutis', '');
--	execute jdeacutis.show_error		('test_proc', 'jdeacutis', '');
--	execute jdeacutis.show_view		('', '', '');
--	execute jdeacutis.show_index_column	('', '', '');
--	SELECT  to_char(sysdate,'Mon dd,yyyy hh24:mi')||'  ***  ' " "  from dual;
--	EXECUTE jdeacutis.TEST_PROC;
--	CREATE or replace procedure jdeacutis.TEST_PROC  as
--	DECLARE
--	=====================================================================	

--	========================================================================================
--	Prepare spreadsheet that contains GIS Address, DCAD number, and UMS Tenant
--	Source = CCS_ADDRESSES giving GIS or TAX Address
--	If UMS Tenant does not exist, then provide TAX owner
--	========================================================================================

--	select 'Seq;Parcel;Num;Pre;Name;Type;Suf;DCAD;Tenant;GIS;TAX;CUS'	" " from dual	union all

--	=====================================================================
/*
	Truncate table 	jdeacutis.CCS_Address_ODT;

	Insert --+ append
	into	jdeacutis.CCS_Address_ODT
	select * from 	garland.CCS_Address_INFOSTRAT
	order by addr_name, addr_type, addr_prefix, addr_suffix, addr_number ;
	Commit;
*/
--	=====================================================================

	TRUNCATE table	jdeacutis.gis_Objects;

--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan set	statement_id = 'x'	into jdeacutis.plan_table for
--	=====================================================================

--	select count(*) from

	INSERT --+ append
	into	jdeacutis.Temp_View
(
	select 
		seq,		
		parcel_id,	
		addr_number,  addr_prefix,  addr_name,  addr_type,  addr_suffix,	
--		addr_zip,	
		tax_dcad,			
		tenant,	
		nvl(address_id,0),			
		to_number(nvl(tax_id,0)),	
		nvl(UMS_id,0)			
	" "
	from
(
	select rownum seq, LIST.* from
(
	select 
		min(parcel_id)   					Parcel_ID,
		addr_Number, addr_Prefix, addr_Name, addr_Type, addr_Suffix,
		min(DCAD_ID) 						Tax_DCAD,
		min(decode(nvl(umsACCT_id,0), 0,tax_owner, ltrim(rtrim(ums_first_name ||' '|| ums_last_Name))))		Tenant,
		min(nvl(address_id,0))					Address_ID,
		min(to_number(nvl(tax_id,0))) 				Tax_ID,
		min(nvl(umsACCT_id,0)) 					UMS_ID			

	from	jdeacutis.CCS_ADDRESS_ODT
	where	TAX_ID > 0
	and	nvl(ADDRESS_id,0) + nvl(ROAD_id,0) > 0
	group by addr_name, addr_number, addr_type, addr_prefix, addr_suffix
)		LIST
));

	COMMIT;

--	=====================================================================
--	select * from jdeacutis.explain_Plan;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================
