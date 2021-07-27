
--	Code Enforce processing of unparsed addresses

	create or replace procedure	garland.adr_Resolve_Unparsed_Exit
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

--	===============================================================================

	if	app_sfx in ( 'N', 'S', 'E', 'W', 'NE', 'NW', 'SE', 'SW', 'NO', 'SO' )	then
		null;
	elsif	' ' || app_name	not like '% AVE%'		then
		app_sfx := ' ';
	end if;

	if	app_name like '____________________00'	then
		app_name := rpad (app_name, 20);
	end if;

	if	app_name || ' ' like '%(PVT)%'		then
		app_name := replace (app_name, '(PVT)');
	end if;

	if	app_unit in ( 'OFC', 'UNIT', 'OFFI', 'SUIT')	THEN
		app_unit := ' ';
	end if;

	if	app_unit >= '0'
	and	app_code  = ' '		then
		app_code := '#';
	end if;

--	===============================================================================

	addr_num	:=     rtrim(ltrim(app_num));
	addr_pfx	:= nvl(rtrim(ltrim(app_pfx)), ' ');
	addr_name	:= nvl(rtrim(ltrim(app_name)),' ');
	addr_type	:= nvl(rtrim(ltrim(app_type)),' ');
	addr_sfx	:= nvl(rtrim(ltrim(app_sfx)), ' ');
	addr_code	:= nvl(rtrim(ltrim(app_code)),' ');
	addr_unit	:= nvl(rtrim(ltrim(app_unit)),' ');

	return;

end;

