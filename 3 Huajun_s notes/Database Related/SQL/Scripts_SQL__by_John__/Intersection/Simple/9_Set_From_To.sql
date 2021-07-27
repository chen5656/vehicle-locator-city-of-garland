--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	2000;
set pagesize	9999;
--	===========================================================================================

DECLARE

	compile_only		integer 		:= 01;
	do_update			integer		:= 0;
	input_total			integer		:= 0;
	reverse_total		integer		:= 0;
	update_total		integer		:= 0;
	loops				integer		:= 1000;

	road_count			integer		:= 0;
	is_next_node		integer		:= 0;
	is_range_overlap		integer		:= 0;
	this_streetid		integer		:= -1;
	this_XY			varchar2(20)	:= ' ';

	mesg				varchar2(200);

	FC	gis.Feature_Coordinates%rowtype;
	ROAD1	gis.Road%rowtype;
	ROAD2	gis.Road%rowtype;

Cursor	READ_NODE	is

	select * from
(
	select
		r.streetid		streetid,
		f.X1||f.Y1		XY,
		r.rangeLO		range,
		r.rangeHI		opposite,
		'F'			endpoint,
		r.roadid		roadid,
		f.rowid		fc_rowid
		from	gis.FEATURE_COORDINATES		F,
			sde.ROAD_sde			R
		where	f.featureid	= r.roadid
		and	f.featureclass = 'ROAD'

	UNION ALL

	select
		r.streetid		streetid,
		f.X2||f.Y2		XY,
		r.rangeHI		range,
		r.rangeLO		opposite,
		'T'			endpoint,
		r.roadid		roadid,
		f.rowid		fc_rowid
		from	gis.FEATURE_COORDINATES		F,
			sde.ROAD_sde			R
		where	f.featureid = r.roadid
		and	f.featureclass = 'ROAD'
)
	order by 1,2,3;

	READ		read_node%rowtype;
	READ1		read_node%rowtype;
	READ2		read_node%rowtype;

BEGIN

	if	compile_only > 0		then
		return;
	end if;

	open Read_Node;
	read.XY		:= ' ';
	read.streetID	:= -1;

Loop

	if	this_streetid > 0		then
	if	road_count = 1		then
		select * into ROAD1 from gis.Road where roadid = read.roadid;
	else
		select * into ROAD2 from gis.Road where roadid = read.roadid;
	end if;		
	end if;

	if	read.streetid	> this_streetid
	or	read.XY		> this_XY			then
		is_next_node	:= 1;
	else
		is_next_node	:= 0;
	end if;

	mesg := null;
	if	road_count > 2		then
		mesg	:= 'More than 2 Road Segments';
	end if;

	if	is_next_node = 1
	and	road_count   = 2
	and((	read1.endpoint = 'F'	and read1.opposite > greatest	(read2.range, read2.opposite)	)
	or  (	read2.endpoint = 'T'	and read2.opposite < least	(read1.range, read1.opposite)	))	then
		mesg := 'Overlapping Road Segments ';
		is_range_overlap	:= 1;
	else
		is_range_overlap	:= 0;
	end if;
	
	if	mesg is not null		then
		select * into ROAD1 from gis.Road where roadid = fc.featureID;
		dbms_output.put_line ( mesg || '     at Node '    || this_XY 
		||'   '|| road1.rangelo ||'-'|| road1.rangehi ||' '|| road1.streetname
		||' & '|| road2.rangelo ||'-'|| road2.rangehi ||' '|| road2.streetname
		||'   '|| road1.roadid  ||'.'|| road2.roadid 
		);
	end if;


--	process previous street-node when a new one appears

	if	is_next_node 	 = 1
	and	road_count   	 = 2
	and	is_range_overlap	 = 0			then

		mesg := null;

		if	read1.endpoint = 'F'		then
			reverse_total := reverse_total + 01;
			select * into FC from gis.Feature_Coordinates where rowid = read1.fc_rowid; 

			if	do_update > 0		then
				update gis.Feature_Coordinates
				set	X1	= fc.X2,
					Y1	= fc.Y2,
					X2	= fc.X1,
					Y2	= fc.Y1
				where	rowid = read1.fc_rowid;
				update_total := update_total + 01;
			end if;

			mesg := 'Reversed Coordinates in ROAD1 ';
		end if;

		if	read2.endpoint = 'T'		then
			reverse_total := reverse_total + 01;
			select * into FC from gis.Feature_Coordinates where rowid = read2.fc_rowid; 

			if	do_update > 0		then
				update gis.Feature_Coordinates
				set	X1	= fc.X2,
					Y1	= fc.Y2,
					X2	= fc.X1,
					Y2	= fc.Y1
				where	rowid = read2.fc_rowid;
				update_total := update_total + 01;
			end if;

			mesg := 'Reversed Coordinates in ROAD2 ';
		end if;

		if	mesg is not null		then
			select * into ROAD1 from gis.Road where roadid = fc.featureID;
			dbms_output.put_line ( mesg || ' at Node '   || this_XY 
			||'   '|| road1.rangelo ||'-'|| road1.rangehi ||' '|| road1.streetname
			||' & '|| road2.rangelo ||'-'|| road2.rangehi ||' '|| road2.streetname
			||'   '|| road1.roadid	||'.'|| road2.roadid
			);
		end if;


	end if;

	if	is_next_node > 0		then
		this_streetid	:= read.streetid;	
		this_XY		:= read.XY;
		READ1			:= READ;
		road_count		:= 01;
	else
		READ2			:= READ;
		road_count		:= road_count + 01;
	end if;


--	if end of file occurred previously, then the final street-node was processed above

	exit when	Read_Node%notfound;

	fetch Read_Node	into Read;

	if	Read_Node%notfound			then
		read.streetid := 99999999;
	else
		input_total := input_total + 01;
	end if;
	
	loops	:= loops - 01;
	if	loops < 0		then
		dbms_output.put_line ( '*** ERROR *** Excessive Looping ');
		exit;
	end if;

end loop;

--	COMMIT;

	dbms_output.put_line ( '-----' );
	dbms_output.put_line ( 'Input   Total: ' || input_total );
	dbms_output.put_line ( 'Reverse Total: ' || reverse_total );
	dbms_output.put_line ( 'Update  Total: ' || update_total );

END;


--	===========================================================================================
/*

	gis.FEATURE_COORDINATES is built on the following assumptions:
		The 1st coordinates X1,Y1 correspond to RangeLO (the FROM Endpoint)
		The 2nd coordinates X2,Y2 correspond to RangeHI (the TO Endpoint)

	Consequently the TO endpoint of one segment would coincide with the FROM endpoint of the next segment.

		 1001         1030  1101            1130
		O------------------O--------------------O

	Sometimes these assumptions are not true.

	REVERSED COORDINATES

		The Road segment might have been drawn from the HI range to the LO range.
		In this case the values of X1,Y1 and X2,Y2 are in reverse order.

		In the example below, the 1st FROM endpoint coincides with the 2nd FROM endpoint.
		That's because the coordinates of the 1st segment are in reverse order.
		That's because the 1st segment was drawn from the TO endpoint to the FROM endpoint.


		  1030                       1001   1101                         1130
		O---------------------------------O----------------------------------O 
              X2,Y2                      X1,Y1   X1,Y1                      X2,Y2

	
		If the coordinate values of the 1st segment are flipped around,
		then the 1st segment will have a standardized configuration.
		1)	X2,Y2 of the 1st segment will match X1,Y1 of the 2nd segment
		2)	The TO endpoint of the 1st segment will meet the FROM endpoint of the 2nd segment.

		
	OVERLAPPING ROAD SEGMENTS

		Segments meet at a common XY coordinate, represented by a circle.

		READ1 should be "T"	(TO))
		READ2 should be "F"	(FROM)
		READ1 and READ2 are reversed because 1010 < 1020.

	
	  1001         "F"             1020		(READ2)	
	O-----------------------------------O	
							O-------------------------------------O

							  1010          "T"               1030	(READ1)

*/
--	===========================================================================================
