
--	========================================================

	set timing on;	

	alter rollback segment		rb_large		online;
	set transaction	use rollback segment		rb_large;

--	========================================================

	update cdreladr
	set addr_name = decode ( addr_name,

--	========================================================
--	AUG 07,2000
				
	'ACREEK VALLEY',		'CREEK VALLEY',
	'BRAODWAY',			'BROADWAY',
	'COUNRY OAKS',		'COUNTRY OAKS',
	'GGREEN VALLEY',		'GREEN VALLEY',
	'GRASSMERE',		'GRASMERE',
	'NORHWEST',			'NORTHWEST',
	'OALKAND',			'OAKLAND',
	'RALIEGH',			'RALEIGH',
	'SHORE HAVEN',		'SHOREHAVEN',

--	'STATE HIGHWAY 190',	'GEORGE BUSH',

--	========================================================

		addr_name 	);

--	========================================================

--	rollback;
	commit;

	alter rollback segment		rb_large		offline;

	set timing off;

--	========================================================


