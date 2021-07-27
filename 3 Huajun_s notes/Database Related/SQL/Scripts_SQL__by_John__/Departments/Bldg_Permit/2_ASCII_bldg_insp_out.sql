--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	400;
set pagesize	9999;
-- alter session	set nls_date_format = 'yyyymmdd hh24:mi:ss';  
--	============================================================================

declare

	do_compile	binary_integer	:= 0;
	counter	binary_integer	:= 0;
	prev_rec	binary_integer	:= 0;
	prev_col	binary_integer	:= 999;
	text		varchar2(80);

begin

	if	do_compile > 0		then
		return;
	end if;

--	dbms_output.put_line ('Site Address;Sq Feet;Valuation');
	dbms_output.put_line ('Site Address;Valuation');

	text := null;

for	look in (select * from garland.Temp_View1  order by rec, col)
loop

--	dbms_output.put_line (look.rec ||' '|| look.col);		-- TEST
--	exit when	look.rec > 10;						-- TEST

	counter := counter + 01;

	if 	look.rec > prev_rec
	and	text is not null		then
		dbms_output.put_line (rtrim(text,';'));
	end if;

	if	look.rec > prev_rec	then
		text	:= null;
	end if;

	text	:= text || look.info ||';';

	prev_rec := look.rec;
	prev_col := look.col;

end loop;

	dbms_output.put_line (rtrim(text,';'));

	dbms_output.put_line ('Total Input = ' || counter);
end;

--	============================================================================
