--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	2000;
set pagesize	9999;
--	=====================================================================

	create or replace procedure garland.Test_Proc 
		( tablename varchar2, columnnames varchar2, columnvalues varchar2 )  
	AS

--	DECLARE

	compile_only		integer	:= 0;

	table_name			varchar2(200)	:=	'garland.GIS_OBJECTS';
	column_names		varchar2(200)	:=	'ITEM01, ITEM02, ITEM03';
	column_values		varchar2(200)	:=	'''JOHN'', ''ALBERT'', ''DEACUTIS''';

	script			varchar2(200);

BEGIN

	if	compile_only > 0	then
		return;
	end if;

	table_name		:= tablename;
	column_names	:= columnnames;
	column_values	:= columnvalues;

	script := ' Insert into ' || table_name|| '( ' || column_names || ') values ('  || column_values || ')';

	dbms_output.put_line ( 'Script: ' || script );

	execute immediate script;

END;

--	=====================================================================
/*

	execute garland.Test_Proc 
	(
	 	'garland.GIS_OBJECTS', 
		'ITEM01, ITEM02, ITEM03', 
		'''JOHN'', ''ALBERT'', ''DEACUTIS''' 
	);

	select rpad(item01,20), rpad(item02,20), rpad(item03,20)  
	from	garland.GIS_OBJECTS
	where	item01 = 'JOHN'
	;

*/
--	=====================================================================
