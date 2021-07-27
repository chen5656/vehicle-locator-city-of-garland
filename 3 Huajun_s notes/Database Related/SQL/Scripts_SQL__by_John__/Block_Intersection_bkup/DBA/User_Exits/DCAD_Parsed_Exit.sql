
--	special processing of parsed DCAD Tax addresses


	create or replace procedure	garland.adr_Resolve_Parsed_Exit
(
	addr_num		in out	varchar2,
	addr_pfx		in out	varchar2,
	addr_name		in out	varchar2,
	addr_type		in out	varchar2,
	addr_sfx		in out	varchar2,
	addr_code		in out	varchar2,
	addr_unit		in out	varchar2
)
as
	app_num		varchar2(20);;
	app_pfx		varchar2(10);
	app_name		varchar2(40);
	app_type		varchar2(10);
	app_sfx		varchar2(10);
	app_code		varchar2(10);
	app_unit		varchar2(10);

begin

	app_num	:= addr_num;
	app_pfx	:= nvl(rtrim(addr_pfx), ' ');
	app_name	:= nvl(rtrim(addr_name),' ');
	app_type	:= nvl(rtrim(addr_type),' ');
	app_sfx	:= nvl(rtrim(addr_sfx), ' ');
	app_code	:= nvl(rtrim(addr_code),' ');
	app_unit	:= nvl(rtrim(addr_unit),' ');

--	===================================================================

--	example: "901 O Henry" may have parsed as "901 Henry #O"

	if	app_unit  = 'O'			then
		app_name := 'O ' || app_name;
		app_unit := null;
	end if;


--	example: "901 Avenue E" may have parsed as "901 Avenue #E"

	if	app_name in ( 'AVENUE', 'AVE' )
	and	app_unit between 'A' and 'Z'		then
		app_name := 'AVENUE ' || app_unit;
		app_unit := null;
	end if;

--	===================================================================
--	extract placed the prefix after the street name
--	move suffix into prefix

	if	app_sfx in ('N', 'S', 'E', 'W')	
	and	nvl(app_pfx,' ') = ' '				then
		app_pfx	:= app_sfx;
		app_sfx	:= ' ';
	end if;

--	example: "901 State Hwy 78"	

	if	app_unit	in ( '30', '66', '67', '78', '190', '635' )		then
		app_name	:= app_name ||' '|| app_unit;
 		app_unit := null;
	end if;

--	===================================================================

	addr_num	:=     rtrim(ltrim(app_num));
	addr_pfx	:= nvl(rtrim(ltrim(app_pfx)), ' ');
	addr_name	:= nvl(rtrim(ltrim(app_name)),' ');
	addr_type	:= nvl(rtrim(ltrim(app_type)),' ');
	addr_sfx	:= nvl(rtrim(ltrim(app_sfx)), ' ');
	addr_code	:= nvl(rtrim(ltrim(app_code)),' ');
	addr_unit	:= nvl(rtrim(ltrim(app_unit)),' ');

	return;

--	===================================================================

end;
