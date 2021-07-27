	set echo 		on;
	set charwidth	400;
	set serveroutput	on;
--	=======================================================================================
--	Measure proximity Water Pipes to Water Taps
--		An "ARM" measures the distance from a Tap to one end of a Pipe
--		A line is dropped from a "DROP" point on the a Pipe to a Tap
--		The Drop line is then "EXTENDed" beyond the Tap into the Parcel
--		Each of the above factors has coordinates and/or length
--	=======================================================================================
--	TASKS
--	============================================================
--	Define View

--	@c:\deacutis\scripts\departments\water\tap_and_pipe\F_APP_ROWID.sql

--	@c:\deacutis\scripts\departments\water\tap_and_pipe\F_PIPE_TAP_PROXIMITY_VIEW.sql

--	=======================================================================================

--	Truncate table	garland.GIS_Temp4		reuse storage;

--	=======================================================================================

declare

	do_compile		binary_integer	:= 0;

	read_seq		binary_integer	:= 0;
	input_count		binary_integer	:= 0;	
	output_count	binary_integer	:= 0;
	beyond_count	binary_integer	:= 0;
	print_count		binary_integer	:= 10;

	trace			binary_integer;
	spec_extend		number;

	inner1		number;	-- vector inner product
	inner2		number;

	arm1_dx		number;
	arm1_dy		number;
	arm2_dx		number;
	arm2_dy		number;
	arm1_length		number;
	arm2_length		number;
	arms_length		number;

	pipe_dx		number;
	pipe_dy		number;
	pipe_slope		number;
	pipe_intercept	number;
	pipe_length		number;

	drop_dx		number;
	drop_dy		number;
	drop_x		number;
	drop_y		number;
	drop_slope		number;
	drop_intercept	number;
	drop_length		number;

	extend_dx		number;
	extend_dy		number;
	extend_x		number;
	extend_y		number;
	extend_slope	number;
	extend_length	number;

	read_tap_id		binary_integer;
	read_pipe_id	binary_integer;
	read_tap_x		number;
	read_tap_y		number;
	read_pipe_x1	number;
	read_pipe_y1	number;
	read_pipe_x2	number;
	read_pipe_y2	number;

--	=========================================================

cursor	Read_Pipe_Near_Tap	is

		select p.*
		from	garland.gis_app_rowid	G,
			garland.Temp_View3	P
		where	g.row_seq	= read_seq
		and	g.row_id	= p.rowid;

	READ	Read_Pipe_Near_Tap%rowtype;

--	=========================================================

begin

	if	do_compile > 0		then
		return;
	end if;

	select extend	
	into	 spec_extend	
	from	garland.Temp_View;

loop

	read_seq	:= read_seq + 01;

--	EXIT WHEN READ_SEQ > 1000;			-- T E S T I N G

	open	read_pipe_near_tap;
	fetch	read_pipe_near_tap			into READ;
	if	read_pipe_near_tap%notfound 
	or	read_pipe_near_tap%notfound is null		then
		exit;
	end if;
	close	read_pipe_near_tap;

	input_count 	:= input_count + 01;

	read_tap_id		:= read.tap_id;
	read_pipe_id	:= read.pipe_id;
	read_tap_x		:= read.tap_x;
	read_tap_y		:= read.tap_y;
	read_pipe_x1	:= read.pipe_x1;
	read_pipe_y1	:= read.pipe_y1;
	read_pipe_x2	:= read.pipe_x2;
	read_pipe_y2	:= read.pipe_y2;

--	=========================================================

	trace	:= 0;

	arm1_dx		:= read_tap_x - read_pipe_x1;
	arm1_dy		:= read_tap_y - read_pipe_y1;
	arm2_dx		:= read_tap_x - read_pipe_x2;
	arm2_dy		:= read_tap_y - read_pipe_y2;
	arm1_length		:= sqrt((arm1_dx * arm1_dx) + (arm1_dy * arm1_dy));
	arm2_length		:= sqrt((arm2_dx * arm2_dx) + (arm2_dy * arm2_dy));
	arms_length		:= arm1_length + arm2_length;

	pipe_dx		:= read_pipe_x2 - read_pipe_x1;
	pipe_dy		:= read_pipe_y2 - read_pipe_y1;
	pipe_length		:= sqrt( (pipe_dx * pipe_dx) + (pipe_dy * pipe_dy) );

	if	pipe_dx = 0				then
		pipe_slope		:= null;
		pipe_intercept	:= null;
	else
		pipe_slope		:= pipe_dy / pipe_dx;
		pipe_intercept	:= read_pipe_y1 - (pipe_slope * read_pipe_x1);
	end if;

	if	read_pipe_x1 = read_pipe_x2	then
		drop_length	:= read_tap_x - read_pipe_x1;
		extend_dx	:= sign(drop_length) * spec_extend;
		extend_dy	:= 0;
		trace		:= 1;
		goto	output_result;

	elsif	read_pipe_y1 = read_pipe_y2	then
		drop_length	:= read_tap_y - read_pipe_y1;
		extend_dy	:= sign(drop_length) * spec_extend;
		extend_dx	:= 0;
		trace		:= 2;
		goto	output_result;
	end if;

--	=========================================================
--	does the tap lie beyond the end of the pipe

	inner1 :=  (pipe_dx * arm1_dx) +  (pipe_dy * arm1_dy);
	inner2 := -(pipe_dx * arm2_dx) + -(pipe_dy * arm2_dy);

	if	inner1 * inner2 > 0			then
		beyond_count := beyond_count + 01;

		if	abs(inner1) < abs(inner2)	then
			drop_x	:= read_pipe_x1;
			drop_y	:= read_pipe_y1;
			trace		:= trace + 10;
		else
			drop_x	:= read_pipe_x2;
			drop_y	:= read_pipe_y2;
			trace		:= trace + 20;
		end if;

		goto	calc_extension;
	end if;

--	=========================================================

	drop_slope		:= - 1 / pipe_slope;
	drop_intercept	:= read_tap_y - (drop_slope * read_tap_x);
	drop_x		:= (pipe_intercept - drop_intercept) / (drop_slope - pipe_slope);
	drop_y		:= (drop_slope * drop_x) + drop_intercept;

--	=========================================================

<<calc_extension>>

	drop_dx	:= read_tap_x - drop_x;
	drop_dy	:= read_tap_y - drop_y;
	drop_length	:= sqrt((drop_dx * drop_dx) + (drop_dy * drop_dy));

	if	drop_dx = 0			then
		extend_dx		:= 0;
		extend_dy		:= sign(drop_dy) * spec_extend;
		trace			:= trace + 100;
	else
		extend_slope	:= drop_dy / drop_dx;
		extend_dx		:= sqrt( (spec_extend * spec_extend) / (1 + (extend_slope * extend_slope)) );
		extend_dy		:= extend_slope * extend_dx;
	end if;

--	=========================================================
<<output_result>>
	
	extend_x		:= read_tap_x + extend_dx;
	extend_y		:= read_tap_y + extend_dy;
	extend_length	:= sqrt((extend_dx * extend_dx) + (extend_dy * extend_dy));

	insert into garland.Temp_View4	values
(
	lpad(read_tap_id, 	6,'0'),
	lpad(read_pipe_id,	6,'0'),

	lpad(round(extend_x),	7,'0'),
	lpad(round(extend_y),	7,'0'),
	lpad(round(drop_x),	7,'0'),
	lpad(round(drop_y),	7,'0'),
	lpad(round(read_tap_x),	7,'0'),
	lpad(round(read_tap_y),	7,'0'),

	lpad(round(pipe_length),7,'0'),
	lpad(round(abs(arm1_length) + abs(arm2_length)), 7,'0'),
	lpad(round(abs(drop_length)),	  7,'0'),
	lpad(round(abs(extend_length)), 7,'0')
);

	commit;

	output_count := output_count + 01;

--	------------------------------------------------------
--	TEST DISPLAY

	if	extend_length 				> 20
	or	abs(drop_length)  			> 2000
	or	abs(arms_length - pipe_length)	> 2000

	then	

	dbms_output.put_line (
	'tap pipe arm inner '			||
	lpad(read_tap_id,	   10)		||		
	lpad(read_pipe_id,   10)		||	
	lpad(' ',		   10)		||	
	lpad(round(arms_length),10)		||	
	lpad(' ',		   10)		||	
	lpad(round(inner1),  10)		||	
	lpad(round(inner2),  10)	
	);

	dbms_output.put_line (
	'pipe: dd sli       '			||
	lpad(round(pipe_dx),	   10)	||		
	lpad(round(pipe_dy),	   10)	||	
	lpad(round(pipe_slope),	   10)	||		
	lpad(round(pipe_length),   10)	||
	lpad(round(pipe_intercept),10)
	);

	dbms_output.put_line (
	'drop: dd sli xy    '			||
	lpad(round(drop_dx),	  10)		||		
	lpad(round(drop_dy),	  10)		||		
	lpad(round(drop_slope),	  10)		||		
	lpad(round(drop_length),  10)		||		
	lpad(round(drop_intercept),10)	||	
	lpad(round(drop_x),	  10)		||		
	lpad(round(drop_y),	  10)
	);

	dbms_output.put_line (
	'extd: dd sl_  xy   '			||
	lpad(round(extend_dx),	  10)		||		
	lpad(round(extend_dy),	  10)		||			
	lpad(round(extend_slope), 10)		||	
	lpad(round(extend_length),10)		||	
	lpad(' ',			  10)		||	
	lpad(round(extend_x),	  10)		||	
	lpad(round(extend_y),	  10)	
	);

	dbms_output.put_line (
	'read: trc p1 tap p2'		||
	lpad(trace, 	 10)		||
	lpad(read_pipe_x1, 10)		||		
	lpad(read_tap_x,	 10)		||		
	lpad(read_pipe_x2, 10)		||		
	lpad(read_pipe_y1, 10)		||		
	lpad(read_tap_y,	 10)		||		
	lpad(read_pipe_y2, 10)		
	);

	dbms_output.put_line (' ');

	print_count	:= print_count - 01;
	exit when	   print_count < 01;

	end if;

--	------------------------------------------------------

<<end_loop>>
	null;

end loop;	

	dbms_output.put_line (' ');
	dbms_output.put_line ('MEASURE PROXIMITY OF WATER PIPES TO WATER TAPS');
	dbms_output.put_line ('Input  Count = '	|| input_count);
	dbms_output.put_line ('Output Count = '	|| output_count);
	dbms_output.put_line ('Beyond Count = '	|| beyond_count);

end;




