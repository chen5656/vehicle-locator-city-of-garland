	set echo		off;
	set charwidth	200;
--	=============================================================================

	select

	'drop sequence	garland.'	|| item01|| '_NUM;'	||chr(10)||
	'create sequence	garland.'	|| item01|| '_NUM'	||chr(10)||

	'	start with		'	|| item05			||chr(10)||
	'	increment by	001		'			||chr(10)||
	'	minvalue		001		'			||chr(10)||
	'	maxvalue		999999	'			||chr(10)||
	'	cache			10		'			||chr(10)||
	'	nocycle  noorder;'					||chr(10)


	" "
	from	garland.GIS_Objects;

--	=============================================================================
	set echo		on;
	set charwidth;
