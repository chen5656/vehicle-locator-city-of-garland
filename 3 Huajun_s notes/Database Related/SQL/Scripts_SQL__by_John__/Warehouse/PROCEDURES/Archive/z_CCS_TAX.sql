--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	2000;
set pagesize	9999;
--	=====================================================================

--	execute	garland.CCS_TAX;

	create or replace procedure garland.CCS_TAX		as

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

--	=================================================================================
	title := '***  CCS TAX ***  ';
	dbms_output.put_line(title);
--	=================================================================================

--	=================================================================================
--	Prepare TAX input
--	===========================================================================

--	script := 
--	'create or replace view	garland.Temp_View1 (account,attn,name,unit,strt,city,state,cast,error) '	||
--	'as select item01,item02,item03,item04,item05,item06,item07,item08,item09 from garland.GIS_Temp1'; 
--	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);

	script := 'Truncate table garland.GIS_App_Rowid	reuse storage';
	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);

	insert --+ append
	into	garland.GIS_App_Rowid
	select rownum,  rec_rowid
	from		(
	select account, rowid rec_rowid
	from	 garland.GDS_Account
	order by 1	);

	total_processed := sql%rowcount;
	dbms_output.put_line ( 'App RowID Total ' || total_processed );

	COMMIT;

	DBMS_UTILITY.EXEC_DDL_STATEMENT ('analyze table GARLAND.GIS_APP_ROWID compute statistics');

--	===========================================================================
--	EXECUTE TAX PROCESSES

	garland.CCS_TAX_FORMAT_OWNER;

	garland.CCS_TAX_BUILD_EXEMPTION;

	garland.CCS_TAX_BUILD_COMMON_TAX;

--	garland.CCS_TAX_BLOCK_LOT;

--	===========================================================================

END;


