--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=============================================================================
--	Read GDS_Account table for Owner Address
--	Arrange it on a temporary table in fixed columns
--	This will be used to populate Common Tax table
--	=============================================================================

	create or replace procedure	garland.FORMAT_TAX_OWNER	
	(
		pass_in1			IN		varchar2,
		pass_in2			IN		varchar2,
		pass_in3			IN		varchar2,
		pass_in4			IN		varchar2,

		pass_tax_attn		OUT		varchar2,
		pass_tax_strt		OUT		varchar2,
		pass_tax_unit		OUT		varchar2,
		pass_tax_city		OUT		varchar2,
		pass_tax_state		OUT		varchar2,
		pass_tax_name		OUT		varchar2,

		pass_cast			OUT		varchar2,
		pass_error			OUT		varchar2
	)	AS

--	DECLARE

--	=============================================================================

	do_compile		binary_integer	:= 0;

	title			varchar2(100);

	tax_input1		varchar2(40);
	tax_input2		varchar2(40);
	tax_input3		varchar2(40);
	tax_input4		varchar2(40);

	adr_attn		varchar2(40);
	adr_strt		varchar2(40);
	adr_unit		varchar2(40);
	adr_city		varchar2(40);
	adr_state		varchar2(40);
	adr_name		varchar2(40);

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

	this_type		binary_integer;
	prev_type		binary_integer;
	item_count		binary_integer;
	locate		binary_integer;

	text			varchar2(40);
	pattern		varchar2(40);
	cast			varchar2(40);
	error			varchar2(20);

--	=============================================================================
begin

	if	do_compile > 0		then
		return;
	end if;

	tax_input1		:= pass_in1;
	tax_input2		:= pass_in2;
	tax_input3		:= pass_in3;
	tax_input4		:= pass_in4;

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
		text	:= tax_input4;
	elsif	x = 3					then
		text	:= tax_input3;
	elsif	x = 2					then
		text	:= tax_input2;
	else
		text	:= tax_input1;
	end if;

	if	text is null			then
		goto	end_loop;
	end if;

--	-----------------------------------------------------------------------------

	text		:= translate (upper (ltrim(rtrim(text),' ''')), '.', ' ');	

	pattern	:= translate (  text,	'BCDEFGHIJKLMNOPQRSTUVWXYZ123456789',
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
	and	pattern like '%, AA'
	then
		item_count	:= 0;
		this_type	:= 05;
		type5		:= 'city';

	elsif	prev_type = 05				then
		if	' ' || text like 'PO %'	
		or	' ' || text like 'P O %'	
		or	' ' || text like '% BOX %'	then
			this_type	:= 04;				
			type4		:= 'pobox';

		elsif	pattern like '0%'			then	
			this_type	:= 04;					
			type4		:= 'street';

		elsif	text	  like 'SUITE %'					
		and	pattern like 'AAAAA % 000%'	then	
			this_type	:= 04;					
			type4		:= 'street';

		else
			this_type	:= 00;				
			type4		:= 'street';
			ERROR		:= 'street?';
		end if;

	elsif	prev_type = 04				then
		if	text like 'STE %'
		or	text like 'APT %'	
		or	text like 'SUITE %'
		or	text like 'APART %'		then
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
		ERROR		:= 'unknown';
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

	cast	:= type1 ||'/'|| type2 ||'/'|| type3 ||'/'||  type4 ||'/'|| type5;

--	-----------------------------------------------------------------------------

	pass_tax_attn	:=	text_attn;
	pass_tax_strt	:=	text_strt;		
	pass_tax_unit	:=	text_unit;			
	pass_tax_city	:=	this_city;		
	pass_tax_state	:=	this_state;		
	pass_tax_name	:=	text_name;		
	pass_cast		:=	cast;		
	pass_error		:=	error;		

      RETURN;
end;
