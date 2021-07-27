	set echo		off;
	set charwidth	120;
--	======================================================================
--	PROGRAM LISTING
--	======================================================================

	select	'	set echo off;'	" "		from dual
	union all
	select	'--	' || rpad('*',70,'*')		from dual
	union all

--	----------------------------------------------------------------------

	select 	

		line		||'   '||

		decode (line, 01, '	CREATE OR REPLACE	', null)	||

--		rpad(

		rtrim(text, ' ' || chr(10))

--		,100,'^')

	" "
	from	User_Source

--	----------------------------------------------------------------------
--	SPECIFY PROGRAM NAME

	where	name	=	upper (	'RESOLVE_ADDRESS'		)

--	----------------------------------------------------------------------
--	SPECIFY PROGRAM TYPE
						
	and	type	= 'PACKAGE BODY'
--	and	type	= 'PROCEDURE'
--	and	type	= 'FUNCTION'

--	----------------------------------------------------------------------

--	order by	type, name, line

--	----------------------------------------------------------------------
	;

--	======================================================================
	set echo		on;
	set charwidth;

