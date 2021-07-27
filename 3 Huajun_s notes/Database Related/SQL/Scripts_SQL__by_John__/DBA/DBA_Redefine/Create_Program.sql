--	===============================================================================================
--	create source code from dba_source;
--	===============================================================================================
	set echo		off;
	set charwidth	200;
	set serveroutput	on;
--	===============================================================================================

	select	'CREATE OR REPLACE  ' 	" " 	from dual;

--	select	replace (text, chr(10), chr(04))	" "
	select	replace (text, chr(10))			" "
	from		dba_source

	where		type	=	upper(rtrim(ltrim(	'   package body     '		)))
	and		owner	=	upper(rtrim(ltrim(	'   garland          '		)))

	and		name	=	upper(rtrim(ltrim(	'   MATCHING_NAMES   '		)))

	order by 	name, line;


--	===============================================================================================
