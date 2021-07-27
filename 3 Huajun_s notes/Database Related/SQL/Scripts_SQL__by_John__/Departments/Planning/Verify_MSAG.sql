
	set echo		on;
	set timing		off;
	set serveroutput	on;

--	======================================================================================
/*

	create or replace	view	temp_view1	
			(	addr_pfx,
				addr_street,
				addr_lo,
				addr_hi	
			)
	as
		select	rtrim(item01),
				rtrim(item02),
				rtrim(item03),
				rtrim(item04)
		from		gis_objects;

*/	
--	======================================================================================
	

declare

		do_compile_only		number	:= 0;

		addr_type			varchar2(04);
		addr_sfx			varchar2(02);
		addr_code			varchar2(05);
		addr_unit			varchar2(05);
		addr_parse			varchar2(10);

		tally				number;

cursor	read_msag	is
		select *	from temp_view1;

		MSAG		read_msag%rowtype;

--	======================================================================================

begin

	if	do_compile_only > 0		then
		return;
	end if;

	open	read_msag;

loop

	fetch	read_msag	into msag;
	exit	when	read_msag%notfound
		or	read_msag%notfound is null;

	msag.addr_street	:= replace (replace (replace (msag.addr_street,'  ',' '), '  ',' '),  '  ',' ');
	addr_type	:= null;
	addr_sfx	:= null;
	addr_code	:= null;
	addr_unit	:= null;

	adr_parse_address ( msag.addr_lo, msag.addr_pfx, msag.addr_street, 
					addr_type, addr_sfx, addr_code, addr_unit, addr_parse	);
		

	select count(distinct addr_name)
	into	tally
	from	adrstreet	s	
	where	s.addr_name = msag.addr_street;

	if	tally = 0		
	and	msag.addr_street > 'A'			then
		dbms_output.put_line ( 'invalid name    ' || nvl(msag.addr_pfx,' ') 
									||' '|| rpad(msag.addr_street,30) 
									||' '|| addr_type);
--		dbms_output.put_line ( '''' || msag.addr_street	|| ''','	);
	end if;

end loop;

	close	read_msag;

end;
