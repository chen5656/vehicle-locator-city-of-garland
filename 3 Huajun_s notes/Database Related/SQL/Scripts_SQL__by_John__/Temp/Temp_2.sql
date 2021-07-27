	set echo off;


	update 

	UTSTOPIPE

	set

	( project_num, map_grid, map_quad, asbuilt_date   ,MAPID ) 

	=
	
(
	select 'DEV2003052', '4A', 'B', '2003/10/20'	,2456

	from dual

)


--	where	mslink in ( 154316   )
	

	where mslink between	115964 	and 115996

	;


--	---------------------------------------------------------------


	select * from 	UTSTOPIPE


	where mslink between	115964 	and 115996

	;

--	---------------------------------------------------------------

	ROLLBACK;

	COMMIT;

	set echo on;

