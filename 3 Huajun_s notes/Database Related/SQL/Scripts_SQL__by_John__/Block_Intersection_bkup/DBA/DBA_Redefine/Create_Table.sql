	set echo		off;
	set serveroutput	on		size 999999;

--	=========================================================================	
--	construct "create table" commands
--	=========================================================================	

--	=========================================================================	
--	Choose:	DO_MANY	per specs table
--			DO_ONE	per spec_table_name (below)	
--	values:	null=off	space=on
--	=========================================================================	

declare

	do_compile_only		number		:= 0;
	do_many			varchar2(01)	:= ' ';		--	do table names in gis_objects
	do_one			varchar2(01)	:= '';		--	do table specified below

	spec_table_name		varchar2(40)	:= 'CDRELPAR';
	spec_owner			varchar2(40)	:= 'GARLAND';

	scan_seq			number		:= 0;
	find_seq			number		:= 0;
	text				varchar2(100);
	clause			varchar2(100);

begin

	if	do_compile_only > 0		then
		return;
	end if;


for look in	
	(
		select 	all *
		from 		all_tables		tab,
				tmp_view

		where	(	table_name		> do_many
		and		table_name		= key_
		and		owner			= schema_
		and		'table'		= type_		)


		or	(	table_name		> do_one
		and		table_name		= spec_table_name
		and		owner			= spec_owner			
		and		'all'			= key_		)
		order by  table_name
	)

loop

	dbms_output.put_line ( ' ' );

	text	:=	'     select ''CREATE ' || look.table_name || ''' " " from dual;';
	dbms_output.put_line ( text );


	if	look.option1_ = 'drop'		then
		text	:=	'     drop   table   ' || look.schema_ || '.' || look.prefix_ || look.table_name || ';';
		dbms_output.put_line ( text );
	end if;

	text	:= 	'     create table   ' || look.owner || '.' || look.prefix_ || look.table_name;
	dbms_output.put_line ( text );

	text	:=	'   (';	
	dbms_output.put_line ( text );

--	=========================================================================	

	scan_seq	:= 0;

for scan  in 
	(
		select	*
		from		all_tab_columns
		where		table_name	= look.table_name
		and		owner		= look.owner		
		order by	column_id
	)
loop	

	scan_seq	:= scan_seq + 01;

	if	scan_seq = 01			then
		text := '     ';
	else
		text := '    ,';	
	end if;

	select
		rpad (scan.column_name, 30)	|| 
		rpad (scan.data_type,   08)	||

		decode  ( scan.data_type,	
		upper ('number'),		' (' || least (scan.data_length, nvl (scan.data_precision, 9999)) || 	
						 decode ( nvl (scan.data_scale, 0), 
							   0, ')',	',' ||  scan.data_scale || ')'  ),	

		upper ('varchar2'),	' (' || scan.data_length || ')',
		upper ('char'),		' (' || scan.data_length || ')',
		upper ('float'),		' (' || least (scan.data_length, nvl (scan.data_precision, 9999)) || ')',	
		upper ('raw'),		' (' || scan.data_length || ')',
	  	' ')				||													

		decode  (scan.nullable, upper ('n'), ' not null', null)

		into	clause
		from	dual
		;

	text	:= text || clause;
	dbms_output.put_line ( text );

end loop;

--	=========================================================================	

	text	:=	'   )';	
	dbms_output.put_line ( text );

	text	:= 	'     tablespace ' || look.tablespace_ || '   pctfree ' || look.pctfree_ || 
			'  pctused '  || look.pctused_;
	dbms_output.put_line ( text );

	text	:= 	'                ' || 'initrans 1 maxtrans ' || look.maxtrans_;
	dbms_output.put_line ( text );

	text	:=	'     storage   (initial ' || look.initial_ || ' next ' || look.next_ || ' pctincrease 0';
	dbms_output.put_line ( text );

	text	:=	'                ' || 'minextents 1  maxextents '  || look.maxextents_;
	dbms_output.put_line ( text );

	text	:=	'                ' || 'freelists  1  freelist groups 1' || ')';
	dbms_output.put_line ( text );

	text	:= 	'     ;' || chr(10);	
	dbms_output.put_line ( text );

--	=========================================================================	
/*

	find_seq	:= 0;

for	find in (	select 	tab_column_name 	
			from 		dba_clu_columns
			where		owner		= look.owner
			and		table_name	= look.table_name	
		  )
loop

	find_seq	:= find_seq + 01;

	if	find_seq = 01			then
		text	:= 'cluster ( '	|| find.tab_column_name;
	else
		text	:= text || ', '	|| find.tab_column_name;	
	end if;	

end loop;

	if	find_seq > 0			then
		dbms_output.put_line ( text || ' )' );	
	end if;


*/
--	=========================================================================

end loop;

end;


