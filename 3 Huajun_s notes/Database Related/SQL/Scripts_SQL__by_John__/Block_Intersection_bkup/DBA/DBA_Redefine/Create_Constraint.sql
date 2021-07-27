	set echo		off;
	set serveroutput	on	size 999999;

--	=========================================================================	
--	extract re-org constraint definitions
--	=========================================================================	

--	=========================================================================	

declare

	do_compile_only		number		:= 0;
	do_many			varchar2(01)	:= ' ';			--	do constraints in john_spec
	do_one			varchar2(01)	:= '';			--	do constraint specified below

	spec_constraint		varchar2(40)	:= 'ADRSTREET_PKEY';
	spec_owner			varchar2(40)	:= 'GARLAND';

	scan_count			number		:= 0;
	text				varchar2(100);

begin

	if	do_compile_only > 0		then
		return;
	end if;

for look in	
	(
		select 	*
		from		dba_constraints,
				tmp_view	

		where		constraint_type in ( 'P', 'U' )

		and (	(	constraint_name	> do_many
		and		constraint_name	= key_
		and		owner			= schema_
		and		'index'		= type_		)

		or	(	constraint_name	> do_one
		and		constraint_name	= spec_constraint
		and		owner			= spec_owner
		and		'all'			= key_		) )
	)

loop

	text	:=	'select ''' || look.constraint_name || ''' " "  from dual;';
	dbms_output.put_line ( text );

	text	:=	'alter table ' || look.schema_ ||'.'|| look.prefix_ || look.table_name;
	dbms_output.put_line ( text );

	select 'add '	||
		 decode  ( substr (look.constraint_name, 01, 05),
					'SYS_C',	null,
					'constraint ' || look.prefix_ || look.constraint_name 
			   )	
		into		text
		from		dual;
		dbms_output.put_line ( text );


	select	decode (look.constraint_type,
				'P',	'primary key',
				'U',	'unique',
					 look.constraint_type	)
	into		text
	from		dual;
	dbms_output.put_line ( text );


	text	:=	'(';	
	dbms_output.put_line ( text );


--	=========================================================================	

	scan_count	:= 0;

for scan  in 
	(
		select	column_name
		from		dba_cons_columns		
		where		constraint_name = look.constraint_name
	)

loop	

	scan_count	:= scan_count + 01;
	if	scan_count = 01			then
		text := ' ';
	else
		text := ',';	
	end if;

	text	:= text || scan.column_name;
	dbms_output.put_line ( text );

end loop;

--	=========================================================================	

	text	:=	')';	
	dbms_output.put_line ( text );

	text	:=	'using index';
	dbms_output.put_line ( text );

	text	:= 	'tablespace ' || look.tablespace_ || '      initrans 2  maxtrans ' || look.maxtrans_;
	dbms_output.put_line ( text );

	text	:=	'storage   (initial ' || look.initial_ || ' next ' || look.next_ || ' pctincrease 0';
	dbms_output.put_line ( text );

	text	:=	'           ' || 'minextents 1  maxextents '  || look.maxextents_;
	dbms_output.put_line ( text );

	text	:=	'           ' || 'freelists  1  freelist groups 1' || ')';
	dbms_output.put_line ( text );

	text	:=	';' || chr(10);	
	dbms_output.put_line ( text );

--	=========================================================================	

end loop;

end;




