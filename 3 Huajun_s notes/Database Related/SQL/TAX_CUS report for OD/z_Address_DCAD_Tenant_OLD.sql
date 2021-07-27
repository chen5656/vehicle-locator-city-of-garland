--	=====================================================================
	select * from viewer.me;
--	BEGIN  TEST TEST TEST TEST TEST  TEST TEST TEST TEST TEST  TEST TEST TEST TEST TEST  END;
set	TIMING		OFF;
set	sqlblanklines	on;
set	serveroutput	on	size 99999;
set	linesize		1000;
set	pagesize		0000;
--	execute jdeacutis.show_table_column	('', '', '');
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


--	=====================================================================
	truncate table	jdeacutis.plan_table	reuse storage;
	explain plan set	statement_id = 'x'	into jdeacutis.plan_table for
--	=====================================================================

	select count(*) from (

	select 'Parcel;Num;Pre;Name;Type;Suf;DCAD;Tenant;GIS;TAX;CUS'	" " from dual
	union all

	select 
		seq		||';'||
		parcel_id	||';'||
		addr_number ||';'|| addr_prefix ||';'|| addr_name ||';'|| addr_type ||';'|| addr_suffix	||';'||
--		addr_zip	||';'||
		tax_dcad	||';'||		
		tenant	||';'||
		nvl(address_id,0)			||';'||
		to_number(nvl(tax_id,0))	||';'||
		nvl(ums_id,0)			||';'			

	" "
	from
(
	select rownum seq, LIST.* from
(
	select 
		min(parcel_id)						parcel_id,
			addr_number, addr_prefix, addr_name, addr_type, addr_suffix,
		min(tax_dcad) 						tax_dcad,
		min(decode(nvl(ums_id,0), 0, 				tax_owner, 
		ltrim(ums_first_name ||' '|| ums_last_Name))) 	tenant,
		min(nvl(address_id,0))					address_id,
		min(to_number(nvl(tax_id,0))) 			tax_id,
		min(nvl(ums_id,0)) 					ums_id			
	from garland.CCS_ADDRESS
	where	tax_id > 0
	and	nvl(address_id,0) + nvl(block_id,0) > 0
	group by addr_name, addr_number, addr_type, addr_prefix, addr_suffix
)		LIST
)
)
;

--	=====================================================================
	select * from jdeacutis.explain_Plan;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================
