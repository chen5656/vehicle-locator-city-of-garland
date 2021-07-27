set linesize 2000;
set pagesize 200;
set serveroutput on		size 999999;
--	============================================================================
--	Build BLOCK table from TRVEHRCL & CDRELADR
--	============================================================================

	Truncate table	garland.Block			reuse storage;

--	============================================================================


declare

	do_compile			number	:= 0;
	do_insert			number	:= 01;
	do_print			number	:= 0;

	this_block_id		number	:= 3000000;
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

	select	streetname,	streettype,	streetprefix,	streetsuffix,
			min (trunc (rangelo, -2))	lo,
			max (trunc (rangehi, -2))	hi
	from		gis.ROAD
	where		rangelo is not null
	and		rangehi is not null
	group by	streetname,	streettype,	streetprefix,	streetsuffix
	order by	streetname,	streettype,	streetprefix,	streetsuffix,  min(trunc(rangelo,-2));

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

while	this_lo <= this_hi				loop

--	truncate table	garland.plan_table;
--	explain plan	set statement_id = 'test'	for

	select	min (trunc (rangelo, -2)), 
			max (trunc (rangelo, -2)),		-- mar 2004
			max (trunc (rangehi, -2)),		-- mar 2004
			count(distinct rangelo ||'.'|| rangehi)	
	into		start_lo,
			stop_lo,
			stop_hi,
			record_count
	from		gis.ROAD
	where		streetname	= look.streetname	
	and		streettype	= look.streettype	
	and		streetprefix	= look.streetprefix	
	and		streetsuffix	= look.streetsuffix	
	and		this_lo	between trunc(rangelo,-2)	
	and	 	  trunc(rangehi,-2) + 99;

--	select * from garland.explain_plan;

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
			rpad(look.streetprefix, 02)		||'/'||
			rpad(look.streetname,20)		||'/'||
			rpad(look.streettype,04)		||'/'||
			rpad(look.streetsuffix, 02)		||'/'||
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

		this_block_id	:= this_block_id + 01;

		insert into garland.BLOCK 	values 
		(
			this_block_id,
			this_lo,				--	mar 2004
			look.streetprefix,	
			look.streetname,	
			look.streettype,	
			look.streetsuffix,	
			start_lo,
			stop_lo,
			stop_hi,				--	mar 2004
			record_count,
			null, null				--	intersect ids
		);
	end if;

	this_lo := this_lo + 100;
		
end loop;

end loop;

	commit;

	select count(*)	
	into	total_segment
	from	gis.ROAD;		-- jul 2006

	select count(*)	
	into	total_poor_seg
	from	gis.ROAD		-- jul 2006
	where	rangelo is null
	or	rangehi is null
--	or	length (streetname) > 20
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

