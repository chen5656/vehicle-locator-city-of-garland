--	=====================================================================
	select * from viewer.me;
	BEGIN  TEST TEST TEST TEST TEST  TEST TEST TEST TEST TEST  TEST TEST TEST TEST TEST  END;
set	TIMING		OFF;
set	sqlblanklines	on;
set	serveroutput	on	size 99999;
set	linesize		1000;
set	pagesize		0000;
--	execute jdeacutis.show_table_column	('', '', '');
--	execute jdeacutis.show_source		('test_proc', 'jdeacutis', '');
--	execute jdeacutis.show_error		('test_proc', 'jdeacutis', '');
--	execute jdeacutis.show_view		('', '', '');
--	execute jdeacutis.show_index_column	('', '', '');
--	SELECT  to_char(sysdate,'Mon dd,yyyy hh24:mi')||'  ***  ' " "  from dual;
--	EXECUTE jdeacutis.TEST_PROC;
--	CREATE or replace procedure jdeacutis.TEST_PROC  as
--	DECLARE
--	=====================================================================	
--	=======================================================
--	calculate SHAPEPTSBUFSIZE
--	managing arcsde application servers  p.30
--	=======================================================

--	drop synonym	gis.temp_syn;
--	create synonym	gis.temp_syn	for gis.F774;

--	=======================================================

declare
	compile_only		integer	:= 0;
	file_size		integer;	-- total record count
	max_points		integer;	-- max points in a single record
	sample_pct		integer;	-- pct of max_points
	sample_points		integer;	-- number of points per sample pct
	sample_size		integer;	-- sample count having sample_points
	pct_change		integer;	-- change in sample_pct
	min_change		integer;	-- minimum change in sample_pct
	vector			integer;	-- increase/decrease the percent
	script			varchar2(200);
	layer_name		varchar2(40);
	feature_name		varchar2(40)	:= 'WATER_PIPE';
	ideal_pct		number		:= 0.90;
	safety			integer 	:= 100;
begin
	if	compile_only > 0	then
		return;
	end if;

	select	table_name 
	into	feature_name
	from	all_synonyms 
	where	owner = 'GIS'  and  synonym_name = 'TEMP_SYN';

	select	layer	
	into	layer_name
	from	sde.showtable
	where	owner = 'GIS'  and table_name = feature_name;

	script := 'drop synonym gis.temp_syn';	
	DBMS_UTILITY.EXEC_DDL_STATEMENT(Script);
	dbms_output.put_line ( script );	

	script := 'create synonym gis.temp_syn for gis.' || layer_name;
	DBMS_UTILITY.EXEC_DDL_STATEMENT(Script);
	dbms_output.put_line ( script );	

	select count(*)		into file_size		from gis.temp_syn;
	select max(numofpts)	into max_points		from gis.temp_syn;

	min_change := round(file_size/100);

	sample_pct := 64;	
	pct_change := 64;
	vector := 1;		

while vector <> 0	loop

<<calc>>

	sample_points := sample_pct/100 * max_points;

	select	count(*) 
	into	sample_size
	from	gis.temp_syn 
	where	numofpts <= sample_points;

	vector := sign(ideal_pct - round(sample_size / file_size, 02));

<<try_again>>

	safety := safety - 01;
	if	safety < 0		then
		dbms_output.put_line ( '*** Program is LOOPING ***');
		exit;
	end if;

	pct_change := pct_change / 2;

	if	pct_change < min_change		then
		exit;
	elsif	vector > 0			then
		sample_pct := sample_pct + pct_change;
	elsif	vector < 0			then
		sample_pct := sample_pct - pct_change;
	end if;

	if	sample_pct > 100		then
		vector	:= -1;
		goto	try_again;
	end if;

end loop;

	dbms_output.put_line (' ');
	dbms_output.put_line ( 'Feature Name       ' || feature_name ||'.'|| layer_name);
	dbms_output.put_line ( 'Optimal Points     ' || sample_points);
	dbms_output.put_line ( 'Maximum Points     ' || max_points);
	dbms_output.put_line ( 'Optimal Records    ' || sample_size);
	dbms_output.put_line ( 'Total   Records    ' || file_size );
	dbms_output.put_line ( 'Optimal Percent    ' || sample_pct);

end;
