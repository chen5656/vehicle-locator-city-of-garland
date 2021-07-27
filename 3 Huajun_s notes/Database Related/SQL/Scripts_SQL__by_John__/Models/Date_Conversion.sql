	set echo	off;
--	===========================================================================
--	Convert Oracle date format	15-MAR_99  to   MAR-15-1999
--	Convert Oracle date format	15-MAR_00  to   MAR-15-2000
--	===========================================================================

	create or replace view		garland.Temp_View
	(
		user_date,
		current_yy
	)

	as	select	rtrim(occupant_dob), 
				04

	from	garland.addrvrfy;
		

--	===========================================================================
	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	explain plan set statement_id =  'xxx'	into garland.plan_table	for
--	===========================================================================

--	update garland.temp_view		T
--	set	user_date = 

(
	select
--			user_date,

		  	substr(user_date,04,03)	||'-'||

			substr(user_date,01,02)	||'-'||

			rtrim(to_number(year) + to_number(substr(user_date,08)))	formatted
	from
(

	select

		user_date,

		sign (substr(user_date,08) - 05),

		decode ( sign (substr(user_date,08) - CURRENT_YY ), +1, 1900, 2000 )	year,

		rowid		row_id

	from	garland.Temp_View
)

--	where	row_id = t.rowid

	where rownum < 11

)

--	where rownum < 11
	;


--	===========================================================================
--	show sample results

	select user_date
	from 	garland.Temp_View
	where	rownum < 11;

--	===========================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;

--	ROLLBACK;

	commit;
	alter rollback segment rb1 offline;
--	===========================================================================
	set echo	on;


