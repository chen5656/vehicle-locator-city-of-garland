	
--	Default processing of unparsed addresses

	create or replace procedure	garland.adr_Resolve_Unparsed_Exit
(
	addr_num		in out	varchar2,
	addr_pfx		in out	varchar2,
	addr_name		in out	varchar2,
	addr_type		in out	varchar2,
	addr_sfx		in out	varchar2,

	addr_code1		in out	varchar2,
	addr_unit1		in out	varchar2,
	addr_code2		in out	varchar2,
	addr_unit2		in out	varchar2,

	addr_parse		in out	varchar2,
	addr_verify		in out	number
)
as

	app_num		varchar2(20);
	app_pfx		varchar2(20);
	app_name		varchar2(80);
	app_type		varchar2(20);
	app_sfx		varchar2(20);

	app_code1		varchar2(20);
	app_unit1		varchar2(20);
	app_code2		varchar2(20);
	app_unit2		varchar2(20);

	app_parse		varchar2(80);
	app_verify		number;

begin

	app_num	:= addr_num;
	app_pfx	:= addr_pfx;
	app_name	:= ' ' || addr_name || ' ';
	app_type	:= addr_type;
	app_sfx	:= addr_sfx;

	app_code1	:= addr_code1;
	app_unit1	:= addr_unit1;
	app_code2	:= addr_code2;
	app_unit2	:= addr_unit2;

	app_parse	:= addr_parse;
	app_verify	:= addr_verify;

--	===============================================================================

	if	app_sfx in ( 'N', 'S', 'E', 'W', 'NE', 'NW', 'SE', 'SW', 'NO', 'SO' )	then
		null;
	elsif	' ' || app_name	not like '% AVE%'		then
		app_sfx := ' ';
	end if;

	if	app_name like ' ____________________00 '	then		
		app_name := rtrim (app_name, '0 ');
	end if;

	if	app_name || ' ' like '%(PVT)%'		then
		app_name := replace (app_name, '(PVT)');
	end if;

	if	app_unit1 > ' '
	and	app_code1 = ' '		then
		app_code1 := '#';
	end if;

--	===============================================================================

	addr_num	:=     rtrim(ltrim(app_num  ));
	addr_pfx	:= nvl(rtrim(ltrim(app_pfx  )),' ');
	addr_name	:= nvl(rtrim(ltrim(app_name )),' ');
	addr_type	:= nvl(rtrim(ltrim(app_type )),' ');
	addr_sfx	:= nvl(rtrim(ltrim(app_sfx  )),' ');

	addr_code1	:= nvl(rtrim(ltrim(app_code1)),' ');
	addr_unit1	:= nvl(rtrim(ltrim(app_unit1)),' ');
	addr_code2	:= nvl(rtrim(ltrim(app_code2)),' ');
	addr_unit2	:= nvl(rtrim(ltrim(app_unit2)),' ');

	addr_parse	:= app_parse;
	addr_verify := app_verify;

	return;

end;

