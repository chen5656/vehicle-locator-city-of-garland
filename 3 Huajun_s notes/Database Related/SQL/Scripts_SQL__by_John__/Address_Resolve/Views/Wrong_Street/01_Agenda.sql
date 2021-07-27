
======================
HANDLING WRONG STREETS
======================

	x.	Display addresses from adrResult with a "wrong street"  (verify code = 53)

		Script:	\\address_resolve\81_Wrong_Street.sql;	(per control variable settings)

		Example:	217	S	Fifth		Cir		(wrong)
				217	N	Fifth		St		(right)

		The "wrong street" could be changed to the unique "right street" for "217 Fifth".
		However, changes should be made only per user or GIS discretion.
	

	x.	A list of user record keys having "wrong streets" is generated during address resolution

		Script:		\\address_resolve\alterations\00_make\make_wrong_street.sql

		Output:		\\address_resolve\alterations\wrong_street.sql


	x.	The above list can be used to choose which "wrong streets" should be corrected.	
		The list of record keys is used as a filter in the cursor:	read_adrResult
		Choose the keys to be updated by removing the SQL comment ("--").

		Script:	\\address_resolve\81_Wrong_Street_Choose.sql;	


	x.	In some cases, a decision may require more information from the application table(s).
		A special script can be written to populate the table GIS_Objects.

		table:	GIS_Objects	
		columns:	item01		record key
				item02		application info
				item03		application info


		This info will be displayed by the below script when show_info = 01 
		To suppress updating, set do_update & do_audit to zero.

		Script:	\\address_resolve\81_Wrong_Street_Choose.sql;	


====================================
CONTROL VARIABLES	in 81_Wrong_Street
====================================

	do_update		number		:= 0;		--	update address
	do_audit		number		:= 0;		--	update verify_code & correction audit

--	do_print		number		:= 00;	--	do not print
	do_print		number		:= 01;	--	print before & after address
--	do_print		number		:= 02;	--	print before & after & block options

	show_info		number		:= 01;	--	show application info on table GIS_OBJECTS

	per_block		number		:= 01;	--	update if only 1 valid block

	per_lowest		number		:= 01;	--	update if number within "tolerance" of lowest
	per_highest		number		:= 01;	--	update if number within "tolerance" of highest

	tolerance		number		:= 200;	--	max gap between addr_num and lowest addr_num
									--	for which street correction is permitted

	Note:

		do_print	shows before and after image of address to be corrected   (if do_print = 01)
		Optionally, it will also show all relevant 100 blocks for the address (if do_print = 02)


	Note:

		If neither do_update nor do_audit greater than zero, then no update will take place.
		Script will only display all possible "wrong street" corrections.

		If do_audit = 01, then the following changes will be made to adrResult indicators:

				1.	verify_code	will be set to 55  (valid address)
				2.	do_qual	will be updated to reflect the kinds of street changes made


	Example:

	"Tolerance" describes how far from the dividing line one should allow automated corrections.


				W Buckingham Rd			E Buckingham Rd
	----------------------------------------- | ------------------------------------------------------
				400	300	200	100		100	200	300	400

	

	Example:

	If "4321 N Country Club Rd" exists and no other "Country Club" street contains a 4000 block,
	then do the update if "per_block" is turned on (greater than zero).

