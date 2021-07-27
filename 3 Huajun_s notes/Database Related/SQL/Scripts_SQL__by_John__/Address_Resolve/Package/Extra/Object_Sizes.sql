	set echo 	off;
	set timing	off;

--	===================================================================================

	select * 
	from	user_object_size	
	where name in (
		'RESOLVE_ADDRESS', 
		'ADR_PARSE_ADDRESS',
		'ADR_ALIAS_MATCH',
		'ADR_COMPARE_NAMES',
		'ADR_RESOLVE_UNPARSED_EXIT',
		'ADR_RESOLVE_PARSED_EXIT',
		''	)
	order by	code_size;

--	===================================================================================

	select	sum (source_size)	"source",
			sum (parsed_size)	"parse",
			sum (code_size)	"code"
	from	user_object_size	
	where name in	(
		'RESOLVE_ADDRESS', 
		'ADR_PARSE_ADDRESS',
		'ADR_ALIAS_MATCH',
		'ADR_COMPARE_NAMES',
		'ADR_RESOLVE_UNPARSED_EXIT',
		'ADR_RESOLVE_PARSED_EXIT',
		''		);

--	===================================================================================


/*
--	===================================================================================
--	jan 06, 2003


NAME                           TYPE          SOURCE_SIZ PARSED_SIZ CODE_SIZE  ERROR_SIZE
------------------------------ ------------- ---------- ---------- ---------- ----------
RESOLVE_ADDRESS                PACKAGE              809       1385        775          0
ADR_RESOLVE_UNPARSED_EXIT      PROCEDURE           2120        759       2555          0
ADR_RESOLVE_PARSED_EXIT        PROCEDURE           2462       1043       3116          0
ADR_COMPARE_NAMES              PROCEDURE           5123       8281       3701          0
ADR_ALIAS_MATCH                PROCEDURE          13714      27779      13015          0
ADR_PARSE_ADDRESS              PROCEDURE          35841      83411      35235          0
RESOLVE_ADDRESS                PACKAGE BODY       53169          0      53605          0

source     parse      code      
---------- ---------- ----------
    113238     122658     112002

--	===================================================================================
*/

	set echo 	on;
