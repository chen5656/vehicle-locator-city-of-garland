	set echo		off;
	set termout		off;
	set charwidth	300;
	set fetchrows	1000;		--	prevent prohibitively large output

--	===================================================================================
--	create adrAlter Insert command files
--	===================================================================================

	@c:\deacutis\scripts\address_resolve\alterations\00_make\make_00_Non_Address.sql;

	@c:\deacutis\scripts\address_resolve\alterations\00_make\make_01_Non_Garland.sql;

	@c:\deacutis\scripts\address_resolve\alterations\00_make\make_02_Non_Correct.sql;

	@c:\deacutis\scripts\address_resolve\alterations\00_make\make_03_Non_Complete.sql;


	@c:\deacutis\scripts\address_resolve\alterations\00_make\make_Type_A_Name.sql;

	@c:\deacutis\scripts\address_resolve\alterations\00_make\make_Type_B_Name.sql;

	@c:\deacutis\scripts\address_resolve\alterations\00_make\make_Type_C_Name.sql;


	@c:\deacutis\scripts\address_resolve\alterations\00_make\make_Alias_Name.sql;

	@c:\deacutis\scripts\address_resolve\alterations\00_make\make_Alien_Name.sql;

	@c:\deacutis\scripts\address_resolve\alterations\00_make\make_Like_Name.sql;

--	===================================================================================

	@c:\deacutis\scripts\address_resolve\alterations\00_make\make_Wrong_Street.sql;

--	===================================================================================
/*	
--	CAUTION:	May generate very, very large command files

	@c:\deacutis\scripts\address_resolve\alterations\00_make\make_20_Bad_Block.sql;

	@c:\deacutis\scripts\address_resolve\alterations\00_make\make_30_Bad_Range.sql;

	@c:\deacutis\scripts\address_resolve\alterations\00_make\make_40_Good_Range.sql;

	@c:\deacutis\scripts\address_resolve\alterations\00_make\make_50_Good_Number.sql;

*/
--	===================================================================================

	set termout		on;
	set echo		on;
	set charwidth;
	set fetchrows;
