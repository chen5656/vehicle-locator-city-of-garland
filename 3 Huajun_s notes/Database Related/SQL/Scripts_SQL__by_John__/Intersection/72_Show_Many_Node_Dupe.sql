	set echo		off;
	set fetchrows	111;
	
--	=======================================================
--	what are records of duplicated nodes
--	=======================================================

--	truncate table	plan_table;
--	explain plan	set statement_id = 'a'		for
--	=======================================================

	select	rpad(A.intersect_id, 11)	ID
			,lpad(max(B.cntr)   ,05)	count
			,lpad(min(A.node_id),05)	min
			,lpad(max(A.node_id),05)	max

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
	having 	count(distinct A.node_id) > 1
	;

--	=======================================================

--	select * from explain_plan;

	set fetchrows;
	set echo		on;

