	set echo		on;
	set serveroutput	on	size 99999;
--	===================================================================================
--	set controls after @executions
--	===================================================================================
/*
	create or replace view	temp_view		
(
		rec_seq,
		addr_num, addr_pfx, addr_name,addr_type,addr_sfx
)
	as	select	item01, item02, item03, item04, item05, item06
		from		garland.gis_objects;
*/
--	===================================================================================

declare

	do_compile			number	:= 01;

	do_BATCH			number	:= 0		;	--  YES / NO
	do_SEQ			number	:= 0		;	--  YES / NO
--	else DO_MANUAL

--	do_query1			number	:= 067746	;	--  SEQ
--	do_query2			number	:= 0		;

	do_query1			number	:= 070	;	--  MANUAL
	do_query2			number	:= 080	;	

	control			varchar2(40);
	command			varchar2(40);
	choice			number;
	occurs			number;

	addr_num			varchar2(80);
	addr_pfx			varchar2(80);
	addr_name			varchar2(80);
	addr_type			varchar2(80);
	addr_sfx			varchar2(80);
	addr_bldg			varchar2(80);
	addr_unit			varchar2(80);

	this_seq			number;
	audit_seq			number;

--	===================================================================================

	Type	Address_Option	is record
(
	str_num		number(06),
	str_pfx		varchar2(02),
	str_name		varchar2(20),
	str_type		varchar2(04),
	str_sfx		varchar2(02),
	str_bldg		varchar2(10),
	str_unit		varchar2(20),

	location_id1	varchar2(10),
	location_id2	varchar2(10),

	intersect1		varchar2(30),
	intersect2		varchar2(30),

	status		varchar2(05)
);

	Type Address_Array	is table of Address_Option
		index by binary_integer;

	Type Region_Array		is table of varchar2(20)
		index by binary_integer;

	Line			Address_option;

	Address_List	Address_Array;	

	Region_List		Region_Array;

--	===================================================================================
begin

	if	do_compile > 0			then
		return;
	end if;

	if	do_query2 = 0			then
		do_query2 := do_query1;
	end if;

	dbms_output.put_line (' ');


<<process_queries>>

for	q in do_query1..do_query2			loop

	this_seq	:= q;									-- nov 2003

	audit_seq	:= null;

	if	do_seq > 0					
	and	this_seq > 0				then

--		---------------------------------------------------------------------------------------------

		select addr_num, addr_pfx, addr_name, addr_type, addr_sfx, addr_bldg, addr_unit
		into	 addr_num, addr_pfx, addr_name, addr_type, addr_sfx, addr_bldg, addr_unit
		from	 garland.temp_view	t
		where	 t.rec_seq = rtrim(this_seq);	

--		---------------------------------------------------------------------------------------------

		audit_seq	:= this_seq;	

		do_seq	:= -1;
		goto	execute_query;
	end if;

	exit when	do_seq > 0;				-- feb 2004

	if	q = 0
	or	do_seq < 0				then
		exit;

	elsif	q = 0					then
		addr_name	:= '';
		addr_num	:= '';
		addr_pfx	:= '';
		addr_type	:= '';
		addr_sfx	:= '';
		addr_bldg	:= '';
		addr_unit	:= '';

--	-------------------------------------------------------------------------
--	-------------------------------------------------------------------------

	else	goto	initialize_query;

--	-------------------------------------------------------------------------

	end if;


<<execute_query>>

	dbms_output.put_line (' ');
	dbms_output.put_line (lpad(q,5)||' *************************************************************');

	dbms_output.put_line ( '	' ||
	addr_num   ||' / '|| addr_pfx	  ||'	/ '  || addr_name  ||' / '|| addr_type ||' / '|| addr_sfx ||'	...'||
	addr_bldg ||' / '|| addr_unit );

--	===================================================================================

	garland.Find_Address.Main
	(
	addr_num,	 addr_pfx,	 addr_name,	 addr_type,	addr_sfx,	
	addr_bldg,	 addr_unit, 
	
	control,	
	command,	
	choice,	
	occurs,

	Address_List,
	Region_List	
	);

--	===================================================================================

	dbms_output.put_line ( '	' ||
	addr_num   ||' / '|| addr_pfx	  ||'	/ '  || adr_string_cleaner(addr_name)  ||' / '|| 
	addr_type  ||' / '|| addr_sfx   ||'	...'||
	addr_bldg ||' / '|| addr_unit 
	);


<<initialize_query>>

	addr_name		:= null;
	addr_num		:= null;
	addr_pfx		:= null;
	addr_type		:= null;
	addr_sfx		:= null;

	addr_bldg		:= null;
	addr_unit		:= null;

end loop;

	dbms_output.put_line ('    *************************************************************');
	
end;

--	===================================================================================

