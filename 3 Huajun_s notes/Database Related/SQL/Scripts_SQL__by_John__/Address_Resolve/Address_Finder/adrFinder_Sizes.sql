	set echo off;
--	==================================================================
/*
	select name,  type, code_size
	from dba_object_size 
	where owner = 'GARLAND'
	and	name like 'NIRANJAN%'
	and	name not like '%TEST'
	order by 1,2;


	select 'GRAND TOTAL' " ", sum(code_size) "code size"
	from dba_object_size 
	where owner = 'GARLAND'
	and	name like 'NIRANJAN%'
	and	name not like '%TEST';
*/
--	==================================================================

	select name,  type, code_size
	from dba_object_size 
	where owner = 'GARLAND'
	and	name in
(
	'ADR_FINDER_01',
	'ADR_FIND_01',
	'ADR_COMPRESS_NAME',
	'COMPARE_NAMES',
	'TST_COMPARE_NAME',
	'FIND_NEAR_RANGE',
	''
)
	order by 1,2;


	select 'NUCLEUS SIZE' " ", sum(code_size) "code size"
	from dba_object_size 
	where owner = 'GARLAND'
	and	name in
(
	'ADR_FINDER_01',
	'ADR_FIND_01',
	'ADR_COMPRESS_NAME',
	''
);

	select 'TOTAL SIZE  ' " ", sum(code_size) "code size"
	from dba_object_size 
	where owner = 'GARLAND'
	and	name in
(
	'ADR_FINDER_01',
	'ADR_FIND_01',

	'ADR_COMPRESS_NAME',

	'COMPARE_NAMES',
	'TST_COMPARE_NAME',
	''
);


--	==================================================================
	set echo on;
