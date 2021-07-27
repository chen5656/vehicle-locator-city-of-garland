--	===================================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';
--	===================================================================================

--	Extract WATER PIPE Feature Coordinates

--	SEE  SDE\EXTRACT\EXTRACT_SDE_COORDINATES

--	===================================================================================
/*
	Extract line feature first/last coordinates from
	TOOLBOX > SAMPLES > DATA MGMT > FEATURES > "Write Features to Text File"
	Copy Extract to EXTERNAL file (gis-2k3-dbs)
	View definition		\\deacutis\load_external\EXTERNAL_VIEW1
	External record is defined as a single text field which is parsed by this program.

	A single objectid might be grouped into multiple SECTIONS within EXTERNAL_VIEW1.
	So TOTAL SECTIONS > TOTAL INSERTS

	PROBLEM:	Run ESRI extract > Compress > Run Coordinate extract
			Then current Line feature contains more objectids than Coordinate extract

	Sample:	water pipe objectid=8510 feature_id=181320 has 13 sections in the external view
*/
--	===================================================================================

	DELETE	from	gis.FEATURE_COORDINATES		where FeatureClass = 'WTPI';
	COMMIT;

--	TRUNCATE table	gis.FEATURE_COORDINATES		reuse storage;

--	===================================================================================
--	This is the SDE Line Feature for which the Coordinate extract was generated

	create or replace view	jdeacutis.Temp_View	as
	select
		t.objectid,
		t.feature_id,
		t.PIPE_ID		utility_id,
		'WTPI'		feature_class,
		round(f.len)	lengths
	from	gis.WATER_PIPE			T,
		jdeacutis.WATER_PIPE_FTable	F
	where	t.shape = f.fid;

--	===================================================================================
--	The is the view of the external table having the coordinates

	drop table		jdeacutis.EXTERNAL_VIEW1;
	create table	jdeacutis.EXTERNAL_VIEW1
(
	TEXT	varchar2(100)   
)
	organization external
(
	type oracle_loader
	default directory	EXT_TABLES
	access parameters
(
	records delimited by newline
	fields terminated by '|'
	optionally enclosed by '"'
)
	location ('WATER_PIPE_COORDS.txt')
)
	reject limit 999;

--	===================================================================================

	select to_char(sysdate, 'hh24:mi:ss') || '   START' " " from dual;

--	===================================================================================

declare
	compile_only	integer	:= 0;

	do_insert		integer	:= 01;
--	do_insert = yes/no

	factor		integer	:= 01;	
--	factor  = multiplier of coordinate value (eg. include decimals)

	do_test		integer	:= null;
--	do_test = null or max input count

	is_eof		integer	:= 0;
	input_count		integer	:= 0;
	section_count	integer	:= 0;
	output_count	integer	:= 0;
	counter		integer	:= 0;

	line_rec			varchar2(200);
	read_objectid		varchar2(20);
	this_objectid		varchar2(20);
	this_feature_id		varchar2(20);
	this_feature_class	varchar2(20);
	this_utility_id		varchar2(20);
	this_lengths		varchar2(20);

	xcoord		number;
	ycoord		number;
	xcoord1		number;
	ycoord1		number;
	xcoord2		number;
	ycoord2		number;

	coord_count		integer;
	locate		integer;
	width			integer;

	loop1			integer	:= 100000;
	loop2			integer	:= 100;
	loop3			integer	:= 1000;
	loops2		integer;
	loops3		integer;

cursor	READ_LINE_XY is select Text from JDEACUTIS.EXTERNAL_VIEW1;

begin
	if	compile_only > 0	then
		return;
	end if;

--	line 1 = 'polyline'
--	line 2 = objectid
	open	READ_LINE_XY;
	fetch	READ_LINE_XY	into line_rec;
	fetch	READ_LINE_XY	into line_rec;

	if	READ_LINE_XY%found		then
		null;
	else
		dbms_output.put_line ('*** ERROR ***  INPUT FILE IS EMPTY '); 
		return;
	end if;

	if	instr(line_rec,' ',1,2) = 0	then
		read_objectid	:= substr(line_rec,1,instr(line_rec,' ') - 1);
		section_count	:= section_count + 01;
		input_count		:= input_count + 01;
	else
		dbms_output.put_line ('*** ERROR *** MISSING INITIAL OBJECTID');
		return;
	end if;

while	is_eof = 0	loop

	loop1 := loop1 - 01;
	if	loop1 < 0		then
		dbms_output.put_line ('LOOPING 1');
		return;
	end if;

	this_objectid	:= read_objectid;
	section_count	:= section_count + 01;

	loops2 := loop2;
while read_objectid = this_objectid		loop

	loops2 := loops2 - 01;
	if	loops2 < 0				then
		dbms_output.put_line ('LOOPING 2');
		return;
	end if;

	fetch READ_LINE_XY  into line_rec;
	if	line_rec not like '%QNAN'	then
		dbms_output.put_line ('*** ERROR ***  NO COORDINATES FOR OBJECTID: ' || read_objectid);
		return;
	end if;	

	input_count	:= input_count + 01;
	coord_count	:= 0;

	loops3 := loop3;
while line_rec like '%QNAN'			loop

	loops3 := loops3 - 01;
	if	loops3 < 0		then
		dbms_output.put_line ('LOOPING 3');
		return;
	end if;

	locate	:= instr(line_rec, ' ',1,1) + 1;
	width		:= instr(line_rec, ' ',locate) - locate;
	XCOORD	:= substr(line_rec,locate,width) + 0;

	locate	:= instr(line_rec, ' ', 1,2) + 1;
	width		:= instr(line_rec, ' ',locate) - locate;
	YCOORD	:= substr(line_rec,locate,width) + 0;

	xcoord	:= round(xcoord * factor);
	ycoord	:= round(ycoord * factor);

	coord_count := coord_count + 01;
	if	coord_count = 1			then
		xcoord1	:= xcoord;
		ycoord1	:= ycoord;
	else
		xcoord2	:= xcoord;
		ycoord2	:= ycoord;
	end if;

	fetch READ_LINE_XY  into line_rec;

	if	line_rec = 'END'
	or	READ_LINE_XY%notfound
	or	input_count > do_test			then
		is_eof 		:= 1;
		read_objectid	:= null;
		exit;
	end if;

	input_count := input_count + 01;

end loop;

	if	read_objectid is null			then
		exit;
	elsif	instr(line_rec,' ',1,2) = 0		then
		read_objectid	:= substr(line_rec,1,instr(line_rec,' ') - 1);
	else
		dbms_output.put_line ('*** ERROR *** MISSING OBJECTID AFTER ' || this_objectid );
		return;
	end if;

end loop;

	select feature_class, feature_id, utility_id, lengths 
	into	 this_feature_class, this_feature_id, this_utility_id, this_lengths  
	from jdeacutis.Temp_View
	where objectid = this_objectid;

	if	do_test > 0		then
	DBMS_OUTPUT.PUT_LINE ('class=' ||this_feature_class|| '  fid=' ||this_feature_id|| '  uid=' ||this_utility_id 
	' lengths=' ||this_lengths||'   ' ||xcoord1||','||ycoord1||','||xcoord2||','||ycoord2);
	end if;

	if	do_insert > 0				then
		INSERT into gis.FEATURE_COORDINATES	values
		(this_feature_class, this_utility_id, this_feature_id, xcoord1, ycoord1, xcoord2, ycoord2, null, this_lengths);  
		output_count := output_count + 01;
	end if;

end loop;

	COMMIT;

	dbms_output.put_line (' ');
	dbms_output.put_line ('TOTAL INPUT    ' || input_count); 
	dbms_output.put_line ('TOTAL SECTIONS ' || section_count); 
	dbms_output.put_line ('TOTAL INSERTS  ' || output_count); 

	select count(*) into counter from (select featureid from gis.feature_coordinates 
	where featureclass='WTPI' group by featureid having count(*) > 1);
   	dbms_output.put_line ('TOTAL DUPES    ' || counter); 

	select count(*) into counter from jdeacutis.TEMP_VIEW;
   	dbms_output.put_line ('TOTAL FEATURE  ' || counter); 
end;
