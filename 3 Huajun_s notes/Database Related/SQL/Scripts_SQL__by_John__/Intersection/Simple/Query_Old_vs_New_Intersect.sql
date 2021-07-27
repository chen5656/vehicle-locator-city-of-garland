	set echo off;

	select
		rpad(s1_addr_name,  20)		name1,
		rpad(s1_addr_type,  05)		type1,
		rpad(s1_addr_pfx,   04)		pre1,
		rpad(s1_addr_sfx,   04)		suf1,
		rpad(s1_addr_block, 05)		blok1,

		rpad(s2_addr_name,  20)		name2,
		rpad(s2_addr_type,  05)		type2,
		rpad(s2_addr_pfx,   04)		pre2,
		rpad(s2_addr_sfx,   04)		suf2,
		rpad(s2_addr_block, 05)		blok2,

		lpad(node_id,	  05)		node

	from	garland.Temp_View

	where	rownum < 11
	;

	set echo on;
