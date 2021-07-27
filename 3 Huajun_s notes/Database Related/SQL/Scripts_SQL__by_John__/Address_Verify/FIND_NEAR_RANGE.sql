	set echo		off;
	set serveroutput	on;

--	select * from cdreladr	where addr_name = 'COUNTRY CLUB'	and rownum < 11;

--	===================================================================================

	create or replace procedure	Find_Near_Range
	(
		find_name	in		varchar2, 
		find_lo	in out 	number, 
		find_hi	   out 	number	
	)	
	is

--	----------------------------------------------------
/*
	declare
	find_name	varchar2(20)	:= 'KINGS';
	find_lo	integer		:=  1802;
	find_hi	integer;
*/
--	----------------------------------------------------

	srch_name	varchar2(20);
	srch_lo	integer;
	srch_hi	integer;

cursor read_address		is

	select  --+	index_desc (cdreladr)
		'lo'					  bound,	
		trunc (addr_num,-2)  		  addr_num, 
		addr_name, addr_type, addr_pfx, addr_sfx
	from	 garland.cdreladr

	where	 addr_name	= srch_name
	and	 addr_num  <= srch_lo
	and	 rownum < 2

	union all	

	select
		'hi'					   bound,	
		 trunc(addr_num,-2) + 99	   addr_num,
		 addr_name, addr_type, addr_pfx, addr_sfx
	from	 garland.cdreladr

	where	 addr_name	= srch_name
	and	 addr_num  >= srch_hi
	and	 rownum < 2;

--	----------------------------------------------------
begin

--	Dbms_output.put_line ( ' ' );
--	Dbms_output.put_line ( 'input   ' || find_lo ||' '|| find_name );

	srch_name	:= find_name;
	srch_hi	:= trunc(find_lo, -2);		--  glb of srch_hi
	srch_lo	:= srch_hi + 99;			--  lub of srch_lo

	find_lo	:= null;
	find_hi	:= null;

--	Dbms_output.put_line ( 'search  ' || srch_lo ||' - '|| srch_hi ||' '|| srch_name );


for look in read_address	loop

--	Dbms_output.put_line ( 'look    ' || look.addr_num ||' '|| look.addr_name ||'		'|| look.bound);

	if	look.bound = 'lo'			then
		find_lo	:= look.addr_num;
	else
		find_hi	:= look.addr_num;
	end if;

end loop;

	find_lo	:= nvl(find_lo, 0);
	find_hi	:= nvl(find_hi, 99999);

--	Dbms_output.put_line ( 'output  ' || find_lo ||' - '|| find_hi ||' '|| find_name );

end Find_Near_Range;



