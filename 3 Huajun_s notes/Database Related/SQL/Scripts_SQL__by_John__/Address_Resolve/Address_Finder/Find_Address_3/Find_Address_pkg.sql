	set echo	off;
--	========================================================================

	drop package			garland.Finds_Address;

	create or replace package	garland.Finds_Address		As

--	========================================================================

	address_entity		varchar2(1)		:= 'A';
	block_entity		varchar2(1)		:= 'B';
	street_entity		varchar2(1)		:= 'S';

	exact_class			varchar2(1)		:= '1';
	close_class			varchar2(1)		:= '2';		
	like_class			varchar2(1)		:= '4';		

	right_class			varchar2(1)		:= '1';
	good_class			varchar2(1)		:= '2';
	fair_class			varchar2(1)		:= '3';
	poor_class			varchar2(1)		:= '4';

	option_show_good		varchar2(1)		:= '2';
	option_show_transpose	varchar2(1)		:= '1';
	option_show_rhyme		varchar2(1)		:= '2';

	right_status		varchar2(10)	:= '1A0';
	alias_is_partial		varchar2(10)	:= 'part';
	end_of_list			varchar2(10)	:= 'eol';

	option_far_fuzzy		varchar2(05)	:= '1';

	fuzzy_name_leng		binary_integer	:= 21;

--	========================================================================
/*	Address should be fixed string of Address Option info

	Type	Address_Option	is record		-- total = 70
(			
	addr_num		varchar2(06),		-- addr  = 50
	addr_pfx		varchar2(02),
	addr_name		varchar2(21),
	addr_type		varchar2(05),
	addr_sfx		varchar2(02),
	addr_bldg		varchar2(07),
	addr_unit		varchar2(07),

	status		varchar2(04)

	location1_id	varchar2(08),
	location2_id	varchar2(08),

--	intersect1		varchar2(30),
--	intersect2		varchar2(30),
);

*/
--	========================================================================

	Address			varchar2(80);

	Intersection		varchar2(40);

	Region_ID			varchar2(20);

	Type Address_Array	is table of		Address%type
		index by binary_integer;

	Type Intersection_Array	is table of		Intersection%type
		index by binary_integer;

	Type Region_Array		is table of		Region_ID%type
		index by binary_integer;

--	========================================================================

	Procedure 	Main
(
	user_num		in		varchar2,
	user_pfx		in		varchar2,		-- in out
	user_name		in		varchar2,
	user_type		in		varchar2,		-- in out
	user_sfx		in		varchar2,		-- in out
	user_bldg		in		varchar2,
	user_unit		in		varchar2,
	
	control		in out	varchar2,
	choice		in out	number,
	occurs		in out	number,

	Region_Entry	in out	Region_Array,

	Address_Entry	out 		Address_Array,
	Intersect1		out 		Intersection_Array,
	Intersect2		out 		Intersection_Array
);

	end;

--	========================================================================
