--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
-- alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';
--	================================================================

--	drop procedure	garland.SCRUB_ADDRESS_PARSED;

	create or replace procedure	garland.SCRUB_ADDRESS_PARSED
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

	addr_parse		out		varchar2,
	addr_verify		out		number
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
	app_name	:= addr_name;
	app_type	:= addr_type;
	app_sfx	:= addr_sfx;

	app_code1	:= addr_code1;
	app_unit1	:= addr_unit1;
	app_code2	:= addr_code2;
	app_unit2	:= addr_unit2;

	app_parse	:= null;		
	app_verify	:= null;
--	app_parse	:= addr_parse;
--	app_verify	:= addr_verify;


--	===============================================================================
--	HANDLE BUGS IN PARSING RESULTS
--	===============================================================================
--	single character unit	(eg. Shiloh A)

	if	rtrim(app_unit1) is null	
	and	app_name not like 'AVENUE%'
	and	app_name not like 'AVE %'
	and	app_name like '% _'					then
		app_unit1	:= substr(app_name, length(app_name) - 1);
		app_name	:= rpad  (app_name, length(app_name) - 2);
	end if;


--	===============================================================================


	if	app_unit1 = '00'						then
		app_unit1 := null;
	end if;



--	duplicate street type

	if	app_sfx = rpad(app_type,02)				then
		app_sfx := ' ';
	end if;



--	duplex
	if	app_code1 = 'DPLX'
	or	app_parse like '%dplx%'					then
		app_num	:= app_unit2;
		app_code1	:= 'DPLX';



--	intersection
--	elsif	app_parse	like '%xstr%'				then
--		app_verify	:= rule.non_address;



--	street only
--	elsif nvl (app_num, '0') = '0'
--	and (	rtrim(app_code1||app_unit1) is not null 
--	or	translate (app_name, '/ABCDEFGHIJKLNMOPQRSTUVWXYZ ', '/') is not null)
--	then	app_verify	:= rule.non_address;

	end if;


--	highways
	if	app_unit1 in ( '190', '66', '78', '67')		then
		if	app_name like 'STATE%'
		or	app_type   = 'HWY'				then
			app_name  := 'HWY ' || app_unit1;
			app_unit1 := null;
		end if;
	end if;



	if	app_name   = 'HIGHWAY'							
	and	translate(app_unit1,'/0123456789','/') is null	then
		app_name	:= 'HIGHWAY ' || app_unit1;
		app_unit1	:= null;
	end if;




--	dime address format
	if	app_name like '____________________00%'		then
		app_name := rtrim(rpad (app_name, 20));
	end if;



--	UMS temporary pole
	if	app_name like '% TP'					then
		app_name := replace (app_name, ' TP');
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

