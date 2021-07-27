	set echo		off;
	set fetchrows;
--	===========================================================================
--	Build "Alter Block Control" Command File 

--	Alterations may be desired on new Insert or new Update Block Controls
--	Generate SQL command file template for altering recent Block Controls

--	===========================================================================

--	E1

--	===========================================================================
--	Process Block Control records created most recently 

	variable	 date_choice	date;
	execute	:date_choice :=  to_date('2004-04-11', 'yyyy-mm-dd');

--	===========================================================================

--	--------------------------------------------------
	spool	c:\deacutis\scripts\execute.sql
	spool off
	spool	c:\deacutis\scripts\execute.sql
--	--------------------------------------------------

	select

	'Update garland.Block_Control		Set (block_id, action, differ,' 
	||chr(10)||
	'Addr_block,addr_pfx,addr_name,addr_type,addr_sfx,' 
	||chr(10)||
	'Repl_block,repl_pfx,repl_name,repl_type,repl_sfx, Start_lo,stop_lo,stop_hi,counter)'
	||chr(10)	|| '=  (  select'	||chr(10)||

	'''' || block_id  ||''','''|| action   ||''','''|| differ	 ||''','  
	||chr(10)	||
	'''' || addr_block||''','''|| addr_pfx ||''','''|| addr_name ||''','''|| addr_type	||''','''|| addr_sfx ||''','
	||chr(10)	|| 
	'''' || repl_block||''','''|| repl_pfx ||''','''|| repl_name ||''','''|| repl_type	||''','''|| repl_sfx ||''','
	||chr(10)	||	
	'''' || start_lo  ||''','''|| stop_lo ||''',''' || stop_hi	 ||''','''||counter	||''''   
	||chr(10)	||	

	'  from dual )  where record_id = ' || record_id || ' * 0 ;' 
	||chr(10)

	" "
	from	garland.Block_Control_vw
	where	add_date >= :date_choice
	;

--	--------------------------------------------------
	spool off
--	--------------------------------------------------
--	@c:\deacutis\scripts\execute.sql;	
--	--------------------------------------------------

--	===========================================================================
	set echo		on;
	set fetchrows;


