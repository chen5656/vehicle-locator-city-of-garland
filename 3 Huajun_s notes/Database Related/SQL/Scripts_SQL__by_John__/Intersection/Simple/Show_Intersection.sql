	set echo off;

	select
		rpad(strname1, 20)	name1,
		rpad(strtype1, 05)	type1,
		rpad(strpre1,  04)	pre1,
		rpad(strsuf1,  04)	suf1,
		rpad(strblok1, 05)	blok1,

		rpad(strname2, 20)	name2,
		rpad(strtype2, 05)	type2,
		rpad(strpre2,  04)	pre2,
		rpad(strsuf2,  04)	suf2,
		rpad(strblok2, 05)	blok2,

		rpad(intersect_type,4)	type,

		rpad(node_id, 05)		node

	from	garland.Temp_View4

	where	rownum < 111

	and	intersect_type = 'SS'

	order by	strname1, strname2
	;
