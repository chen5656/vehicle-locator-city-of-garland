--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================

--	execute	garland.CCS_LINK_Build_Record_Seq

	create or replace procedure garland.CCS_LINK_Build_Record_Seq	as

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

	select 'CCS LINK Build Record Seq   ' into heading from dual; 
	dbms_output.put_line(heading);

--	=================================================================================

	script := 'Truncate table garland.COMMON_RECORD_SEQ	reuse storage';	
	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);

--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table	for
--	=================================================================================

	insert --+ append 								
	into	 garland.COMMON_RECORD_SEQ
(
		 gis_key
		,tax_key
		,ums_key
		,sequence
)
(
	select nvl(gis_key,0), 
		 nvl(tax_key,0), 
		 nvl(ums_key,0),	
		 highest + seq
	from
(
	select gis_key, tax_key, ums_key, 
		 rownum					Seq
	from	garland.COMMON_ADDRESS_KEYS		KKK	
	where	not exists
(
	select 'x'
	from	garland.COMMON_RECORD_SEQ		KK
	where	kk.gis_key	= nvl(to_number(kkk.gis_key),0)
	and	kk.tax_key	= nvl(to_number(kkk.tax_key),0)
	and	kk.ums_key	= nvl(to_number(kkk.ums_key),0)
))								K,
(
	select nvl(max(Sequence),0)			Highest
	from	garland.COMMON_RECORD_SEQ		
)								S
)
	order by 1,2,3;

	total_processed := sql%rowcount;
	dbms_output.put_line ( 'Record Seq total = ' || total_processed);

	COMMIT;

--	=================================================================================
--	select * from garland.explain_Plan;
--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Column;
--	select * from garland.explain_Analyze;
--	=================================================================================

	script := 'analyze table garland.COMMON_RECORD_SEQ compute statistics';
	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);

--	=================================================================================

END;
