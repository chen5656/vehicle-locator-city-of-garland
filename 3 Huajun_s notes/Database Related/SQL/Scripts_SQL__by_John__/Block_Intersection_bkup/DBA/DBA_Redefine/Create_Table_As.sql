--	=========================================================================	
--	extract re-org table definitions
--	=========================================================================	

	set echo		off;
	set serveroutput	on;
	set charwidth	100;

	spool off;
	spool	c:\deacutis\scripts\ora_create\Script_Table_As.sql;

--	=========================================================================	

declare

	do_compile_only		number		:= 0;
	do_drop			number		:= 0;

	scan_count			number		:= 0;
	text				varchar2(100);
	clause			varchar2(100);

	spec				tmp_view%rowtype;

begin

	if	do_compile_only > 0		then
		return;
	end if;


	select	*
	into		spec
	from		tmp_view
	where		type_	= 'as'
	;


for look in	
	(
		select 	all *
		from 		dba_tables,
				tmp_view
		where		table_name	= key_
		and		owner		= schema_
		and		type_		= 'table'
	)
loop

	text	:=	'select ''CREATE ' || look.table_name || ''' " " from dual;';
	dbms_output.put_line ( text );


	if	do_drop > 01
	or	look.option1_ = 'drop'		then

		text	:=	'drop   table   ' || look.schema_ || '.' || look.prefix_ 
							|| look.table_name || look.suffix_ || ';';
		dbms_output.put_line ( text );
	end if;

	text	:= 	'create table   ' || look.owner || '.' || look.prefix_ || look.table_name || look.suffix_;
	dbms_output.put_line ( text );


--	=========================================================================	

	text	:= 	'tablespace ' || look.tablespace_ || '   pctfree  ' || look.pctfree_ || 
			'   pctused ' || look.pctused_;
	dbms_output.put_line ( text );

	text	:= 	'           ' || 'initrans 1 maxtrans ' || look.maxtrans_;
	dbms_output.put_line ( text );

	text	:=	'storage   (initial ' || look.initial_ || ' next ' || look.next_ || '  pctincrease 0';
	dbms_output.put_line ( text );

	text	:=	'           ' || 'minextents 1  maxextents '  || look.maxextents_;
	dbms_output.put_line ( text );

	text	:=	'           ' || 'freelists  1  freelist groups 1' || ')';
	dbms_output.put_line ( text );

--	text	:= 	';';	
--	dbms_output.put_line ( text );

	text	:=	'as select * from ' || spec.schema_ || '.' || look.table_name || look.dblink_ || ';';
	dbms_output.put_line ( text );


	text	:=	'select count(*) "' 	|| look.table_name || '" from ' || look.schema_ ||'.'
							|| look.table_name  || ';';	
	dbms_output.put_line ( text );


	dbms_output.put_line ( ' ' );

--	=========================================================================	

end loop;

end;


