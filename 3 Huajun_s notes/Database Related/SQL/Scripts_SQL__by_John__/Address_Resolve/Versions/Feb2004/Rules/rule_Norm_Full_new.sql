	set echo	off;
--	============================================================

	create or replace	package	garland.adr_resolve_rules   as
	
--	============================================================
--	"App Full Run" address resolution rules
--	============================================================

	none		binary_integer	:= null;
	no		binary_integer	:= 0;
	yes		binary_integer	:= 1;			

--	============================================================
--	steps 

	do_name			binary_integer  	:= 01;
	do_street			binary_integer	:= 02;		
	do_address			binary_integer	:= 03;
	do_block			binary_integer	:= 04;
	do_range			binary_integer	:= 0;

--	============================================================
--	functions

	do_alien			binary_integer	:= 01;

		safe_parse		binary_integer	:= 02;
	do_parse			binary_integer	:= 01;

		alias_form		binary_integer	:= 1;
		alias_fuzzy		binary_integer	:= 2;
		alias_addr		binary_integer	:= 3;
	do_alias			binary_integer	:= alias_fuzzy;

	do_unparsed_exit		binary_integer	:= 01;
	do_parsed_exit		binary_integer	:= 01;

--	============================================================

--	parse_options		varchar2(40)	:= null;

--	============================================================
--	name correction

	do_type_A			binary_integer	:= 01;
	do_type_B			binary_integer	:= 01;
	do_type_C			binary_integer	:= 120;	-- max score

	do_alias_weight		binary_integer	:= 02;

--	============================================================
--	street qualifier correction weights

--	match		binary_integer	:= 10000;	
--	blank		binary_integer	:= 1000;	

	match		binary_integer	:= 200;	
	blank		binary_integer	:= 120;	

	append	binary_integer	:= 100;	
	remove	binary_integer	:= 20;	
	change	binary_integer	:= 15;					-- DEC 2004

	accept_weight binary_integer	:= append + remove + remove + 01;	-- JAN 2005

	append_unq	binary_integer	:= 3;	
	remove_unq	binary_integer	:= 2;
	change_unq	binary_integer	:= 1;						-- DEC 2004

		str_unq_type	binary_integer	:= change_unq;
		str_unq_pfx		binary_integer	:= remove_unq;
		str_unq_sfx		binary_integer	:= remove_unq;

		str_type		binary_integer	:= remove;
		str_pfx		binary_integer	:= remove;
		str_sfx		binary_integer	:= append;

		blk_type		binary_integer	:= append;
		blk_pfx		binary_integer	:= append;
		blk_sfx		binary_integer	:= append;

		adr_type		binary_integer	:= append;
		adr_pfx		binary_integer	:= append;
		adr_sfx		binary_integer	:= append;

		rng_type		binary_integer	:= blank;
		rng_pfx		binary_integer	:= blank;
		rng_sfx		binary_integer	:= blank;

--	============================================================
--	street correction permission

	forbid		binary_integer	:= -1;
	no_match		binary_integer	:= 0;
	base_match		binary_integer	:= 1;	
	part_match		binary_integer	:= 2;	
	all_match		binary_integer	:= 3;
	permit		binary_integer	:= 9;

		permit_blk_basis		binary_integer	:= none;
		permit_blk_append		binary_integer	:= permit;
		permit_blk_remove		binary_integer	:= permit;
		permit_blk_change		binary_integer	:= permit;

		permit_adr_basis		binary_integer	:= none;
		permit_adr_append		binary_integer	:= permit;
		permit_adr_remove		binary_integer	:= permit;
		permit_adr_change		binary_integer	:= permit;

		permit_rng_basis		binary_integer	:= none;
		permit_rng_append		binary_integer	:= permit;
		permit_rng_remove		binary_integer	:= permit;
		permit_rng_change		binary_integer	:= permit;

--	============================================================
--	miscellaneous

	reset_to_parsed		binary_integer		:= 1;
		do_reset		binary_integer		:= 0;

	capacity			binary_integer		:= 200000;

	keep_unparsed		binary_integer		:= yes;
	keep_parsed			binary_integer		:= yes;

	parse_options		varchar2(40)	:= '';
	parse_default		char(9)		:= '.........';

--	============================================================

	mark_non_address		char		:= '/';
	mark_non_garland		char		:= '$';
	mark_non_correct		char		:= '?';	-- 'fores' 
	mark_non_complete		char		:= '*';

	mark_parse_undo		char		:= '-';
	mark_verify_only		char		:= '=';
	mark_parse_error	char		:= '!';

--	============================================================
--	verify codes

	non_address			binary_integer	:= 00;
	non_garland			binary_integer	:= 01;
	non_correct			binary_integer	:= 02;
	non_complete		binary_integer	:= 03;

	valid_name			binary_integer	:= 10;
	poor_name			binary_integer	:= 11;
	mixed_name			binary_integer	:= 12;
	part_name			binary_integer	:= 14;
	full_name			binary_integer	:= 15;

	poor_orphan			binary_integer	:= 21;
	mixed_orphan		binary_integer	:= 22;
	part_orphan			binary_integer	:= 24;
	full_orphan			binary_integer	:= 25;

	poor_block			binary_integer	:= 31;
	mixed_block			binary_integer	:= 32;
	wrong_block			binary_integer	:= 33;
	part_block			binary_integer	:= 34;
	full_block			binary_integer	:= 35;

	poor_range			binary_integer	:= 41;
	mixed_range			binary_integer	:= 42;
	wrong_range			binary_integer	:= 43;
	part_range			binary_integer	:= 44;
	full_range			binary_integer	:= 45;

	poor_address		binary_integer	:= 51;
	mixed_address		binary_integer	:= 52;
	wrong_address		binary_integer	:= 53;
	part_address		binary_integer	:= 54;
	full_address		binary_integer	:= 55;

--	============================================================

	street_match		binary_integer	:= 10;
	orphan_match		binary_integer	:= 20;
	block_match			binary_integer	:= 30;
	segment_match		binary_integer	:= 40;
	address_match		binary_integer	:= 50;

	poor_match			binary_integer	:= 01;
	mixed_match			binary_integer	:= 02;
	wrong_match			binary_integer	:= 03;
	partial_match		binary_integer	:= 04;
	full_match			binary_integer	:= 05;

--	========================================================================
--	street correction permission	(if basis score <= permit score)

--	permit_adr_basis		binary_integer	:= do_block;
--	permit_adr_change		binary_integer	:= base_match;

--	The results of "block" table matching is the "basis" for "permitting" address corrections.
--	If "no match" or "base match" occurred with the "block" table, 
--	then "permit change" of prefix, suffix, & type according to "address" table.

--	base match		match on name & binary_integer  (exact match, range match, 100-block match) 
--	part match		match on name & binary_integer, possibly incomplete, but no conflicts
--	full match		match on everything	(name, binary_integer, type, prefix, suffix)
--	========================================================================

	end;

