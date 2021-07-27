	set echo off;		

--	drop package			build_intersection;

	create or replace package	build_intersection	is

	max_load	constant	number	:= 80000;		--	max record limit
	max_sample	constant	number	:= 100;		--	max report samples
	max_spoke	constant	number	:= 06;		--	max spokes per node
	commit_size	constant	number	:= 100;		--	batch size (then commit)
	insert_test	constant	number	:= 999;		--	load test intersecton

	do_test			number	:= 0;
	max_msg			number	:= 250;
	msg				varchar2(800);
	msg_info1			varchar2(800);
	msg_info2			varchar2(800);
	msg_info3			varchar2(800);


	procedure build_intersection_table 
	(
		street_street		number,	
		block_block			number,	

		block_street		number,
		street_block		number,		

		block_part			number,
		part_block			number,

		block_partial		number,
		partial_block		number,

		street_part			number,
		part_street			number,

		street_partial		number,
		partial_street		number,	

		partial_partial		number,	
		part_part			number

		,report			number		default 0
		,inserts			number		default max_load
		,corner			number		default 0
	);	

	end	build_intersection;

