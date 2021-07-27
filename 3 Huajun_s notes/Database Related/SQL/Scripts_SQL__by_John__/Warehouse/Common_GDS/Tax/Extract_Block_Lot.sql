	set echo	off;
	set serveroutput	on	size 99999;
--	==================================================================
--	Extract Tax Block & Lot info for Common_Tax table
--	==================================================================

--	TASKS
--		how should '&' be processed
--		where is the end of the legal description
--	==================================================================

--	@c:\deacutis\scripts\warehouse\gis_address_view\tax_block_lot\Tax_App_RowID.sql;

--	==================================================================

	Truncate table	garland.GIS_Objects	reuse storage;

	create or replace view	garland.Temp_view
(
	ACCOUNT,
	BLOCK,
	LOT
)
	as	select item01, item02, item03	
	from	garland.GIS_Objects;

--	==================================================================
declare

	do_compile		binary_integer	:= 0;
	do_insert		binary_integer	:= 0;
	do_print		binary_integer	:= 01;

	total_read		binary_integer	:= 0;
	total_insert	binary_integer	:= 0;

--	this_seq		binary_integer	:= 0;
	THIS_SEQ		binary_integer	:= 30000;			-- TEMP
	LAST_SEQ		binary_integer	:= THIS_SEQ + 10;		-- TEMP

	from_posn		binary_integer	:= 0;
	last_posn		binary_integer	:= 0;
	this_posn		binary_integer	:= 0;
	next_posn		binary_integer	:= 0;

	block_occur		binary_integer	:= 0;
	lot_occur		binary_integer	:= 0;

	this_legal		varchar2(400);
	this_info		varchar2(100);
	this_key		varchar2(10);
	prev_key		varchar2(10);

--	==================================================================

	type Keyword_Rec 	is record
(
	info			varchar2(20),
	posn			binary_integer
);

	Type Block_array	is table of	Keyword_rec
		index by binary_integer;

	Type Lot_array	is table of	Keyword_rec
		index by binary_integer;

--	-------------------------------------------------------------------

	Key		Keyword_rec;
	Block		Block_array;
	Lot		Lot_array;
	Keywords	varchar2(400);

--	==================================================================
cursor	Read_Tax		is

	select	ltrim(rtrim(macctno))					ACCOUNT, 
			' ' || rtrim(desc2) ||' '|| rtrim(desc3)		LEGAL
	from		garland.TAX			v,
			garland.gis_app_rowid	g
	where		g.row_seq	= this_seq
	and		g.row_id	= v.rowid;
	
	TAX		Read_Tax%rowtype;

--	==================================================================

begin

	if	do_compile > 0		then
		return;
	end if;

loop

	EXIT WHEN THIS_SEQ > LAST_SEQ;		-- TEMPORARY

	this_seq	:= this_seq + 01;

	open	Read_Tax;
	fetch Read_Tax			into TAX;
	exit when	read_tax%notfound
		or	read_tax%notfound is null;
	close	Read_Tax;

	total_read	:= total_read + 01;

	if	do_print > 0			then
		dbms_output.put_line ( 'Read Tax  ' || tax.Account ||'/'|| tax.Legal || '/');
		dbms_output.put_line ( ' ' );
	end if;

--	------------------------------------------------------------------
--	' |'		length = 02
--	'BLK		length = 03
--	' |BLK'	length = 05
--	info		position = 06
--	------------------------------------------------------------------

	this_legal	:= upper (tax.legal) || '   $$$ ';

	this_legal	:= replace (this_legal,	' $$$ ',	' |END '	);	
	this_legal	:= replace (this_legal,	' BLK ',	' |BLK '	);	
	this_legal	:= replace (this_legal,	' LOT ',	' |LOT '	);	
	this_legal	:= replace (this_legal,	' LOTS ',	' |LOT '	);	
	this_legal	:= replace (this_legal,	' LT ',	' |LOT '	);	
	this_legal	:= replace (this_legal,	' PT ',	' |PT  '	);	
	this_legal	:= replace (this_legal,	' TR ',	' |TR  '	);	
	this_legal	:= replace (this_legal,	' ACS ',	' |ACS '	);	
	this_legal	:= replace (this_legal,	' N ',	' |N   '	);	
	this_legal	:= replace (this_legal,	' NE ',	' |NE  '	);	
	this_legal	:= replace (this_legal,	' NW ',	' |NW  '	);	
	this_legal	:= replace (this_legal,	' S ',	' |S   '	);	
	this_legal	:= replace (this_legal,	' SE ',	' |SE  '	);	
	this_legal	:= replace (this_legal,	' SW ',	' |SW  '	);	
	this_legal	:= replace (this_legal,	' E ',	' |E   '	);	
	this_legal	:= replace (this_legal,	' W ',	' |W   '	);	
	this_legal	:= replace (this_legal,	'&',		' |&   '	);	
	this_legal	:= replace (this_legal,	' JURIS ',	' |JUR '	);	
	this_legal	:= replace (this_legal,	' LESS ',	' |LES '	);	

--	------------------------------------------------------------------

	if	do_print > 0		then
		dbms_output.put_line ( 'legal= ' || this_legal );
	end if;


	block.delete;
	lot.delete;
	block(1).info := null;
	lot  (1).info := null;

	keywords	:= null;
	block_occur	:= 0;
	lot_occur	:= 0;

	this_posn	:= instr (this_legal, ' |');
	from_posn	:= this_posn + 05;

while this_posn > 0	loop

	next_posn	:= instr (this_legal, ' |', from_posn);

	this_key	:= substr(this_legal, this_posn + 02, 03);
	this_info	:= substr(this_legal, this_posn + 06, next_posn - this_posn - 05);

	key.info	:= ltrim(rtrim(this_info));
	key.posn	:= this_posn;
	
	if	this_key = 'BLK'		then
		block_occur		 := block_occur + 01;
		block(block_occur) := key;
	end if;
	
	if	this_key = 'LOT'		then
		lot_occur		:= lot_occur + 01;
		lot(lot_occur)	:= key;
	end if;

	keywords := keywords || this_key || ' ';

	if	do_print > 0		then
		dbms_output.put_line ( 'key= ' || this_key    || ' info=' || key.info || '  audit=' || keywords );
		dbms_output.put_line ( 'from=' || from_posn   || ' this=' || this_posn || ' next=' || next_posn );
		dbms_output.put_line ( 'blok=' || block_occur || ' lot= ' || lot_occur );
		dbms_output.put_line ( ' ' );
	end if;

	from_posn	:= next_posn + 03;
	last_posn	:= this_posn;
	this_posn	:= next_posn;
	prev_key	:= this_key;

end loop;

--	------------------------------------------------------------------

	if	do_insert > 0			then	
		if	block_occur	> 0
		or	lot_occur	> 0				then

			insert into	garland.Temp_View		values
			(
			tax.Account, 
			block (1).info,
			lot   (1).info
			);
	
			commit;
			total_insert := total_insert + 01;
		end if;
	end if;
	
end loop;

	dbms_output.put_line ( ' ');
	dbms_output.put_line ( 'Total Reads   ' || total_read);
	dbms_output.put_line ( 'Total inserts ' || total_insert);

end;

