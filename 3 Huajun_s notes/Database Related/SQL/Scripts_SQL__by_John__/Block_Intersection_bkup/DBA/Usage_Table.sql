
	set echo	off;

--	=====================================================================
--	display oracle table space usage
--	=====================================================================

select	rpad ('*', 70, '*')				" "	from dual;

--	select	'T A B L E   N A M E S	   ' 
--	select	'T A B L E   R O W S	   ' 
--	select	'T A B L E   S I Z E S	   ' 
	select	'T A B L E   E X T E N T S ' 
--	select	'T A B L E   D A T E S	   ' 

	|| to_char (sysdate, 'MON dd yyyy  hh24:mi')	 " " from dual;


	select
			rpad (sg.segment_name, 25)				table_name,
	
			ob.created							" CREATED",

			to_char (sg.bytes, '999,999,999')			segment_size,

			lpad (sg.extents, 08)					" EXTENTS",

			to_char (tb.num_rows, '9,999,999')			"      ROWS"

	from		dba_segments	sg,			dba_tables		tb,
			dba_objects		ob
			
	where		sg.segment_type = 'TABLE'

	and		sg.owner 	= 'GARLAND'
	and		sg.owner 	= tb.owner
	and		sg.owner 	= ob.owner

	and		sg.segment_name	= tb.table_name
	and		sg.segment_name	= ob.object_name

--	order by	table_name;
--	order by	segment_size,	table_name
--	order by	num_rows,		table_name
--	order by	created,		table_name
	order by	extents,		table_name
	;

	set echo on;
