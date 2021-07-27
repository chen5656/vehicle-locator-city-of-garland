--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	400;
set pagesize	9999;
-- set pagesize	74;
-- set pagesize	57;
-- alter session set nls_date_format = 'yyyymmdd hh24:mi:ss';  
--	============================================================================
--	ORACLE online documentation:   
--	App Development Guide	Chap 6:  "Coding Dynamic SQL Statements"
--	"Referencing Database Objects that Do Not Exist at Compilation"
--	============================================================================

DECLARE

	inName	varchar2(100)	:= 'JUPITER';
	inPfx		varchar2(100)	:= 'N';
	outName	varchar2(100);
	mesg		varchar2(100);

	query1	varchar2(1000) :=  'select addr_name from garland.adrStreets where addr_name = :z1 and addr_pfx = :z2';
	query2	varchar2(1000) :=  'select addr_type from garland.CDRELADR where addr_name = :z1';
	query3	varchar2(1000) :=  'select addr_type, :z1 from garland.CDRELADR where addr_name = :z2';

	type	cursory is REF Cursor;
	cur	cursory;

BEGIN

	open Cur for Query1 using InName, 'N';

LOOP

	fetch cur into outName;
	exit when cur%notfound;

	dbms_output.put_line ( InPfx  ||' '||  outName );

END LOOP;

	close Cur;

	open cur for Query2 using InName;
	close cur;

	open cur for Query3 using 'hello world', InName;
	fetch cur into mesg, outName;

	dbms_output.put_line ( mesg  ||' '||  outName );

END;

--	============================================================================
/*

	Use different QUERIES with different COLUMNS for same Cursor (polymorphic)
	

*/
--	============================================================================

