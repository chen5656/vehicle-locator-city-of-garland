	set echo	on;
--	========================================================================

	drop package			garland.Find_Intersection;

	create or replace package	garland.Find_Intersection		As

--	========================================================================

	address_entity		varchar2(1)		:= 'A';
	block_entity		varchar2(1)		:= 'B';
	street_entity		varchar2(1)		:= 'S';
	Intersect_entity		varchar2(1)		:= 'X';

	right_class			binary_integer	:=  1;
	good_class			binary_integer	:=  2;
	fair_class			binary_integer	:=  3;
	poor_class			binary_integer	:=  4;

	right_status		varchar2(05)	:= '1100';		-- name,name,qual,qual (best first)
	alias_is_partial		varchar2(10)	:= 'part';
	end_of_list_status	varchar2(10)	:= 'zzz';

--	========================================================================

	Type	Intersection_Option	is record
(
	addr1_block		number,
	addr1_pfx		varchar2(10),
	addr1_name		varchar2(40),
	addr1_type		varchar2(10),
	addr1_sfx		varchar2(10),

	addr2_block		number,
	addr2_pfx		varchar2(10),
	addr2_name		varchar2(40),
	addr2_type		varchar2(10),
	addr2_sfx		varchar2(10),

	user_corner		varchar2(05),
	user_twin		varchar2(05),

	location1_id	varchar2(10),
	location2_id	varchar2(10),		--  address + near intersect 

	status		varchar2(10)
);

	Type Intersection_Array	is table of Intersection_Option
		index by binary_integer;

	Type Region_Array		is table of varchar2(20)
		index by binary_integer;

--	========================================================================

	Procedure 	Main
(
	user1_block		in		varchar2,
	user1_pfx		in		varchar2,
	user1_name		in		varchar2,
	user1_type		in		varchar2,
	user1_sfx		in		varchar2,

	user2_block		in		varchar2,
	user2_pfx		in		varchar2,
	user2_name		in		varchar2,
	user2_type		in		varchar2,
	user2_sfx		in		varchar2,

	user_corner		in		varchar2,
	user_twin		in		varchar2,
	
	control		in out	varchar2,
	choice		in out	number,
	counter		in out	number,

	Intersect_Entry	out 		Intersection_Array,	

	Region_Entry	in out	Region_Array
);

	end;

--	========================================================================
--	end;
--	========================================================================

