
--	====>>>>>>>		UTSANFITT  REPLACES  UTSANCLEN & UTSANPLUG	<<<<<<<<================
   
select 'UTSANFITT' " "  from dual;

	-- truncate table	GARLAND.UTSANFITT		REUSE STORAGE;

    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

	   -- explain plan  set statement_id = 'UTSANFITT' for 
  
insert into GARLAND.UTSANFITT
(    
	 mslink  
	,mapid   
	,fitting_id    
	,fitting_code  
	,map_grid    
	,map_quad    
	,fitting_num   
--	,fitting_name  
	,fitting_size  
	,basin   
	,sub_basin   
	,sub_subbasin  
--	,upstream_node 
--	,dnstream_node 
--	,asbuilt_date  
--	,ats 
)
select  
	 mslink  
	,mapid   
	,fitting_id    
	,fitting_code  
	,map_grid    
	,map_quad    
	,fitting_num   
--	,fitting_name  
	,fitting_size  
	,basin   
	,sub_basin   
	,sub_subbasin  
--	,upstream_node 
--	,dnstream_node 
--	,asbuilt_date  
--	,ats 
from   GARLAND.UTSANFIT;


commit;
alter rollback segment rb1   offline;


--	***************************************************
    
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   
select 'UTSANCLEN' " "  from dual;

	-- truncate table	GARLAND.UTSANCLEN		REUSE STORAGE;

    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

	   -- explain plan  set statement_id = 'UTSANCLEN' for 
  
insert into GARLAND.UTSANCLEN
(    
	 mslink  
	,mapid   
	,clean_id    
--	,fitting_code  
	,map_grid    
	,map_quad    
	,clean_num   
--	,fitting_name  
	,clean_size  
	,basin   
	,sub_basin   
	,sub_subbasin  
--	,upstream_node 
--	,dnstream_node 
--	,asbuilt_date  
--	,ats 
)
select  
	 mslink  
	,mapid   
	,fitting_id    
--	,fitting_code  
	,map_grid    
	,map_quad    
	,fitting_num   
--	,fitting_name  
	,fitting_size  
	,basin   
	,sub_basin   
	,sub_subbasin  
--	,upstream_node 
--	,dnstream_node 
--	,asbuilt_date  
--	,ats 
from   GARLAND.UTSANFIT

where	 fitting_code = 'CO';					-- FILTER


commit;
alter rollback segment rb1   offline;


--	***************************************************
   
select 'UTSANPLUG' " "  from dual;

	-- truncate table	GARLAND.UTSANPLUG		REUSE STORAGE;

    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

	   -- explain plan  set statement_id = 'UTSANPLUG' for 
  
insert into GARLAND.UTSANPLUG
(    
	 mslink  
	,mapid   
	,plug_id    
--	,fitting_code  
	,map_grid    
	,map_quad    
	,plug_num   
--	,fitting_name  
	,plug_size  
	,basin   
	,sub_basin   
	,sub_subbasin  
--	,upstream_node 
--	,dnstream_node 
--	,asbuilt_date  
--	,ats 
)
select  
	 mslink  
	,mapid   
	,fitting_id    
--	,fitting_code  
	,map_grid    
	,map_quad    
	,fitting_num   
--	,fitting_name  
	,fitting_size  
	,basin   
	,sub_basin   
	,sub_subbasin  
--	,upstream_node 
--	,dnstream_node 
--	,asbuilt_date  
--	,ats 
from   GARLAND.UTSANFIT

where	 fitting_code = 'PL';					-- FILTER


commit;
alter rollback segment rb1   offline;


--	***************************************************
   
select 'UTSANLATR' " "  from dual;

	-- truncate table	GARLAND.UTSANLATR		REUSE STORAGE;

    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

	   -- explain plan  set statement_id = 'UTSANLATR' for 
  
insert into GARLAND.UTSANLATR
(    
	 mslink  
	,mapid   
	,lateral_id    
	,map_grid    
	,map_quad    
	,lateral_num   
	,lateral_size  
	,basin   
	,sub_basin   
	,sub_subbasin  
	,upstr_node				--
	,dnstr_node				--
--	,asbuilt_date  
--	,ats 
)
select  
	 mslink  
	,mapid   
	,lateral_id    
	,map_grid    
	,map_quad    
	,lateral_num   
	,lateral_size  
	,basin   
	,sub_basin   
	,sub_subbasin  
	,upstream_node
	,dnstream_node 
--	asbuilt_date  
--	,ats 
from   GARLAND.UTSANLAT;

commit;
alter rollback segment rb1   offline;


--	***************************************************
   
select 'UTSANLIFT' " "  from dual;

	-- truncate table	GARLAND.UTSANLIFT		REUSE STORAGE;

    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

	   -- explain plan  set statement_id = 'UTSANLIFT' for 
  
insert into GARLAND.UTSANLIFT
(    
	 mslink  
	,mapid   
	,liftsta_id    
	,map_grid    
	,map_quad    
	,liftsta_num   
	,liftsta_desc
	,liftsta_size  
	,basin   
	,sub_basin   
	,sub_subbasin  
	,upstr_node				--
	,dnstr_node 			--
--	,asbuilt_date  
--	,ats 
)
select  
	 mslink  
	,mapid   
	,liftsta_id    
	,map_grid    
	,map_quad    
	,liftsta_num   
	,descript
	,liftsta_size  
	,basin   
	,sub_basin   
	,sub_subbasin  
	,upstream_node
	,dnstream_node 
--	,asbuilt_date  
--	,ats 
from   GARLAND.UTSANLST;

commit;
alter rollback segment rb1   offline;


--	***************************************************
   
select 'UTSANMANH' " "  from dual;

	-- truncate table	GARLAND.UTSANMANH		REUSE STORAGE;

 
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

	   -- explain plan  set statement_id = 'UTSANMANH' for 
 
insert into GARLAND.UTSANMANH
( 
	 mslink  
	,mapid   
	,manhole_id    
	,map_grid    
	,map_quad    
	,manhole_num   
--	,manhole_size  
	,basin   
	,sub_basin   
	,sub_subbasin  
	,upstr_manhole_node 
	,dnstr_manhole_node 
--	,asbuilt_date  
--	,ats 
)
select  
	 mslink  
	,mapid   
	,manhole_id    
	,map_grid    
	,map_quad    
	,manhole_num   
--	,manhole_size  
	,basin   
	,sub_basin   
	,sub_subbasin  
	,upstream_node 
	,dnstream_node 
--	,asbuilt_date  
--	,ats 
from   GARLAND.UTSANMH;

commit;
alter rollback segment rb1   offline;


--	***************************************************
    
select 'UTSANPIPE' " "  from dual;

	-- truncate table	GARLAND.UTSANPIPE		REUSE STORAGE;

    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

	   -- explain plan  set statement_id = 'UTSANPIPE' for 
  
insert into GARLAND.UTSANPIPE
(    
	 mslink  
	,mapid   
	,pipe_diameter 
	,pipe_length   
	,pipe_material 
	,pipe_type   
	,pipe_class    
--	,pipe_use    
	,manufacturer   			--
	,modeled 
	,idm 
	,basin   
	,sub_basin   
	,sub_subbasin  
	,upstr_node
	,upstr_node_type  
	,dnstr_node    
	,dnstr_node_type  
	,upstr_basin
	,upstr_sub_basin
--	,up_node_xcoord    
--	,up_node_ycoord    
	,upstr_node_elev  
	,upstr_node_grnd_elev   
	,dnstr_basin  
	,dnstr_sub_basin
--	,dn_node_xcoord    
--	,dn_node_ycoord    
	,dnstr_node_elev  
	,dnstr_node_grnd_elev   
	,slope   
--	,asbuilt_date  
--	,pipe_length1  
	,pipe_id 
	,map_grid    
	,map_quad    
	,pipe_num    
--	,ats 
)
select  
	 mslink  
	,mapid   
	,pipe_diameter 
	,pipe_length   
	,pipe_material 
	,pipe_type   
	,pipe_class    
--	,pipe_use    
	,pipe_manufacturer   
	,modeled 
	,idm 
	,basin   
	,sub_basin   
	,sub_subbasin  
	,up_node_id    
	,up_node_type  
	,dn_node_id    
	,dn_node_type  
	,up_basin_id   
	,up_sub_basin_id   
--	,up_node_xcoord    
--	,up_node_ycoord    
	,up_node_elev  
	,up_node_grnd_elev   
	,dn_basin_id   
	,dn_sub_basin_id   
--	,dn_node_xcoord    
--	,dn_node_ycoord    
	,dn_node_elev  
	,dn_node_grnd_elev   
	,slope   
--	,asbuilt_date  
--	,pipe_length1  
	,pipe_id 
	,map_grid    
	,map_quad    
	,pipe_num    
--	,ats 
from   GARLAND.UTSANPIP;

commit;
alter rollback segment rb1   offline;




COMMIT;


