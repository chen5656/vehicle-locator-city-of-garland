	set echo	off;
--	============================================================

--	drop			package	garland.adr_resolve_rules;

	create or replace	package	garland.adr_resolve_rules   as
	
--	============================================================
--	"Full Run" address resolution rules
--	============================================================

	none		number	:= null;
	no		number	:= 0;
	yes		number	:= 1;			

--	============================================================
--	phase steps 

	do_name			number  	:= 01;
	do_street			number	:= 02;		
	do_block			number	:= 03;
	do_address			number	:= 04;
	do_range			number	:= 05;

--	============================================================
--	functions

	do_alien			number	:= 01;

		safe_parse		number	:= 02;
	do_parse			number	:= 01;

		alias_form		number	:= 1;
		alias_fuzzy		number	:= 2;
		alias_addr		number	:= 3;
	do_alias			number	:= 02;

	do_unparsed_exit		number	:= 01;
	do_parsed_exit		number	:= 01;

--	============================================================
--	name correction	(yes/no)

	do_type_A			number	:= 01;
	do_type_B			number	:= 01;
	do_type_C			number	:= 250;	-- max score

	do_alias_weight		number	:= 02;

--	============================================================
--	street qualifier correction 
--	(lower numbers indicate more radical modifications)

	match		number	:= 10000;	
	blank		number	:= 1000;	

	append	number	:= 100;	
	remove	number	:= 20;	
	change	number	:= 15;	

	append_unq	number	:= 3;	
	change_unq	number	:= 2;	
	remove_unq	number	:= 1;

		str_unq_type	number	:= remove_unq;
		str_unq_pfx		number	:= remove_unq;
		str_unq_sfx		number	:= append_unq;

		str_type		number	:= change;
		str_pfx		number	:= change;
		str_sfx		number	:= append;

		blk_type		number	:= append;
		blk_pfx		number	:= append;
		blk_sfx		number	:= append;

		adr_type		number	:= remove;
		adr_pfx		number	:= remove;
		adr_sfx		number	:= append;

		rng_type		number	:= blank;
		rng_pfx		number	:= blank;
		rng_sfx		number	:= blank;

--	============================================================
--	street qualifier permission							--

	forbid		number	:= -1;
	no_match		number	:= 0;
	base_match		number	:= 1;	
	part_match		number	:= 2;	
	all_match		number	:= 3;
	permit		number	:= 9;

		permit_blk_basis		number	:= none;
		permit_blk_append		number	:= permit;
		permit_blk_remove		number	:= permit;
		permit_blk_change		number	:= permit;

		permit_adr_basis		number	:= do_block;
		permit_adr_append		number	:= permit;
		permit_adr_remove		number	:= no_match;
		permit_adr_change		number	:= no_match;

		permit_rng_basis		number	:= none;
		permit_rng_append		number	:= permit;
		permit_rng_remove		number	:= permit;
		permit_rng_change		number	:= permit;

--	============================================================
--	miscellaneous

	reset_to_parsed		number		:= 1;
		do_reset		number		:= 0;

	capacity			number		:= 200000;

	keep_unparsed		number		:= yes;
	keep_parsed			number		:= yes;

	parse_options		varchar2(40)	:= '';
	parse_default		char(9)		:= '.........';

--	============================================================
--	markers

	mark_non_address		char		:= '/';
	mark_non_garland		char		:= '$';
	mark_non_correct		char		:= '?';	-- 'fores' 
	mark_non_complete		char		:= '*';

	mark_parse_undo		char		:= '-';
	mark_verify_only		char		:= '=';
	mark_parse_error		char		:= '!';

--	============================================================
--	verify codes

	non_address			number	:= 00;
	non_garland			number	:= 01;
	non_correct			number	:= 02;
	non_complete		number	:= 03;

	valid_name			number	:= 10;
	poor_name			number	:= 11;
	mixed_name			number	:= 12;
	part_name			number	:= 14;
	full_name			number	:= 15;

	poor_orphan			number	:= 21;
	mixed_orphan		number	:= 22;
	part_orphan			number	:= 24;
	full_orphan			number	:= 25;

	poor_block			number	:= 31;
	mixed_block			number	:= 32;
	wrong_block			number	:= 33;
	part_block			number	:= 34;
	full_block			number	:= 35;

	poor_range			number	:= 41;
	mixed_range			number	:= 42;
	wrong_range			number	:= 43;
	part_range			number	:= 44;
	full_range			number	:= 45;

	poor_address		number	:= 51;
	mixed_address		number	:= 52;
	wrong_address		number	:= 53;
	part_address		number	:= 54;
	full_address		number	:= 55;

--	============================================================
--	verify code components	

	street_match		number	:= 10;
	orphan_match		number	:= 20;
	block_match			number	:= 30;
	segment_match		number	:= 40;
	address_match		number	:= 50;

	poor_match			number	:= 01;
	mixed_match			number	:= 02;
	wrong_match			number	:= 03;
	partial_match		number	:= 04;
	full_match			number	:= 05;

--	========================================================================
--	street correction permission	(if basis score <= permit score)

--	Example
--	permit_adr_basis		number	:= do_block;
--	permit_adr_change		number	:= base_match;

--	The results of "block" table matching is the "basis for permitting address" modifications
--	If "no match" or "base match" occurred with the "block" table, 
--	then "permit change" of prefix, suffix, & type according to "address" table.

--	base match		match on name & number  (exact match, range match, 100-block match) 
--	part match		match on name & number, possibly incomplete, but no conflicts
--	full match		match on everything	(name, number, type, prefix, suffix)
--	========================================================================

--	possible rules
--	parse_signals		varchar2(20)	:= '&@/#';
--	parse_spacing		varchar2(20)	:= ',;' || chr(09);
--	========================================================================

	end;

