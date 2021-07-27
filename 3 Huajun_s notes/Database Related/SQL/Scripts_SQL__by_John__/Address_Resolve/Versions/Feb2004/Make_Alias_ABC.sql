	set echo 		off;
	set charwidth	200;
--	==========================================================================
--	Load Name Corrections into Alias table
--	==========================================================================

--	select rpad('_',70,'_') " " from dual;
--	==========================================================================

	spool	c:\deacutis\scripts\address_resolve\Alteration\Insert_Alias_ABC.sql

--	-------------------------------------------------------------------

	select

	'	insert into garland.adrAlias_Insert_vw	values ( '

--			alias_lo, alias_hi, addr_min, 	alias_weight, alias_how
	||		' 0, 999999, 0, ''' 			|| '9'',   ''' || do_name || ''''

	||chr(10)
	||		'	,''*''  ' || rpad(',''' || form_name || '''',35) || ',''*''   ,''*'' '

	||chr(10)
	|| 		'	,''''   ' || rpad(',''' || addr_name || '''',30) || '     ,''''    ,'''' ' 

	||chr(10)	||		 '	);'

	" "
	from	(select * from
		(
		select form_name, addr_name, do_name	from garland.adrResult	where do_name = 'C'
			 union 
		select form_name, addr_name, do_name	from garland.adrResult	where do_name = 'B'
		)
		 order by do_name, addr_name	)
	
--	where	rownum < 111

	;

--	-------------------------------------------------------------------

	spool off;

--	==========================================================================
	set echo		on;
	set charwidth;


--	desc adrAlias;

