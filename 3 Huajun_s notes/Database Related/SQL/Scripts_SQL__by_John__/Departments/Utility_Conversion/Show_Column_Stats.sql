	set echo		off;
	set charwidth	300;
	set serveroutput	on		size 999999;

--	=========================================================================================
--	Display table name, column name, data type, occurrences, percentage, and sample value
--	of columns in specified tables

--	prep		specify  table choices	(see "CHANGE" below)
--	step 1	generate table names	giving gis_objects
--	step 2	generate sql script	
--		 	execute  sql script	giving gis_temp1
--	step 3	generate report		using  gis_temp1
--	=========================================================================================

--	truncate table	plan_table			reuse storage;	

--	=========================================================================================
--	Step 1

	truncate table	garland.gis_objects	reuse storage;

	insert into garland.gis_objects (item01)
	select table_name
	from	 tabs

	where length(table_name) <= 10

	and (	table_name is null		

--	<<<<<<<<<<<<  SPECIFY TABLE NAMES  <<<<<<<<<<<<<<<

	or	table_name like 'UT%'

--	or	table_name like 'UTSAN%'
--	or	table_name like 'UTSTO%'	
--	or	table_name like 'UTWAT%'	

--	<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	)


	and	table_name	not like '%BKUP'
	and	table_name	not like '%COPY'
	and	table_name	not like '%ATS1'
	and	table_name  not like '%TEMP'
;

--	=========================================================================================
--	Step 2

	set termout	off;

	spool c:\deacutis\scripts\execute.sql;
	spool off;
	spool c:\deacutis\scripts\execute.sql;

--	explain plan set statement_id = 'aaa'	for

	select '	truncate table   gis_temp1   reuse storage;' || chr(10)	" " from dual
	union all
	select '	alter rollback segment	rb1		online;'			" " from dual
	union all
	select '	commit;'									" " from dual
	union all
	select '	set transaction use rollback segment	rb1;	'		" " from dual
	union all
	select '	'										" " from dual

	union all
	select '	' ||
		'insert into gis_temp1  (item01, item02, item03, item04)   '		|| chr(10)		||
		'	' ||rpad('select ''' 	|| table_name || ''', '' '',  '	,40)	|| 
		rpad('  count(*), '' '''							,20)	||
		'from ' || table_name		|| ';'						|| chr(10)

	from	tabs				t,
		garland.gis_objects	o
	where	t.table_name = o.item01


	union all
	select '	' ||
		'insert into gis_temp1  (item01, item02, item03, item04)   '		|| chr(10)		||
		'	' ||rpad('select ''' || table_name || ''', '''	|| column_name	|| ''','	,50)	|| 
		rpad('  count(ltrim(' || column_name || ',''0 '')),'	, 40)			||
		rpad('  max(' || column_name	|| ')'			, 30)			||
		'from ' || table_name		|| ';'						|| chr(10)

	from	cols				c,
		garland.gis_objects	o
	where	c.table_name = o.item01

	union all
	select '	commit;'								" " from dual
	union all
	select '	alter rollback segment	rb1		offline;'		" " from dual
	union all
	select '	analyze table gis_temp1 compute statistics;'		" " from dual
	union all
	select '	'									" " from dual
	;

	spool off;

	@c:\deacutis\scripts\Execute.sql;			--	execute generated script

	set termout	on;

--	=========================================================================================
--	Step 3
--	Generate table column report
--	=========================================================================================

declare

	do_ascii		number		:= 01;

	records		number		:= 0;
	seq			number		:= 0;
	occur			number		:= 0;
	percentage		varchar2(80)	:= ' ';

	work_text		varchar2(200);


cursor	read_utility	is

--	explain plan set statement_id = 'ccc'	for

	select
	rpad(item01,	15) 	table_name,
	rpad(item02,	20)	column_name, 
	rpad(decode(data_type, 'VARCHAR2', 'TEXT', 'FLOAT', 'NUMBER', data_type), 10)	data_type, 
	lpad(data_length,	10)	data_length, 
	lpad(item03,	10)	occurs,
	    (item04)		text

	from	cols		c,
		gis_temp1	t

	where	c.table_name  (+)	= t.item01
	and	c.column_name (+)	= t.item02

	order by	table_name, column_name;

--	select * from explain_plan;

--	----------------------------------------------------------------

begin

	dbms_output.put_line (' ');

for look in read_utility	loop

	occur := ltrim(look.occurs);

	if	rtrim(look.column_name) is null			then
		dbms_output.put_line (' ');
		seq 		:= 0;
		records	:= occur;
	end if;

	if	do_ascii = 0
	and	records  > 0						then
		if	look.column_name > '0'				then
			percentage := (occur / records) * 100;
			dbms_output.put_line (	lpad(seq,03)	|| '   ' ||			 
							look.table_name	|| look.column_name || look.data_type || 
							look.occurs		|| '    '|| to_char(trunc(percentage, 01),'999.9') ||
							'      ' 		|| look.text
			);
		else
			dbms_output.put_line (	rpad(' ', 06)	|| 
							look.table_name	|| rpad(' ', 30)	||
							look.occurs		);
		end if;
	end if;


	if	do_ascii > 0
	and	records  > 0						then

		if	look.column_name > '0'				then
			percentage := (occur / records) * 100;

			work_text :=	seq || ' ' || look.table_name	|| look.column_name || look.data_type || 
						look.occurs	|| ' '|| to_char(trunc(percentage, 01),'999.9')	||
						' '		|| look.text;

			work_text	:= adr_string_cleaner (work_text);
			work_text	:= replace (work_text, rpad(' ',3),' ');
			work_text	:= replace (work_text, rpad(' ',2),' ');
			work_text	:= replace (work_text, rpad(' ',2),' ');
			work_text	:= replace (work_text, ' ', ',');
			dbms_output.put_line (work_text);

		else
			dbms_output.put_line (	rtrim(look.table_name)	||','||
							ltrim(look.occurs)	||',,,,');
		end if;
	end if;

	seq := seq + 01;

end loop;

end;

--	=========================================================================================



