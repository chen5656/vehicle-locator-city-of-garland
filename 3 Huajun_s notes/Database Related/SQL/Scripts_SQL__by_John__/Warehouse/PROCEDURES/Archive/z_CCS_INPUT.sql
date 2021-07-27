--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	2000;
set pagesize	9999;
--	=====================================================================
--	INPUT GDS_INPUT CCS Input

--	Accounts@gdstax			 83,000
--	ExemptionRecords@gdstax		333,000
--	TaxRecords@gdstax			720,000

--	=====================================================================

--	execute	garland.CCS_INPUT;

	create or replace procedure	garland.CCS_INPUT		As

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

	select '*** CCS INPUT  ***  ' into heading from dual; 
	dbms_output.put_line(heading);

--	=====================================================================

	garland.CCS_INPUT_GDS_ACCOUNT;

	garland.CCS_INPUT_GDS_EXEMPTION;	

	garland.CCS_INPUT_GDS_YEAR;

--	=====================================================================

END;
