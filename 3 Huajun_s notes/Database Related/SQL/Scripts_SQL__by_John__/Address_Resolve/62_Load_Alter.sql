
	truncate table garland.adrAlter	reuse storage;

--	==============================================================================================

	select 'common place' " "	from dual;
	@c:\deacutis\scripts\address_resolve\alterations\02_Common\Common_Place.sql;
	commit;


	select 'common parsed' " "	from dual;
	@c:\deacutis\scripts\address_resolve\alterations\02_Common\Common_Parsed.sql;
	commit;


	select 'common unparsed' " "	from dual;
	@c:\deacutis\scripts\address_resolve\alterations\02_Common\Common_Unparsed.sql;
	commit;

	select 'debug parse' " "	from dual;
	@c:\deacutis\scripts\address_resolve\alterations\02_Common\Debug_Parse.sql;
	commit;

	select 'debug name' " "	from dual;
	@c:\deacutis\scripts\address_resolve\alterations\02_Common\Debug_Name.sql;
	commit;

	select 'special correction' " "	from dual;
	@c:\deacutis\scripts\address_resolve\alterations\01_Load\90_Special.sql;
	commit;

--	==============================================================================================

	select 'non address' " "	from dual;
	@c:\deacutis\scripts\address_resolve\alterations\01_Load\00_Non_Address.sql;
	commit;

	select 'non garland' " "	from dual;
	@c:\deacutis\scripts\address_resolve\alterations\01_Load\01_Non_Garland.sql;
	commit;

--	select 'non correct' " "	from dual;
--	@c:\deacutis\scripts\address_resolve\alterations\01_Load\02_Non_Correct.sql;
--	commit;

--	select 'non complete' " "	from dual;
--	@c:\deacutis\scripts\address_resolve\alterations\01_Load\03_Non_Complete.sql;
--	commit;

--	==============================================================================================

	select 'type A' " "		from dual;
	@c:\deacutis\scripts\address_resolve\alterations\01_Load\Type_A_Name.sql;
	commit;

	select 'type B' " "		from dual;
	@c:\deacutis\scripts\address_resolve\alterations\01_Load\Type_B_Name.sql;
	commit;

	select 'type C' " "		from dual;
	@c:\deacutis\scripts\address_resolve\alterations\01_Load\Type_C_Name.sql;
	commit;

--	==============================================================================================

	select 'alias name' " "		from dual;
	@c:\deacutis\scripts\address_resolve\alterations\01_Load\Alias_Name.sql;
	commit;

	select 'alien name' " "		from dual;
	@c:\deacutis\scripts\address_resolve\alterations\01_Load\Alien_Name.sql;
	commit;

--	==============================================================================================
/*

	select 'special' " "		from dual;
	@c:\deacutis\scripts\address_resolve\alterations\01_Load\99_SPECIAL.sql;
	commit;

	select 'no number' " "		from dual;
	@c:\deacutis\scripts\address_resolve\alterations\01_Load\10_No_Number.sql;
	commit;

	select 'bad block' " "		from dual;
	@c:\deacutis\scripts\address_resolve\alterations\01_Load\20_Bad_Block.sql;
	commit;

	select 'bad range' " " 		from dual;
	@c:\deacutis\scripts\address_resolve\alterations\01_Load\30_Bad_Range.sql;
	commit;

	select 'good range' " "		from dual;
	@c:\deacutis\scripts\address_resolve\alterations\01_Load\40_Good_Range.sql;
	commit;

	select 'good number' " "	from dual;
	@c:\deacutis\scripts\address_resolve\alterations\01_Load\50_Good_Number.sql;
	commit;

*/

--	==============================================================================================
--	what are duplicate NAME2 corrections
--	==============================================================================================

	select * 
	from garland.adrAlter
	where	name1 is null
	and	lower(name2) in
(
	select lower(name2)
	from	garland.adrAlter
	group by lower(name2)
	having count(*) > 1
);

--	==============================================================================================
--	what are duplicate NAME1 corrections
--	==============================================================================================

	select * 
	from garland.adrAlter
	where	name1 is null
	and	lower(name1) in
(
	select lower(name1)
	from	garland.adrAlter
	group by lower(name1)
	having count(*) > 1
);

--	=====================================================
	set echo on;

