
--	generate "dime" list of all address ranges in Garland 

	set echo		off;
	set serveroutput	on	size 999999;

declare

		report_count	number	:= 0;

cursor	read_dime_info			is

--	truncate table	plan_table;
--	explain plan	set statement_id = 'test'		for

	select distinct
		lpad(t.addr_left_from,05) ||'-'|| rpad(t.addr_left_to,05)	left_side,
		lpad(t.addr_rght_from,05) ||'-'|| rpad(t.addr_rght_to,05)	rght_side,
		rpad(t.addr_pfx,  02)			st_pfx,	
		rpad(t.addr_name, 20)			st_name,
		rpad(t.addr_type, 04)			st_type,	
		rpad(t.addr_sfx,  02)			st_sfx,
		rpad(p.police_beat,04)			beat,
		rpad(p.fire_district,04)		fire,
		t.addr_lo					

	from	trvehrcl		t,
		cdreladr		a,
		cdrelpar		p

	where	p.parcel_id	 (+)	= a.parcel_id
	and	p.police_beat(+)	> '0'

	and	a.addr_name	= t.addr_name
	and	a.addr_type	= t.addr_type
	and	a.addr_pfx	= t.addr_pfx
	and	a.addr_sfx	= t.addr_sfx
	and	a.addr_num >= t.addr_lo
	and	a.addr_num <= t.addr_hi

	order by	st_name, st_type, st_pfx, st_sfx, t.addr_lo;

--	select * from explain_plan;

	seg		read_dime_info%rowtype;

begin

for look in	read_dime_info		loop

	if	look.st_name	= seg.st_name
	and	look.st_type	= seg.st_type
	and	look.st_pfx		= seg.st_pfx
	and	look.st_sfx		= seg.st_sfx
	and	look.left_side	= seg.left_side
	and	look.rght_side	= seg.rght_side
	and	nvl(look.beat || look.fire, ' ') < '0'		then
		null;
	else
		dbms_output.put_line (	look.left_side ||' '|| look.rght_side  ||' '|| 
						look.st_pfx    ||' '|| look.st_name    ||' '||
						look.st_type   ||' '|| look.st_sfx     ||' '|| 
						look.beat	   ||' '|| look.fire	); 

		report_count := report_count + 01;
	end if;

	seg	:= look;

end loop;

	dbms_output.put_line ('total records:  ' || report_count);

end;

