	set echo		off;
	set timing		off;
	set serveroutput	on		size 999999;
--	============================================================================
--	Build BLOCK table from TRVEHRCL & CDRELADR
--	============================================================================


	D O   N O T   R U N   T H I S   J O B 


	B L O C K   M A I N T E N A N C E   I S   H A N D L E D   V I A   B L O C K   C O N T R O L

		see	c:\deacutis\scripts\block


--	============================================================================


declare

	do_compile			number	:= 01;
	do_insert			number	:= 01;
	do_print			number	:= 0;

	total_segment		number	:= 0;
	total_poor_seg		number	:= 0;
	total_street		number	:= 0;
	total_block			number	:= 0;
	total_good_seg		number	:= 0;

	this_lo			number;
	this_hi			number;

	start_lo			number;
	stop_lo			number;
	stop_hi			number;		-- mar 2004
	record_count		number;

cursor	read_streets	is

	select	addr_name,	addr_type,	addr_pfx,	addr_sfx,
			min (trunc (addr_lo, -2))	lo,
			max (trunc (addr_hi, -2))	hi,
			mslink

	from		garland.trvehrcl

	where		addr_lo is not null
	and		addr_hi is not null

	group by	addr_name,	addr_type,	addr_pfx,	addr_sfx

	order by	addr_name,	addr_type,	addr_pfx,	addr_sfx,  min(trunc(addr_lo,-2));

begin

	if	do_compile > 0		then
		return;
	end if;

--	dbms_transaction.use_rollback_segment ('RB1');

<<main>>

for	look in read_streets				loop

	total_street	:= total_street + 01;

	this_lo	:= look.lo;
	this_hi	:= look.hi;

while	this_lo <= this_hi					loop

--	truncate table	plan_table;
--	explain plan	set statement_id = 'test'	for

	select	min (trunc (addr_lo, -2)), 
			max (trunc (addr_lo, -2)),		-- mar 2004
			max (trunc (addr_hi, -2)),		-- mar 2004
			count(distinct addr_lo ||'.'|| addr_hi)	

	into		start_lo,
			stop_lo,
			stop_hi,
			record_count
	from		garland.trvehrcl

	where		addr_name	= look.addr_name	
	and		addr_type	= look.addr_type	
	and		addr_pfx	= look.addr_pfx	
	and		addr_sfx	= look.addr_sfx	
	and		this_lo	between trunc(addr_lo,-2)	
					and 	  trunc(addr_hi,-2) + 99;

--	select * from explain_plan;

--	============================================================================

	if	record_count > 0				then
		total_block	 := total_block + 01;
		total_good_seg := total_good_seg + record_count;
	end if;

	if	do_print > 0			
	and	record_count > 0				then
		do_print := do_print - 01;
		dbms_output.put_line 
		( 
			lpad(total_block,05)		||'	'||
			rpad(look.addr_pfx, 02)		||'/'||
			rpad(look.addr_name,20)		||'/'||
			rpad(look.addr_type,04)		||'/'||
			rpad(look.addr_sfx, 02)		||'/'||
			lpad(this_lo,5)			||'/'||
			lpad(start_lo,5)			||'/'||
			lpad(stop_lo, 5)			||'/'||
			lpad(stop_hi, 5)			||'/'||		-- mar 2004
			record_count
			||'		'||			this_lo
			||'/ '||				this_hi
		);
	end if;

	if	do_insert > 0				
	and	record_count > 0			then
		insert into garland.Block 	values 
		(
			999999,				--	temporary block id

			this_lo,				--	mar 2004
			look.addr_pfx,	
			look.addr_name,	
			look.addr_type,	
			look.addr_sfx,	

			look.mslink,

			start_lo,
			stop_lo,
			stop_hi,				--	mar 2004
			record_count
		);
	end if;

	this_lo := this_lo + 100;
		
end loop;

end loop;

	commit;

	select count(*)	
	into	total_segment
	from	garland.trvehrcl;

	select count(*)	
	into	total_poor_seg
	from	garland.trvehrcl
	where	addr_lo is null
	or	addr_hi is null
--	or	length (addr_name) > 20
	;

	dbms_output.put_line ( ' ' );
	dbms_output.put_line ( 'segments =	' || lpad (total_segment,5));
	dbms_output.put_line ( 'good seg = 	' || lpad (total_good_seg,  5));
	dbms_output.put_line ( 'poor seg =	' || lpad (total_poor_seg, 5));
	dbms_output.put_line ( 'streets  =	' || lpad (total_street, 5));
	dbms_output.put_line ( 'blocks   =	' || lpad (total_block,  5));

end;


--	=====================================================================================================

/*	Program Summary

	Obtain total hundred block range for each street in the Centerline table (read_streets cursor)

	For each hundred block within the range do the following:
		Find all centerline segments containing the hundred block within their range
		Obtain the cumulative range of all segments containing this 100 block (start_lo, start_hi)
		Count the number of segments that contain the 100 block (record_count)
		Write the Block table record
*/

