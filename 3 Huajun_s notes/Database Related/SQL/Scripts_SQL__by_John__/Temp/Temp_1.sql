	set echo off;
--	=====================================================
/*

			ROLLBACK
	
	SERVFINAL
	UTWATPIPE

			misc.ctl
			DBF	to excel	to misc.dat		to LOADER

			TABLE
			COLUMNS

	--------------------------------------------------------------------------------------------------------

	MSLINK_DMR,  MAPID,  PROJECT_NU,  MAP_GRID,  MAP_QUAD,  PIPE_DIAME,  ASBUILT_DA

	--------------------------------------------------------------------------------------------------------
*/
--	=====================================================
--	VIEW

	create or replace view	TEMP_VIEW	as

	select 

		item01	mslink		,
		item02	mapid			,

		item03	project_num		,
		item04	map_grid		,
		item05	map_quad		,

		item06	pipe_diameter	,
		item07	asbuilt_date	,

		item08				,
		item09				,			

		item10
	from	garland.gis_objects;

--	=====================================================
--	UPDATE

update 

UTWATPIPE		U
	
set
(

		mslink		,
		mapid			,

		project_num		,
		map_grid		,
		map_quad		,

		pipe_diameter	,
		asbuilt_date	


)	=

(
	select

		mslink		,
		mapid			,

		project_num		proj,
		map_grid		grid,
		map_quad		quad,

		pipe_diameter	diam,
		asbuilt_date	asbuilt



	from  garland.temp_view		G
	where	g.mslink = rtrim(u.mslink)
)


	where exists
(
	select 'x'
	from 	garland.gis_objects
	where	item01 = rtrim(u.mslink)
);


--	=====================================================
--	QUALITY CONTROL

select 
		project_num		proj,
		map_grid		grid,
		map_quad		quad,

		pipe_diameter	diam,
		asbuilt_date	asbuilt

from  

UTWATPIPE		U,

garland.gis_objects	G	
where	g.item01 = rtrim(u.mslink);
	
--	=====================================================
/*

	select

		max(length( mslink ))			mslink,
		max(length( project_num ))		project,
		max(length( map_grid ))			grid,
		max(length( map_quad ))			quad,
		max(length( asbuilt_date ))		asbuilt,

--		max(length( inlet_type))		type,


			' '
	from		garland.temp_view;

	desc		garland.UTSTOHWAL;

*/	
--	=====================================================

	ROLLBACK;

	COMMIT;

--	=====================================================
	set echo on;
