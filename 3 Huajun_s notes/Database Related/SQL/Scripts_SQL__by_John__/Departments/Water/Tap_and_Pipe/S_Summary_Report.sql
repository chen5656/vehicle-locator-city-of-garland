	set echo off;
--	======================================================================
--	TAP & PIPE COUNTS

	select count (distinct tap_id)	taps		from garland.temp_view1;
	select count (distinct pipe_id)	pipes		from garland.temp_view1;
	select count(*)				tappipe	from garland.temp_view1;
	select count(*)				nodrop	from garland.temp_view1	where drop_length = 0;

	select count(count(*)) 			dupes		from garland.temp_view1
		 group by tap_id	having count(*) > 1;

--	======================================================================
--	Arm Lengths

	select	'ARMS LENGTH' " ",
			min(arm_length)			minimum, 
			max(arm_length)			maximum, 
			count(distinct arm_length)	distincts
	from
(
	select trunc(arms_length)	arm_length, 
		 count(*)			counter
	from	garland.temp_view1
	group by trunc(arms_length)
);

--	----------------------------------------------------------------------
--	Drop Lengths

	select	'DROP LENGTH' " ",
			min(droplength)			minimum, 
			max(droplength)			maximum, 
			count(distinct droplength)	distincts
	from
(
	select trunc(drop_length)	droplength, 
		 count(*)			counter
	from	garland.temp_view1
	group by trunc(drop_length)
);

--	----------------------------------------------------------------------
--	Extend Lengths

	select	'EXTEND LENGTH' " ",
			min(extendlength)			minimum, 
			max(extendlength)			maximum, 
			count(distinct extendlength)	distincts
	from
(
	select round(extend_length)	extendlength, 
		 count(*)			counter
	from	garland.temp_view1
	group by round(extend_length)
);

--	======================================================================
--	ZERO DROP 

	select lpad(tap_id, 10)		tap_id,
		 lpad(pipe_id,10)		pipe_id,
		 lpad(drop_length,10)	drop_leng
	from	garland.temp_view1
	where	drop_length = 0
	order by 1,2;

--	======================================================================
--	DUPLICATE TAPS

	select lpad(tap_id,10)		tap_id,
		 count(*) 			counter
	from	garland.temp_view1
	group by tap_id
	having count(*) > 1;

--	----------------------------------------------------------------------
	set echo on;



