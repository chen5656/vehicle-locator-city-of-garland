	set echo	off;
--	=======================================================
--	EXECUTE ON GIS SERVER	<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--	=======================================================

--	Legal Descriptions should already be assigned from DCAD table (\\Region\Update_Legal_desc.sql)
--	This job simply cleans up the Lot & Block info
--	=============================================================

--	truncate table	plan_table;
--	explain plan	set statement_id = 'a'		for

--	=======================================================

	update	garland.nsa_crime			C

	set		legal2 =
(
	select	y.legal		from
(
	select x.row_id,

		 ltrim   (
		 replace (
		 replace (
		 replace (
		 replace (x.leg, 'LOT', lpad('LOT', 20 - instr (x.leg,'LOT'))),		-- ((16 - instr) + 1 + 3)
			   '   ',' '),	
			   '  ', ' '),	
			   '  ', ' ')
			   )					LEGAL
	from
(
	select rowid	row_id,

		replace (
		replace (	
		replace (	
		replace (	legal2,	

				'LT',  'LOT'	),
				' LK', 'BLK'	),	
				' 0',  ' '		),
				' 0',  ' '		)
								LEG
	from	garland.nsa_crime
)								X

)								Y

	where	c.rowid = y.row_id

--	where	rownum < 1111
);

--	=======================================================

--	select * from explain_plan;

--	select * from explain_indexed;
--	select * from explain_constraint;
--	select * from explain_table;
--	select * from explain_index;
--	select * from explain_analyze;
--	select * from explain_cost;

--	=======================================================
	set echo	on;
