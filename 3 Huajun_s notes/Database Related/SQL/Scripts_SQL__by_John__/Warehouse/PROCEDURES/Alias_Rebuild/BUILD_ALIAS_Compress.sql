--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================

--	=====================================================================

--	execute	garland.BUILD_ALIAS_COMPRESS

--	create or replace procedure garland.BUILD_ALIAS_COMPRESS		AS

	DECLARE

--	=====================================================================

	compile_only	integer	:= 01;

	total_processed	integer	:= 0;
	title			varchar2(100);
	heading		varchar2(100);
	script		varchar2(2000);

BEGIN
	if	compile_only > 0		then
		return;
	end if;

	select 'ALIAS COMPRESS   '||to_char(sysdate,'Mon dd hh24:mi') into heading from dual; 
	dbms_output.put_line(heading);

--	===============================================================================
--	Update compressed names in adrAlias
--	Update weights in adrAlias
--	===============================================================================

	update garland.adrAlias
	set	alias_reduced	= nvl (garland.adr_compress_name ( alias_name, '1'), ' '),
		alias_compact	= nvl (garland.adr_compress_name ( alias_name, '4'), ' '),
		alias_compress	= nvl (garland.adr_compress_name ( alias_name, '6'), ' ')
	;

	update garland.adrAlien
	set	alias_reduced	= nvl (garland.adr_compress_name ( alias_name, '1'), ' ');

--	===============================================================================
--	update alias_match per qualifier matches

	update garland.adrAlias
	set	alias_match =
		decode (alias_type, '*', 0, 1)   +		-- type match
		decode (alias_pfx,  '*', 0, 1)   +		-- prefix match
		decode (alias_sfx,  '*', 0, 1)   +		-- suffix match
		decode (alias_lo,   '0', 0, 1)   +		-- lo match
		decode (sign(alias_hi - 111111), -1, 1, 0);	
--		decode (alias_hi,   '999999', 0, 1);		


--	update garland.adrAlias
--	set	alias_match =
--		alias_match +
--		decode (addr_type, null,0,1)	+
--		decode (addr_pfx,  null,0,1)	+
--		decode (addr_sfx,  null,0,1)	
--	where	lower(alias_how) like '%push%';

--	===============================================================================
--	update null addr_ columns

	update garland.adrAlias
	set
		addr_name		= alias_name,
		addr_type		= rtrim(alias_type, '* '),
		addr_pfx		= rtrim(alias_pfx,  '* '),
		addr_sfx		= rtrim(alias_sfx, ' * ')
	where	addr_name is null;

--	===============================================================================
--	set priority (1=numeric, 2=upper case, 3=lower case)			-- dec 2004

	update garland.adrAlias
	set	alias_priority = 1
	where	alias_how < 'A';

	update garland.adrAlias
	set	alias_priority = 2
	where	alias_how between 'A' and 'Zzz';

	update garland.adrAlias
	set	alias_priority = 3
	where	alias_how >= 'a';

--	===============================================================================

	COMMIT;

--	===============================================================================

END;

