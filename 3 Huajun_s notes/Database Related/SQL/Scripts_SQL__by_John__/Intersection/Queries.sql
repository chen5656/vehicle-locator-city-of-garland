	set echo 		off;
	set fetchrows	111;
--	==========================================================================================================

--	desc cdrelpar;
--	desc adrblock_side;

--	==========================================================================================================

	select count(*)	"total"		--  9436
	from	 intersection
	where	 intersect_id like 'AA%';

--	==========================================================================================================
--	name intersections
--	==========================================================================================================	

	select 	addr1_name, addr2_name, count(*)
	from 		intersection
	group by	addr1_name, addr2_name
	having	count(*) > 20;


	select count(*) 		"name/name", 
		 avg(count(*))	"average", 
		 min(count(*))	"minimum", 
		 max(count(*))	"maximum"
	from	intersection
	where	intersect_id like 'AA%'
	group by	addr1_name, addr2_name;


--	how often do intersection groups of certain sizes occur
--	note:	forest/shiloh & shiloh/forest are counted as single occurrence
	select	group_size, count(*)/2	occurrence
	from
(
	select 	count(*)			group_size
	from		intersection

	group by	addr1_name, addr2_name, addr1_type, addr2_type
--	group by	node_id
)
	group by	group_size
	order by	group_size;
--	order by	occurrence desc;


--	what are the intersection groups of a specified group size
	select	addr1_name, addr1_type, addr2_name, addr2_type
	from
(
	select	addr1_name, addr1_type, addr2_name, addr2_type,
			count(*)		Group_Size
	from		intersection

	group by	addr1_name, addr1_type, addr2_name, addr2_type
--	group by	node_id
)
	where		group_size > 90
	order by	1,2,3,4

--	==========================================================================================================
--	intersection couplets
--	==========================================================================================================	


--	how many occurrences of each frequency
	select	total, count(*)
	from
(
	select count(*)		total 
	from	intersection
	where intersect_id like 'AA%'
	group by rpad(addr1_name,2) || rpad(addr2_name,2)
)
	group by	total
	order by	total desc;


--	frequency of each couplet
	select	rpad(addr1_name, 2) || rpad(addr2_name, 2) ||'   '	"couplet",
 			count(*)								"total" 
	from intersection
	where intersect_id like 'AA%'
	group by rpad(addr1_name,2) || rpad(addr2_name,2)
	having count(*) >= 10
	order by 2 desc, 1;

--	frequency of specified couplet
	select addr1_name, addr1_type, addr2_name, addr2_type	
	from	intersection
	where intersect_id like 'AA%'
	and	rpad(addr1_name,2) || rpad(addr2_name,2) = 'GEGE'		--	CHANGE
	order by 1,2;


--	summary of different frequencies
	select count(count(*))	"total", 
		 avg(count(*))	"avg", 
		 min(count(*))	"min", 
		 max(count(*))	"max"
	from		intersection
	where		intersect_id like 'AA%'
	group by	rpad(addr1_name, 3) || rpad(addr2_name, 3)
--	having	count(*) = 1						--  6276
--	having	count(*) = 2						--  809
--	having	count(*) = 3						--  136
	having	count(*) > 10						--  014
	;

--	==========================================================================================================
--	how many distinct   region sets are on cdrelpar and adrblock
--	how many incomplete region sets are on cdrelpar and adrblock
--	==========================================================================================================	

	select 

--		distinct 

		subdiv_id, council_id, police_beat, zip_code, code_inspect_area, fire_district

	from	cdrelpar
--	from	adrBlock


	where	subdiv_id		is null	
	or	council_id		is null
	or	police_beat		is null
	or	zip_code		is null
	or	code_inspect_area	is null
	or	fire_district	is null

	;
	
--	=======================================================
--	what are records of duplicated nodes
--	=======================================================
--	truncate table	plan_table;
--	explain plan	set statement_id = 'a'		for

	select	*
--	select	intersect_id, min(node_id), max(node_id)

	from		intersection

	where		intersect_id		 in
(
	select	intersect_id
--			,count(*)
	from		intersection
	group by 	intersect_id
	having 	count(*) > 1
)

--	group by	intersect_id
--	having	count( distinct node_id) = 1
	;


--	======================================================================
--	verify spoke ids
--	======================================================================

	select * from adrStreets
	where	street_id in 
	(	2168, 2169, 0719	);


	select * from adrBlock
	where	block_id in 
	(	8054, 8066, 2634, 2635	);


	select addr_pfx, addr_name, addr_type, addr_sfx, addr_lo
	from trvehrcl
	where	mslink in 
	(	4381, 4395, 4399, 4375	);


--	======================================================================
--	select * from explain_plan;
--	select * from explain_indexed;
--	select * from explain_analyze;
--	select * from explain_table;
--	select * from explain_index;
--	select * from explain_constraint;
--	select * from explain_cost;
--	======================================================================
	set echo 		on;
	set fetchrows;



