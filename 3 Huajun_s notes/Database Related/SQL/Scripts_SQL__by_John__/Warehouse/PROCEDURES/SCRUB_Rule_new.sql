--	=====================================================================

	create or replace view	garland.SCRUB_ADDRESS_RULE	as

--	=====================================================================

	select
	
--	none			 null,
--	no			 0,
--	yes			 1,

--	============================================================
--	steps 

	01			do_name,
	02			do_street,		
	03			do_address,
	04			do_block,
	00			do_range,

--	============================================================
--	functions

	01			do_unparsed_exit,
	01			do_parsed_exit,

	01			do_alien,

--	02			safe_parse
	01			do_parse,

--	1			alias_form,
--	2			alias_fuzzy,
--	3			alias_addr,
	alias_fuzzy		do_alias,

--	============================================================
--	name correction

	01			do_type_a,
	0			do_type_b,
	0			do_type_c,		

	03			do_alias_weight,

--	============================================================
--	street qualifier correction weights

--	10000			match,	
--	1000			blank,	
--	100			append,	
--	20			remove,	
--	15			change,	
--	3			append_unq,	
--	2			remove_unq,
--	1			change_unq,		

	append + remove + remove + 01		accept_weight, 

	remove_unq		str_unq_type,
	append_unq		str_unq_pfx,
	append_unq		str_unq_sfx,

	append		str_type,
	append		str_pfx,
	append		str_sfx,

	append		blk_type,
	append		blk_pfx,
	append		blk_sfx,

	append		adr_type,
	append		adr_pfx,
	append		adr_sfx,

	blank			rng_type,
	blank			rng_pfx,
	blank			rng_sfx,

--	============================================================
--	street correction permission

--	-1			forbid,
--	0			no_match,
--	1			base_match,	
--	2			part_match,	
--	3			all_match,
--	9			permit,

	none			permit_blk_basis,
	permit		permit_blk_append,
	permit		permit_blk_remove,
	permit		permit_blk_change,

	none			permit_adr_basis,
	permit		permit_adr_append,
	permit		permit_adr_remove,
	permit		permit_adr_change,

	none			permit_rng_basis,
	permit		permit_rng_append,
	permit		permit_rng_remove,
	permit		permit_rng_change,

--	============================================================
--	miscellaneous

--	1			reset_to_parsed,
	0			do_reset,

	200000		capacity,

	yes			keep_unparsed,
	yes			keep_parsed,

	''			parse_options,
	'.........'		parse_default,

--	============================================================

	'/'			mark_non_address,
	'$'			mark_non_garland,
	'?'			mark_non_correct,	
	'*'			mark_non_complete,

	'-'			mark_parse_undo,
	'='			mark_verify_only,
	'!'			mark_parse_error,

--	============================================================
--	verify codes

	00			non_address,
	01			non_garland,
	02			non_correct,
	03			non_complete,

	10			valid_name,
	11			poor_name,
	12			mixed_name,
	14			part_name,
	15			full_name,

	21			poor_orphan,
	22			mixed_orphan,	
	24			part_orphan,
	25			full_orphan,

	31			poor_block,
	32			mixed_block,
	33			wrong_block,
	34			part_block,
	35			full_block,

	41			poor_range,
	42			mixed_range,
	43			wrong_range,
	44			part_range,
	45			full_range,

	51			poor_address,
	52			mixed_address,
	53			wrong_address,
	54			part_address,
	55			full_address,

--	============================================================

	10			street_match,
	20			orphan_match,
	30			block_match,
	40			segment_match,
	50			address_match,

	01			poor_match,
	02			mixed_match,
	03			wrong_match,
	04			partial_match,
	05			full_match

--	========================================================================

	from 
(
	select
		null		none,
		0		no,
		1		yes,			

		1		alias_form,	
		2		alias_fuzzy,
		3		alias_addr,	

		10000		match,	
		1000		blank,	
		100		append,	
		20		remove,	
		15		change,	

		3		append_unq,	
		2		remove_unq,
		1		change_unq,		

		-1		forbid,
		0		no_match,
		1		base_match,	
		2		part_match,	
		3		all_match,
		9		permit,

		1		reset_to_parsed,

		null		dummy
	from dual
);

--	=====================================================================