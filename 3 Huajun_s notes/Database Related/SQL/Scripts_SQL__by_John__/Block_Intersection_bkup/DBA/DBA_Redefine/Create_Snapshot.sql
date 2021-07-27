--	=========================================================================
--	extract snapshot definitions

--	to re-create the snapshot one must re-specify the "start with" clause
--	=========================================================================
	set echo		off;
	set serveroutput	on;
	set charwidth	100;

	spool off;
	spool	c:\deacutis\scripts\ora_create\Script_Snapshot.sql;
--	spool	d:\scripts\ora_create\Script_Snapshot.sql;
--	=========================================================================
/*
	select * 	from dba_snapshots;
	select *	from dba_dependencies	where type = 'VIEW' and referenced_name like 'SNAP%'	and owner = 'GARLAND';
	select *	from dba_dependencies	where type = 'VIEW' and name like 'MVIEW%' 		and owner = 'GARLAND';
	select * 	from dba_dependencies	where type in ('VIEW', 'TRIGGER')	
							and referenced_name = 'TST_JOHN'	and referenced_owner = 'GARLAND';
	select *	from dba_segments		where segment_name  like 'SNAP%'	and owner = 'GARLAND';
*/
--	=========================================================================

declare

	do_compile_only		number		:= 0;
	do_many			varchar2(01)	:= ' ';
	do_one			varchar2(01)	:= '';

	spec_table			varchar2(40)	:= 'TEST_JOHN';
	spec_owner			varchar2(40)	:= 'GARLAND';

	text				varchar2(100);
	sql_text			varchar2(2000);

	scan_seq			number		:= 0;

	recd				tmp_view%rowtype;

--	=========================================================================

begin

	if	do_compile_only > 0		then
		return;
	end if;


for look in	(select *		
		from 	dba_snapshots,
			tmp_view
						
		where	master_owner	> do_one 
		and	master_owner	= spec_owner
		and	master		= spec_table
		and	key_			= 'all'

		or  (	master_owner	> do_many
		and 	master_owner	= schema_
		and 	master		= key_
		and	'table'		= type_		)
		)	
loop

--	=========================================================================

	text	:= 'drop snapshot   ' || look.owner ||'.'|| look.name || ';';
	dbms_output.put_line ( text );


	text	:= 'create snapshot ' || look.owner ||'.'|| look.name;
	dbms_output.put_line ( text );

--	=========================================================================
	
begin

	select *		
	into	recd
	from	tmp_view

	where(type_		> do_many		
	and	type_		= 'snapshot'	)
	and	schema_	= look.owner
	and 	key_		= look.table_name

	or (	key_	> do_one		
	and	key_	= 'all'			)
	;

	text	:= 	'tablespace ' || recd.tablespace_ || '   pctfree ' || recd.pctfree_ || 
			'  pctused '  || recd.pctused_;
	dbms_output.put_line ( text );

	text	:= 	'           ' || 'initrans 2 maxtrans ' || recd.maxtrans_;
	dbms_output.put_line ( text );

	text	:=	'storage   (initial ' || recd.initial_ || ' next ' || recd.next_ || ' pctincrease 0';
	dbms_output.put_line ( text );

	text	:=	'           ' || 'minextents 1  maxextents '  || recd.maxextents_ || ')';
	dbms_output.put_line ( text );


exception
	when no_data_found	then null;
end;

--	=========================================================================

for	scan in (	select 	tab_column_name 	
			from 		dba_clu_columns
			where		owner		= look.owner
			and		table_name	= look.table_name	
		  )
loop

	scan_seq	:= scan_seq + 01;

	if	scan_seq = 01			then
		text	:= 'cluster ( '	|| scan.tab_column_name;
	else
		text	:= text || ', '	|| scan.tab_column_name;	
	end if;	

end loop;

	if	scan_seq > 0			then
		dbms_output.put_line ( text || ' )' );	
	end if;

--	=========================================================================
	
	text	:= 'refresh    ' || look.type;
	dbms_output.put_line ( text );

	if	look.start_with	is not null		then
		text	:= 'start with ' || look.start_with;
		dbms_output.put_line ( text );
	end if;

	if	look.next is not null			then
		text	:= 'next       ' || look.next;
		dbms_output.put_line ( text );
	end if;

	dbms_output.put_line ( 'as' );


--	=========================================================================

	sql_text := 'select query from all_snapshots where owner = ''' || look.owner  || 
			'''  and name = ''' || look.name || ''' and master = ''' || look.master || ''' ';		

	show_long_column ( sql_text );


--	=========================================================================

	text	:= 	';';	
	dbms_output.put_line ( text );

end loop;


end;
