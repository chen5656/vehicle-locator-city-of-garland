--	=====================================================================
	set echo		off;
	set serveroutput	on	size 9999;
--	=====================================================================
--	display spokes (segment at lo/hi end) attached to more than 1 node
--	=====================================================================

declare

	do_compile			number	:= 0;

	this_block			varchar2(10);
	this_pfx			varchar2(10);
	this_name			varchar2(40);
	this_type			varchar2(10);
	this_sfx			varchar2(10);

	show_terminal		varchar2(10);
	show_node			varchar2(10);
	show_segment		varchar2(10);

	this_segment		number;
	this_terminal		varchar2(10);
	this_node			varchar2(10);

	curr_segment		number;
	curr_terminal		varchar2(10);
	prev_segment		number;
	prev_terminal		varchar2(10);


--	=====================================================================
cursor	read_dupe_spoke			is

--	truncate table	plan_table;
--	explain plan	set statement_id = 'a'		for

		select	distinct			--	obtain many nodes of these spokes
				D.segment_id,
				D.terminal,
				s.node	

		from		spoke			s,
	(							--	what spokes are attached to many nodes
		select	segment_id,
				terminal
		from		spoke
		group by	segment_id,
				terminal
		having	count(*) > 1
	)							D

		where		s.segment_id = D.segment_id
		and		s.terminal	 = D.terminal;

		DUPE		read_dupe_spoke%rowtype;

--	=====================================================================
cursor	read_spoke_cluster		is

--	truncate table	plan_table;
--	explain plan	set statement_id = 'b'		for

	select	distinct
			s.segment_id,			
			s.terminal,
			s.node,

			lpad (
			decode (s.terminal,
				'L',	trunc(addr_lo, -2),
					trunc(addr_hi, -2)
				 ), 06) || ' '		addr_block,

			rpad(r.addr_pfx,  03)		addr_pfx,
			rpad(r.addr_name, 25)		addr_name,
			rpad(r.addr_type, 05)		addr_type,
			rpad(r.addr_sfx,  02)		addr_sfx	

	from		spoke			s,
			trvehrcl		r

	where		s.segment_id = r.mslink
	and	  	s.node	 = dupe.node;

	SEGM		read_spoke_cluster%rowtype;

--	======================================================================
--	select * from explain_plan;
--	select * from explain_indexed;
--	select * from explain_analyze;
--	select * from explain_table;
--	select * from explain_index;
--	select * from explain_constraint;
--	select * from explain_cost;
--	======================================================================

begin

	if	do_compile > 0		then
		return;
	end if;

	dbms_output.put_line (' ');
	dbms_output.put_line ('node number / low or high  / hundred block street / mslink ');

	open	read_dupe_spoke;

loop

	fetch	read_dupe_spoke		into dupe;
	exit when	read_dupe_spoke%notfound
	or		read_dupe_spoke%notfound is null;

	prev_segment  := curr_segment;
	prev_terminal := curr_terminal;
	curr_segment  := dupe.segment_id;
	curr_terminal := dupe.terminal;

	if	curr_segment  = prev_segment
	and	curr_terminal = prev_terminal		then
		null;
	else
		dbms_output.put_line ( ' ');
		dbms_output.put_line ( rpad ('*',60,'*') );
	end if;

	select	lpad (					--	display polynode spoke
			decode (s.terminal,
				'L',	trunc(addr_lo, -2),
					trunc(addr_hi, -2)
				 ), 06) || ' ',
			rpad(s.terminal, 03),
			rpad(r.addr_pfx, 03),
			rpad(r.addr_name,25),
			rpad(r.addr_type,05),
			rpad(r.addr_sfx, 02)

	into		this_block,
			this_terminal,
			this_pfx,
			this_name,
			this_type,
			this_sfx

	from		spoke			s,
			trvehrcl		r

	where		s.segment_id = r.mslink
	and		s.node	 = dupe.node
	and		s.segment_id = dupe.segment_id
	and		s.terminal	 = dupe.terminal;

	show_node	  := rpad(dupe.node, 06);
	show_terminal := rpad(dupe.terminal, 03);
	show_segment  := lpad(dupe.segment_id,08);
	dbms_output.put_line ( ' ' );
	dbms_output.put_line (	show_node || show_terminal || this_block || 
					this_pfx  || this_name	   || this_type  || this_sfx	||
					show_segment);

	open	read_spoke_cluster;

loop

	fetch	read_spoke_cluster			into segm;
	exit when	read_spoke_cluster%notfound
	or		read_spoke_cluster%notfound is null;

	if	segm.segment_id	= dupe.segment_id	
	and	segm.terminal	= dupe.terminal		then
		null;
	else
		show_node	  := rpad(segm.node, 06);
		show_terminal := rpad(segm.terminal,  03);
		show_segment  := lpad(segm.segment_id,08);
		dbms_output.put_line (	show_node		|| show_terminal  || segm.addr_block || 
						segm.addr_pfx	|| segm.addr_name || segm.addr_type  || segm.addr_sfx ||
						show_segment);
	end if;

end loop;

	close	read_spoke_cluster;


end loop;

	close	read_dupe_spoke;

end;


