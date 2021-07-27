	set echo		off;
	set fetchrows	111;
--	=======================================================
--	what are records of duplicated nodes
--	=======================================================

--	truncate table	plan_table;
--	explain plan	set statement_id = 'a'		for
--	=======================================================

	select	rpad(A.intersect_id,	 12)		intersect_id
			,rpad(max(A.node_id),    08)		node		
			,rpad(max(B.cntr),	 08)		count
			,rpad(max(A.addr1_name), 20)		name1
			,rpad(max(A.addr1_type), 04)		type1
			,rpad(max(A.addr2_name), 10)		name2 
			,rpad(max(A.addr2_type), 04)		type2 

	from		intersection		A,
(
	select	intersect_id
			,count(*)			cntr
	from		intersection
	group by 	intersect_id
	having 	count(*) > 1
)							B

	where	A.intersect_id	= B.intersect_id

	group by 	A.intersect_id
	having 	count (distinct A.node_id) = 1
	;

--	=======================================================

--	select * from explain_plan;

	set fetchrows;
	set echo	on;


