	set echo		off;
	set termout		on;
	set charwidth	200;
--	=========================================================================

	variable  	alias_method_lo		varchar2(10);
	variable  	alias_method_hi		varchar2(10);

--	=========================================================================

	execute	:alias_method_lo := 'A';
	execute	:alias_method_hi := 'Zz';

	spool	c:\deacutis\scripts\address_resolve\Alteration\Insert_Alias_Street.sql
	@c:\deacutis\scripts\address_resolve\alteration\Make_Alias.sql
	spool off

--	=========================================================================

	execute	:alias_method_lo := '2';
	execute	:alias_method_hi := '2z';

	spool	c:\deacutis\scripts\address_resolve\Alteration\Insert_Alias_NonGar.sql
	@c:\deacutis\scripts\address_resolve\alteration\Make_Alias.sql
	spool off

--	=========================================================================

	execute	:alias_method_lo := '1';
	execute	:alias_method_hi := '1z';

	spool	c:\deacutis\scripts\address_resolve\Alteration\Insert_Alias_NonAdr.sql
	@c:\deacutis\scripts\address_resolve\alteration\Make_Alien.sql
	spool off

--	=========================================================================

	@c:\deacutis\scripts\address_resolve\alteration\Make_Alias_ABC.sql

--	=========================================================================
	set echo	on;
	set termout	on;
	set charwidth;

--	=========================================================================
