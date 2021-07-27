	set echo 		off;
	set timing		off;
	set serveroutput	on	size 99999;

declare

	ttl_triplet		number	:= 0;
	prev_node		number	:= 0;


--	=======================================================
	cursor	read_triplets		is


--	truncate table	plan_table;
--	explain plan	set statement_id = 'a'		for

	select	distinct 
			T.node,			
			T.counter, 
			r.addr_pfx,			
			r.addr_name,			
			r.addr_type,		
			r.addr_sfx			

	from	spoke			s,
		trvehrcl		r,
(
	select node,	
		count(distinct (addr_name||addr_type))			 	counter
--		count(distinct (addr_name||addr_type||addr_pfx||addr_sfx)) 	counter
	from
(
	select rpad(node,5)	node, 
		 addr_name, addr_type, addr_pfx, addr_sfx
		
	from	 spoke		s,
		 trvehrcl		r
	where	 s.segment_id = rtrim(mslink)
)

	group by 	node
	having	count(distinct (addr_name||addr_type)) > 2
--	having	count(distinct (addr_name||addr_type||addr_pfx||addr_sfx)) > 2
)					T

	where	s.node	 	= rtrim(T.node)
	and	s.segment_id 	= rtrim(r.mslink)
	;

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

for	look in read_triplets		loop

	if	prev_node <> look.node			then
		prev_node   := look.node;
		ttl_triplet := ttl_triplet + 01;
		dbms_output.put_line ( ' ' );
	end if;	

	dbms_output.put_line (	lpad(look.node,04)	||' '|| rpad(look.addr_pfx, 02) ||' '|| 
					rpad(look.addr_name,30) ||' '|| rpad(look.addr_type,04) ||' '|| 
					rpad(look.addr_sfx, 02)		
				);

end loop;

		dbms_output.put_line ( ' ' );
		dbms_output.put_line ( 'total triplets ' || ttl_triplet );

end;



--	======================================================================
/*
	select	distinct 
			'triple intersect '			" ",
			T.node					node,
			rpad ( '('|| T.counter ||')', 10)	" ",
			r.addr_pfx					pf,
			rpad(r.addr_name,20)			name,
			r.addr_type					type,
			r.addr_sfx					sf
*/
--	======================================================================

