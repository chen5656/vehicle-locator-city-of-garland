--	=====================================================================
set echo		off
set timing		off
set sqlblanklines	on
set serveroutput	on	size 99999
set linesize	2000
set pagesize	9999
--	=====================================================================
--	**************	M O D E L	**************
--	=====================================================================

--	TRUNCATE table garland.GIS_Objects	reuse storage;
--	garland.EXTERNAL_VIEW1		FIRE
--	garland.EXTERNAL_VIEW2		POLICE

--	SPECIFY:	Truncate = yes/no 
--			External_View 1/2 
--			APP = 'FIRE' / 'POLICE'

--	=====================================================================

	create or replace view	garland.Temp_View	as
	select
		item01		app,
		item02		num,
		item03		pfx,
		item04		name,
		item05		typ,
		item06		sfx,
		item07		bldg,
		item08		unit
	from	garland.gis_Objects;

--	=====================================================================
DECLARE
	compile_only		integer 		:= 0;
   	APP				varchar2(10)	:= 'FIRE';

cursor Read_APP		is

	select * from garland.EXTERNAL_VIEW1  
	;

--	=====================================================================

	read_num			adrResult.appl_num%type;	
	read_pfx			adrResult.appl_pfx%type;
	read_name			adrResult.appl_name%type;
	read_typ			adrResult.appl_type%type;
	read_sfx			adrResult.appl_sfx%type;
	read_code1			adrResult.appl_code1%type;
	read_unit1			adrResult.appl_unit1%type;
	read_code2			adrResult.appl_code2%type;
	read_unit2			adrResult.appl_unit2%type;
	parse_method		varchar2(80);

--	=====================================================================
BEGIN

	if	compile_only > 0	then
		return;
	end if;

for adr in Read_APP	Loop

	read_num	:= null;
	read_pfx	:= null;
	read_typ	:= null;
	read_sfx	:= null;
	read_code1	:= null;
	read_unit1	:= null;
	read_code2	:= null;
	read_unit2	:= null;
	read_name	:= adr.ADDRESS;

--	dbms_output.put_line (read_name);
   
	TST_parse_address
	(	read_num,   read_pfx,   read_name,	read_typ,  read_sfx,
		read_code1, read_unit1, read_code2,	read_unit2,	
		parse_method	);

/*
	dbms_output.put_line 
	(	read_num   ||'.'||read_pfx   ||'.'||read_name ||'.'||read_typ ||'.'||read_sfx ||'.'||
		read_code1 ||'.'||read_unit1 ||'.'||read_code2||'.'||	read_unit2		);
	dbms_output.put_line ('-----');
*/

	insert into garland.Temp_View
	values ( app, 	read_num, nvl(read_pfx,' '), read_name, nvl(read_typ,' '), nvl(read_sfx,' '), 
				' ', nvl(read_unit1,' ') );

--				nvl(read_code1,' '), nvl(read_unit1,' ') );
		
end loop;

	COMMIT;

END;

--	=====================================================================
/*

	select 
		rpad(app,10) app,
		rpad(num,20) num, rpad(pfx,20) pfx, rpad(name,20) name, rpad(typ,20) type, rpad(sfx,20) sfx, 
		rpad(bldg,20) bldg, rpad(unit,20) unit 

	from	garland.Temp_View
	where rownum < 111
	order by 1,3,4,2;

	select count(*) from garland.temp_view where app = 'FIRE';
	select count(*) from garland.temp_view where app = 'POLICE';

*/
--	=====================================================================
