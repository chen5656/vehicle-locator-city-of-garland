	set echo 		off;
	set timing		off;
	set serveroutput	on		size 99999;
--	=====================================================================
--	routine called by VB "Address Finder"
--	=====================================================================

	drop view	garland.temp_view;

	create view	garland.temp_view	
(		 addr_num,	addr_pfx,	addr_name,	addr_type,	addr_sfx,	status, 	choice	)

	as	
	select item01,	item02,	item03,	item04,	item05,	item06,	item07	
	from	 garland.gis_objects;



--	=====================================================================
	truncate table	garland.gis_objects		reuse storage;
--	---------------------------------------------------------------------


	insert into garland.temp_view values ( '217', '', 'fifth', '', '',		'',''		);

	insert into garland.temp_view values ( '217', 's', 'fitfh', 'cir', '',		'',''		);

	insert into garland.temp_view values ( '1601', '', 'fores', '', '',		'',''		);

	insert into garland.temp_view values ( '601', '', 'wanlut', 'cr', '',		'',''		);

	insert into garland.temp_view values ( '301', '', 'woodaven', '', '',		'',''		);

	insert into garland.temp_view values ( '2110', '', 'glennbrook', '', '',	'',''		);

	insert into garland.temp_view values ( '4001', '', 'walling', '', '',		'',''		);
	insert into garland.temp_view values ( '5010', '', 'harth', '', '',		'',''		);

	insert into garland.temp_view values ( '2801', '', 'platto', '', '',		'',''		);

	insert into garland.temp_view values ( '2910', '', 'bag string', '', '',	'',''		);
	insert into garland.temp_view values ( '1501', '', 'kong', 'rd', '',		'',''		);

	insert into garland.temp_view values ( '501', '',  'wall', 'st', '',		'',''		);
	insert into garland.temp_view values ( '901', '',  'lynn', 'dr', '',		'',''		);
	insert into garland.temp_view values ( '901', '',  'ce ora', 'dr', '',		'',''		);

	insert into garland.temp_view values ( '', '', 	  'jutiper', '', '',		'',''		);


	insert into garland.temp_view values ( '105', '', 'ebancraft', '', '',		'',''		);
	insert into garland.temp_view values ( '105', '', 'ebamcraft', '', '',		'',''		);

	insert into garland.temp_view values ( '301', 'E', 'IH 30', '', '',		'',''		);

	insert into garland.temp_view values ( '310', '', 'west ih-30', '', '',		'parse',''	);
	insert into garland.temp_view values ( '310', '', 'west ih-30', '', '',		'',''		);


	insert into garland.temp_view values ( '601', '',  'maimed name', '', '',	'',''		);


	insert into garland.temp_view values ( '1601', '', 'glennbrook', '', '',	'near',''	);

	insert into garland.temp_view values ( '1601', '', 'glynbrook', '', '',		'far',''	);

	insert into garland.temp_view values ( '1601', '', 'glenbriik', '', '',		'name',''	);

--	-----------------------------------------------------------------------------------

	insert into garland.temp_view values ( '1234', '', '', '', '',		'',''			);



--	-----------------------------------------------------------------------------------
--	TESTS

--	insert into garland.temp_view values ( '1601', '', 'glenbriik', '', '',		'',''		);

--	-----------------------------------------------------------------------------------

	commit;

--	======================================================================================

	@c:\deacutis\scripts\Address_Resolve\Address_Finder\01_adrFinder_Execute.sql;

--	======================================================================================


