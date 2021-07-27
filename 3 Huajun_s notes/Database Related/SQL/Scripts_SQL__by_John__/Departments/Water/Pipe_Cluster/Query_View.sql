	set echo off;
--	====================================================================

	select 'pipe mstr    ' " ", p.* from garland.view_pipe_master   P	where rownum < 11;

	select 'node mstr    ' " ", n.* from garland.view_node_master   N	where rownum < 11;

	select 'parcel mstr  ' " ", p.* from garland.view_parcel_master P	where rownum < 11;

	select 'valve mstr   ' " ", n.* from garland.view_valve_master  N	where rownum < 11;


	select 'pipe pair    ' " ", p.* from garland.view_pipe_pair	    P	where rownum < 11;

	select 'pipe group   ' " ", p.* from garland.view_pipe_group    P	where rownum < 11;

--	====================================================================

	select 'pipe mstr    ' " ", count(*) total from garland.view_pipe_master   P;	

	select 'node mstr    ' " ", count(*) total from garland.view_node_master   N;	

	select 'parcel mstr  ' " ", count(*) total from garland.view_parcel_master P;	

	select 'valve mstr   ' " ", count(*) total from garland.view_valve_master  N;	


	select 'pipe pair    ' " ", count(*) total from garland.view_pipe_pair	   P;	

	select 'pipe group   ' " ", count(*) total from garland.view_pipe_group    P;	

--	====================================================================

