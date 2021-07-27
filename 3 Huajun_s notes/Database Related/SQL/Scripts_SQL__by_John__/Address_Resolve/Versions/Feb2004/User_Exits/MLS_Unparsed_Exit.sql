
	set echo	off;

--	Default processing of unparsed addresses

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
	app_name	:= ' ' || addr_name || ' ';

	app_pfx	:= ltrim(rtrim(addr_pfx ));
	app_type	:= ltrim(rtrim(addr_type));
	app_sfx	:= ltrim(rtrim(addr_sfx ));
	app_code	:= ltrim(rtrim(addr_code));
	app_unit	:= ltrim(rtrim(addr_unit));

--	===============================================================================

	if	app_name || ' ' like '% PVT %		'	then
		app_name := replace (app_name, ' PVT');
	end if;

	app_name	:= translate (app_name, 'x*!-',   'x');

	app_name	:= replace	 (app_name, ' HUD ',  ' ');
	app_name	:= replace	 (app_name, ' CSS ',  ' ');
	app_name	:= replace	 (app_name, ' BONUS ',' ');

	if	app_unit > ' '
	and	app_code is null		then
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
