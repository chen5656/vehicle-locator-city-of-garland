	set	echo			off;
    set linesize	2000;
	set	serveroutput	on;
--	=============================================================================
--	Read GDS_Account table for Owner Address
--	Arrange it on a temporary table in fixed columns
--	This will be used to populate Common Tax table
--	=============================================================================

--	is city big enough for foreign ?
--	=============================================================================

	Truncate table	garland.GIS_Temp1		reuse storage;	-- Owner Address
	
--	=============================================================================
declare

	do_compile		binary_integer	:= 0;
	do_insert		binary_integer	:= 01;

	total_input		binary_integer	:= 0;
	total_insert	binary_integer	:= 0;
	total_error		binary_integer	:= 0;

	type1			varchar2(10);
	type2			varchar2(10);
	type3			varchar2(10);
	type4			varchar2(10);
	type5			varchar2(10);

	text_attn		varchar2(40);
	text_name		varchar2(40);
	text_unit		varchar2(40);
	text_strt		varchar2(40);
	text_city		varchar2(40);

	this_city		varchar2(40);
	this_state		varchar2(40);

	this_seq		binary_integer;
	this_type		binary_integer;
	prev_type		binary_integer;
	item_count		binary_integer;
	locate		binary_integer;

	text			varchar2(40);
	pattern		varchar2(40);
	cast			varchar2(40);
	error			varchar2(20);

cursor	Read_Addr	is

	select account, owner_addr1, owner_addr2, owner_addr3, owner_addr4
	from	garland.gis_app_rowid	r,
		 garland.GDS_Account	t
	where	 r.row_seq	= this_seq
	and	 r.row_id	= t.rowid;

	Look		Read_Addr%rowtype;

--	=============================================================================
begin

	if	do_compile > 0		then
		return;
	end if;

	this_seq	:= 0;

loop
	this_seq	:= this_seq + 01;

	open	Read_Addr;
	fetch	Read_Addr	into Look;
	exit when	Read_Addr%notfound
		or	Read_Addr%notfound is null;
	close	Read_Addr;

	total_input		:= total_input + 01;
	item_count		:= 0;
	error			:= ' ';

	text_attn		:= null;
	text_name		:= null;
	text_unit		:= null;
	text_strt		:= null;
	text_city		:= null;
	
	prev_type		:= null;
	type1			:= null;
	type2			:= null;
	type3			:= null;
	type4			:= null;
 	type5			:= null;

	this_city		:= null;
	this_state		:= null;

for	x in reverse 1..4		loop

	if	x = 4					then
		text	:= look.owner_addr4;
	elsif	x = 3					then
		text	:= look.owner_addr3;
	elsif	x = 2					then
		text	:= look.owner_addr2;
	else
		text	:= look.owner_addr1;
	end if;

	if	text is null			then
		goto	end_loop;
	end if;

	text		:= upper (text);
	pattern	:= translate ( text,	'BCDEFGHIJKLMNOPQRSTUVWXYZ123456789',
							'AAAAAAAAAAAAAAAAAAAAAAAAA000000000');

--	-----------------------------------------------------------------------------

	this_type	:= 0;

	if	item_count = 0				then
		this_type		:= 05;
		if	pattern like '% AA'		then
			type5		:= 'city';
		else
			type5		:= 'foreign';
		end if;

	elsif	prev_type = 05	
	and	pattern like '% XX'
	and	text	  like '%,%'			then
		item_count	:= 0;
		this_type	:= 05;
		type5		:= 'city';

	elsif	prev_type = 05				then
		this_type	:= 04;
		if	' ' || text like '% BOX %'	then
			type4		:= 'pobox';
		elsif	pattern like '0%'			then	
			type4		:= 'street';
		else
			type4		:= 'street';
			error		:= 'street?';
		end if;

	elsif	prev_type = 04				then
		if	text like 'STE%'
		or	text like 'APT%'	
		or	text like 'SUITE%'
		or	text like 'APART%'		then
			this_type	:= 03;
			type3		:= 'unit';
		end if;
	end if;

	if	this_type = 0
	and	x <= 02					then

		if	type1 is null
		and (	text between '%' and '%z'
		or	text like 'C/O%'
		or	text like 'ATTN%'		)	then
			this_type	:= 01;	
			type1		:= 'attn';	

		elsif	type2 is null			then
			this_type	:= 02;
			type2		:= 'name';	
		end if;
	end if;

--	-----------------------------------------------------------------------------

	if	this_type = 00			then	
		error		:= 'unknown';
	elsif	this_type = 05			then
		text_city	:= text;
	elsif	this_type = 04			then
		text_strt	:= text;
	elsif	this_type = 03			then
		text_unit	:= text;
	elsif	this_type = 01			then
		text_attn	:= text;
	else
		text_name	:= text;
	end if;

--	-----------------------------------------------------------------------------

	if	this_type > 0			then
		item_count	:= item_count + 01;
		prev_type	:= this_type;
	end if;

<<end_loop>>
	null;
end loop;
--	-----------------------------------------------------------------------------

	if	type5 = 'city'			then
		locate	:= instr(text_city, ' ', -1);
		this_city	:= rtrim(substr (text_city,  01,  locate), ', ');	
		this_state	:= ltrim(substr (text_city, locate));
	else
		this_city	:= text_city;
	end if;

	if	error > ' '				then
		total_error	:= total_error + 01;
	end if;

	cast	:= type1 ||'/'|| type2 ||'/'|| type3 ||'/'||  type4 ||'/'|| type5;

--	-----------------------------------------------------------------------------

	if	do_insert > 0		then

		insert into	garland.Temp_View1	values
	(
		look.account,

		text_attn,
		text_name,
		text_unit,
		text_strt,

		this_city,
		this_state,

		cast,
		error
	);

		commit;
		total_insert := total_insert + 01;
	end if;

end loop;
--	-----------------------------------------------------------------------------

	dbms_output.put_line (' ');
	dbms_output.put_line ('Format Owner Address  ' || to_char (sysdate, 'Mon dd,yyyy  hh24:mi'));
	dbms_output.put_line ('Total Input  ' || total_input	);
	dbms_output.put_line ('Total_Insert ' || total_insert );
	dbms_output.put_line ('Total_Error  ' || total_error  );

end;

