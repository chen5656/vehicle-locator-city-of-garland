	set echo		off;
	set serveroutput	on	size 999999;
--	========================================================================
--	make "create index" definitions for specified tables 
--	========================================================================

--	========================================================================
/*	
	select rpad (segment_name,25),  segment_type, bytes, extents, owner, tablespace_name	
	from	dba_segments
	where	segment_name 	in (select alph1 from adrdebug)
	and 	owner			in ( 'GARLAND' )
	and	tablespace_name	in ( 'GIS_DATA' )  

	order by extents desc, segment_name;

	select rpad (segment_name,25),  segment_type, bytes, extents, owner, tablespace_name	
	from	dba_segments
	where	segment_name 	in (select index_name from ind where table_name in (select alph1 from adrdebug))
	and 	owner			in ( 'GARLAND' )
	and	tablespace_name	in ( 'GIS_DATA' )  

	order by extents desc, segment_name;
*/

--	=========================================================================	
--	extract re-org index definitions
--	=========================================================================	

declare

	do_compile_only		number		:= 0;

	do_many			varchar2(01)	:= ' ';	--	do indexes in gis_objects
	do_one			varchar2(01)	:= '';	--	do index specified below

	spec_index			varchar2(40)	:= '';
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
		from 		dba_indexes		ix,
				tmp_view

		where		index_name	= key_
		and		owner		= schema_
		and		'index'	= type_

--		where not exists (select 'x'	from dba_constraints  
--					where constraint_name = ix.index_name  and owner = ix.owner		)


		and (	(	index_name		> do_many
		and		index_name		= key_
		and		owner			= schema_
		and		'index'		= type_		)

		or	(	index_name		> do_one
		and		index_name		= spec_index
		and		owner			= spec_owner
		and		'all'			= key_		)   )

	)

loop

	dbms_output.put_line ( ' ' );
	text	:=	'select ''' || look.index_name ||''' " " from dual;';
	dbms_output.put_line ( text );

	if	look.option1_ = 'drop'		then
		text	:= 'drop   index   ' || look.schema_ || '.' || look.prefix_ ||  look.index_name || ';';
		dbms_output.put_line ( text );
	end if;


	select	'create'	|| decode ( look.uniqueness, 'UNIQUE', ' unique ', ' ')	||
			'index   '	|| look.schema_ || '.' || look.prefix_ || look.index_name	" " 
	into		text
	from		dual;
	dbms_output.put_line ( text );

	text	:=	'       on      '   || look.schema_ || '.' || look.prefix_ || look.table_name;
	dbms_output.put_line ( text );

	text	:=	'(';	
	dbms_output.put_line ( text );


--	=========================================================================	

	scan_count	:= 0;

for scan  in 
	(
		select	column_name
		from 		dba_ind_columns
		where		index_name 	= look.index_name
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

	text	:= 	'tablespace ' || look.tablespace_ || '       initrans 2  maxtrans ' || look.maxtrans_;
	dbms_output.put_line ( text );

	text	:=	'storage   (initial ' || look.initial_ || ' next ' || look.next_ || '   pctincrease 0';
	dbms_output.put_line ( text );

	text	:=	'           ' || 'minextents 1  maxextents '  || look.maxextents_;
	dbms_output.put_line ( text );

	text	:=	'           ' || 'freelists  1  freelist groups 1' || ')';
	dbms_output.put_line ( text );

	text	:=	';';	
	dbms_output.put_line ( text );

	text	:=	' ';	
	dbms_output.put_line ( text );

--	=========================================================================	

end loop;

end;
