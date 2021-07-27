	set echo	off;
--	====================================================================

	truncate table	gis_objects		reuse storage;

	insert into gis_objects ( item01, item02)
	select distinct alias_how, alias_weight	from adrAlias;
	commit;

--	====================================================================

	select 

		decode (verify_code, 55, 'V', ' ')							verify,

		decode (do_name, ' ', 0, 'A',1, 2)							name,

		9 - item02											alias,

		decode (translate(lower(do_parse), 'X.npmt', 'X'), null,0, 1)		parse,

		(length(do_qual) - length (replace (do_qual, 'at'))) / 2 * 1
			+
		(length(do_qual) - length (replace (do_qual, 'ap'))) / 2 * 2
			+
		(length(do_qual) - length (replace (do_qual, 'as'))) / 2 * 3
			+
		(length(do_qual) - length (replace (do_qual, 'rt'))) / 2 * 10
			+
		(length(do_qual) - length (replace (do_qual, 'rp'))) / 2 * 20
			+
		(length(do_qual) - length (replace (do_qual, 'rs'))) / 2 * 30
			+
		(length(do_qual) - length (replace (do_qual, 'ct'))) / 2 * 100
			+
		(length(do_qual) - length (replace (do_qual, 'cp'))) / 2 * 200
			+
		(length(do_qual) - length (replace (do_qual, 'cs'))) / 2 * 300

														street,
		rec_key

--		,'|||'

		,do_qual
		,do_parse

		
	from	adrResult		R,
		gis_objects		A

	where	r.do_alias = a.item01 (+)

--	and	verify_code < 55
	and	do_qual > ' '
--	and	a.item02 < 8		-- alias weight

	and	rownum < 111
	;

--	====================================================================


--	mark	rec_key	appl		nulls
--	ver	score		addr		flags


--	====================================================================

--	select distinct do_qual from adrResult;

--	====================================================================
	set echo	on;


