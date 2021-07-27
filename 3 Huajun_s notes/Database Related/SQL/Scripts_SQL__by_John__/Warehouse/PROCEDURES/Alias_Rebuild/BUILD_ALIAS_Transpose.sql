--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================

--	=====================================================================

--	execute	garland.BUILD_ALIAS_TRANSPOSE

--	create or replace procedure garland.BUILD_ALIAS_TRANSPOSE		AS

	DECLARE

--	=====================================================================

	compile_only	integer	:= 01;

	total_processed	integer	:= 0;
	title			varchar2(100);
	heading		varchar2(100);
	script		varchar2(2000);

BEGIN
	if	compile_only > 0		then
		return;
	end if;

	select 'ALIAS TRANSPOSE  '||to_char(sysdate,'Mon dd hh24:mi') into heading from dual; 
	dbms_output.put_line(heading);

--	=========================================================================================   
--	VALID NAMES THAT TRANSPOSE INTO VALID NAMES
--	FOR ALTERNATIVE POSSIBILITIES ONLY	
--	NOT FOR ADDRESS CORRECTION !!   

--	Example:	Woodhaven / Havenwood

	insert into garland.adrAlias

	select 	distinct
		'*',
		a.addr_name,					
		'*',
		'*',
		01,999999,0,
		'',
		b.addr_name,
		'',
		'',
		'trans',
		' ', ' ', ' '
		,001
		,0				-- alias_match		nov 2003
		,0				-- alias_priority		dec 2004

	from	garland.adrStreets		a,
		garland.adrStreets		b

	where	a.addr_begin	like '%' || b.addr_ending
	and	a.addr_ending	like b.addr_begin || '%'
	and	rtrim(a.addr_begin)  is not null
	and	rtrim(b.addr_ending) is not null
	;

--	=========================================================================================   

	COMMIT;

END;

