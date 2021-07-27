	set echo	off;
--	========================================================================

	drop package			garland.Find_Address;

	create or replace package	garland.Find_Address		As

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

	Type	Address_Option	is record
(
	addr_num		varchar2(06),
	addr_pfx		varchar2(02),
	addr_name		varchar2(20),
	addr_type		varchar2(04),
	addr_sfx		varchar2(02),
	addr_bldg		varchar2(10),
	addr_unit		varchar2(20),

	location1_id	number,
	location2_id	varchar2(20),

	intersect1		varchar2(30),
	intersect2		varchar2(30),

	status		varchar2(05)
);

	Region_ID			varchar2(20);

	Type Address_Array	is table of Address_Option
		index by binary_integer;

	Type Region_Array		is table of Region_ID%type
		index by binary_integer;

--	========================================================================

	Procedure 	Main
(
	user_num		in		varchar2,
	user_pfx		in		varchar2,
	user_name		in		varchar2,
	user_type		in		varchar2,
	user_sfx		in		varchar2,
	user_bldg		in		varchar2,
	user_unit		in		varchar2,
	
	control		in out	varchar2,
	choice		in out	number,
	occurs		in out	number,

	Address_Entry	out 		Address_Array,	

	Region_Entry	in out	Region_Array
);

	end;

--	========================================================================
