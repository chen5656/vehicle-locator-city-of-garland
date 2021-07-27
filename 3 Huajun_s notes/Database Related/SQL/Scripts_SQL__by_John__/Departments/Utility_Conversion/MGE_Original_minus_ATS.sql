	set echo off;
	set charwidth	200;


	select

	'	select * from garland.' || table_name || '  minus select * from jdeacutis.' || table_name ||';'


	" "
	from tabs

	where table_name in ( 

		'CATEGORY', 'ATTRIBUTE_CATALOG', 'DOMAIN_CATALOG', 'FEATURE', 'JOIN_CATALOG', 'LABEL',

		'LIST_DOMAIN', 'MAPS',  'MSCATALOG', 'RANGE_DOMAIN', 'VIEW_CATALOG', 'VIEW_CONTENT',

		'VIEW_JOIN',


	null );



	set echo on;
	set charwidth;

