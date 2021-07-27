--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================

--	=====================================================================

--	execute	garland.BUILD_ALIAS_ABBREVIATION

--	create or replace procedure garland.BUILD_ALIAS_ABBREVIATION	AS

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

	select 'ALIAS ABBREVIATION   '||to_char(sysdate,'Mon dd hh24:mi') into heading from dual; 
	dbms_output.put_line(heading);

--	=========================================================================================   
--	QUALIFIER NAME IN ALIAS NAME IS ABBREVIATED (if not already done)
--	EXAMPLE:	Both 'Miller Park' and 'Miller Pk' will be in table

	insert into garland.adrAlias
	select distinct
		alias_pfx,
 		replace(ltrim(rtrim(replace (a.alias_name, i.name, ' '|| i.standard ||' '))),'  ',' '),
		alias_type,
		alias_sfx,
		alias_lo,
		alias_hi,
		addr_min,
		addr_pfx,
		addr_name,
		addr_type,
		addr_sfx,
		a.alias_how || '.',
		alias_reduced,
		alias_compact,
		alias_compress,
		alias_weight
		,0				-- alias_match		nov 2003
		,0				-- alias_priority		dec 2004
	from	garland.adrAlias		a,
		garland.adrItem		i

	where	i.class in ('T', 'D')
	and	i.standard <> i.name
	and	(' '|| a.alias_name ||' ') like ('% '|| i.name ||' %')
	and	translate (lower(a.alias_how), '/abcdefghijklmnopqrstuvwxyz@','/') is null

	and	lower(a.alias_how) not like '%push%'		-- nov 2004

	and not exists
(
	select 'x'
	from	garland.adrAlias
	where	alias_name	= replace(ltrim(rtrim(replace (a.alias_name, i.name, ' '|| i.standard ||' '))),'  ',' ')
	and	alias_type	= a.alias_type
	and	alias_pfx	= a.alias_pfx
	and	alias_sfx	= a.alias_sfx
);

	total_processed := sql%rowcount;
	dbms_output.put_line ( 'Insert total = ' || total_processed);

	COMMIT;

END;

