--	Processing of unparsed addresses for Sani_Commercial

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
	do_test		number	:= 0;

	app_num		varchar2(20);;
	app_pfx		varchar2(10);
	app_name		varchar2(80);
	app_type		varchar2(10);
	app_sfx		varchar2(10);
	app_code		varchar2(10);
	app_unit		varchar2(10);

	is_unit		number;
	posn_type		number;
	posn_unit		number;
	name_type		varchar2(40);
	name_unit		varchar2(40);
	class_type		varchar2(05);
	class_unit		varchar2(05);

begin

	app_num	:= addr_num;
	app_pfx	:= nvl(rtrim(addr_pfx), ' ');
	app_name	:= nvl(rtrim(addr_name),' ');
	app_type	:= nvl(rtrim(addr_type),' ');
	app_sfx	:= nvl(rtrim(addr_sfx), ' ');
	app_code	:= nvl(rtrim(addr_code),' ');
	app_unit	:= nvl(rtrim(addr_unit),' ');

--	===============================================================================

	if	app_unit > ' '
	and	app_code = ' '		then
		app_code := '#';
	end if;

--	===============================================================================
--	remove address unit or business id from end of the street name

	posn_type := instr (app_name, ' ', -1, 2) + 01;

	if	posn_type > 0		then
		posn_unit := instr (app_name, ' ', -1) + 01;
	else
		goto	terminate;
	end if;

	name_type	:= substr (app_name, posn_type, posn_unit - posn_type - 01);
	name_unit	:= substr (app_name, posn_unit);
	class_type	:= null;
	class_unit	:= null;

begin
	select class
	into	 class_type
	from	 adrItem 
	where  name_type = possible;
exception
	when others then null;
end;

begin
	select class
	into	 class_unit
	from	 adrItem 
	where  name_unit = possible;
exception
	when others then null;
end;

	is_unit := 0;

	if	class_unit is not null		then					--	last word is not adrItem
		null;

	elsif	class_type in ('T', 'D')	then					--	it's preceded by type or suffix
		is_unit := 1;

	elsif	name_unit not in ( '30', '66', '67', '78', '190', '635' )	--	it's not a highway number
	and	translate (name_unit, 'x1234567890', 'x') is null	then	--	but a unit number
		is_unit := 1;

	end if;


	if	do_test > 0		then
		dbms_output.put_line ( 'aaa	name= ' || app_name ||'  posn_unit= '|| posn_unit);
	end if;


	if	is_unit > 0		then							--	remove unit from street name
		app_code := 'STE';
		app_unit := substr (app_name, posn_unit);
		app_name :=	substr (app_name, 01, posn_unit - 1);
	end if;	

	if	do_test > 0		then
		dbms_output.put_line ( 'bbb	name= ' || app_name ||'  posn_unit= '|| posn_unit);
		dbms_output.put_line ( 'ccc	code= ' || app_code ||'  unit= ' || app_unit);
	end if;
	
--	===============================================================================
<<terminate>>

	addr_num	:=     rtrim(ltrim(app_num));
	addr_pfx	:= nvl(rtrim(ltrim(app_pfx)), ' ');
	addr_name	:= nvl(rtrim(ltrim(app_name)),' ');
	addr_type	:= nvl(rtrim(ltrim(app_type)),' ');
	addr_sfx	:= nvl(rtrim(ltrim(app_sfx)), ' ');
	addr_code	:= nvl(rtrim(ltrim(app_code)),' ');
	addr_unit	:= nvl(rtrim(ltrim(app_unit)),' ');

	return;

end;
