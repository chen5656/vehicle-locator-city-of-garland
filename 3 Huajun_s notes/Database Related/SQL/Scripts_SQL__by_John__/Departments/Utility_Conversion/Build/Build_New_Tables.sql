    
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    
select 'UTSANARW' " "  from dual;
    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

	explain plan  set statement_id = 'UTSANARW' for 
  
insert into JDEACUTIS.UTSANARW
(    
	 mslink  
	,mapid   
--	,ats 
)
select  
	 mslink  
	,mapid   
--	,ats 
from   GARLAND.UTSANARW;

commit;
alter rollback segment rb1   offline;


--	***************************************************
   
select 'UTSANFIT' " "  from dual;
    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

	explain plan  set statement_id = 'UTSANFIT' for 
  
insert into JDEACUTIS.UTSANCLN
(    
	 mslink  
	,mapid   
--	,fitting_id    
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
)
select  
	 mslink  
	,mapid   
--	,fitting_id    
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
from   GARLAND.UTSANFIT;

commit;
alter rollback segment rb1   offline;


--	***************************************************
   
select 'UTSANLAT' " "  from dual;
    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

	explain plan  set statement_id = 'UTSANLAT' for 
  
insert into JDEACUTIS.UTSANLAT
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
	,up_node_id				--
	,dn_node_id				--
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
   
select 'UTSANLST' " "  from dual;
    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

	explain plan  set statement_id = 'UTSANLST' for 
  
insert into JDEACUTIS.UTSANLST
(    
	 mslink  
	,mapid   
	,liftsta_id    
	,map_grid    
	,map_quad    
	,liftsta_num   
	,description
	,liftsta_size  
	,basin   
	,sub_basin   
	,sub_subbasin  
	,up_node_id				--
	,dn_node_id 			--
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
   
select 'UTSANMH' " "  from dual;
 
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

	explain plan  set statement_id = 'UTSANMH' for 
 
insert into JDEACUTIS.UTSANMH
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
--	,upstream_node 
--	,dnstream_node 
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
--	,upstream_node 
--	,dnstream_node 
--	,asbuilt_date  
--	,ats 
from   GARLAND.UTSANMH;

commit;
alter rollback segment rb1   offline;


--	***************************************************
    
select 'UTSANPIP' " "  from dual;
    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

	explain plan  set statement_id = 'UTSANPIP' for 
  
insert into JDEACUTIS.UTSANPIP
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


--	***************************************************
/*
   
select 'UTSTOARW' " "  from dual;
    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

	explain plan  set statement_id = 'UTSTOARW' for 
  
insert into JDEACUTIS.UTSTOARW
(    
	 mslink  
	,mapid   
--	,ats 
)
select  
	 mslink  
	,mapid   
--	,ats 
from   GARLAND.UTSTOARW;

commit;
alter rollback segment rb1   offline;


*/
--	***************************************************
   
select 'UTSTOHDWL' " "  from dual;
   
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

	explain plan  set statement_id = 'UTSTOHDWL' for 
 
insert into JDEACUTIS.UTSTOHDWL
( 
	 mslink  
	,mapid   
--	,ats 
)
select  
	 mslink  
	,mapid   
--	,ats 
from   GARLAND.UTSTOHDWL;

commit;
alter rollback segment rb1   offline;


--	***************************************************
  
select 'UTSTOINL' " "  from dual;
    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

	explain plan  set statement_id = 'UTSTOINL' for 
  
insert into JDEACUTIS.UTSTOINL
(    
	 mslink  
	,mapid   
	,inlet_id    
	,inlet_code    
	,map_grid    
	,map_quad    
	,inlet_num   
	,inlet_type    
	,inlet_size    
--	,asbuilt_date  
--	,ats 
)
select  
	 mslink  
	,mapid   
	,inlet_id    
	,inlet_code    
	,map_grid    
	,map_quad    
	,inlet_num   
	,inlet_type    
	,inlet_size    
--	,asbuilt_date  
--	,ats 
from   GARLAND.UTSTOINL;

commit;
alter rollback segment rb1   offline;


--	***************************************************
   
select 'UTSTOJUN' " "  from dual;
    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

	explain plan  set statement_id = 'UTSTOJUN' for 
  
insert into JDEACUTIS.UTSTOJUN
(    
	 mslink  
	,mapid   
)
select  
	 mslink  
	,mapid   
from   GARLAND.UTSTOJUN;

commit;
alter rollback segment rb1   offline;

--	***************************************************
   
select 'UTSTOMH' " "  from dual;
 
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

	explain plan  set statement_id = 'UTSTOMH' for 
 
insert into JDEACUTIS.UTSTOMH
( 
	 mslink  
	,mapid   
	,manhole_id    
	,map_grid    
	,map_quad    
	,manhole_num   
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
--	,asbuilt_date  
--	,ats 
from   GARLAND.UTSTOMH;

commit;
alter rollback segment rb1   offline;


--	***************************************************
    
select 'UTSTONCH' " "  from dual;
    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

	explain plan  set statement_id = 'UTSTOOCH' for 
  
insert into JDEACUTIS.UTSTOCHN
(    
	 mslink  
	,mapid   
	,channel_type  
	,channel_desc  
	,general_comments				--
--	,channel_size  
	,channel_length    
--	,quantity    
--	,boxwide 
--	,boxtall 
--	,year_blt    
--	,flag    
	,channel_id    
	,map_grid    
	,map_quad    
	,channel_num   
--	,pipe_length1  
--	,ats 
)
select  
	 mslink  
	,mapid   
	,channel_type  
	,channel_desc  
	,general_desc
--	,channel_size  
	,channel_length    
--	,quantity    
--	,boxwide 
--	,boxtall 
--	,year_blt    
--	,flag    
	,channel_id    
	,map_grid    
	,map_quad    
	,channel_num   
--	,pipe_length1  
--	,ats 
from   GARLAND.UTSTOOCH;

commit;
alter rollback segment rb1   offline;


--	***************************************************
   
select 'UTSTOOUT' " "  from dual;
    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

	explain plan  set statement_id = 'UTSTOOUT' for 
  
insert into JDEACUTIS.UTSTOOUT
(    
	 mslink  
	,mapid   
)
select  
	 mslink  
	,mapid   
from   GARLAND.UTSTOOUT;

commit;
alter rollback segment rb1   offline;


--	***************************************************
   
select 'UTSTOPIP' " "  from dual;
    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

	explain plan  set statement_id = 'UTSTOPIP' for 
  
insert into JDEACUTIS.UTSTOPIP
(    
	 mslink  
	,mapid   
	,pipe_type   
	,general_comments			-- pipe desc
	,general_desc  			-- 
--	,pipe_size   
	,pipe_length   
	,quantity    
	,boxwide 
	,boxtall 
--	,year_blt    
--	,flag    
	,pipe_id 
	,map_grid    
	,map_quad    
	,pipe_num    
--	,pipe_length1  
--	,ats 
)
select  
	 mslink  
	,mapid   
	,pipe_type   
	,pipe_desc   
	,general_desc  
--	,pipe_size   
	,pipe_length   
	,quantity    
	,boxwide 
	,boxtall 
--	,year_blt    
--	,flag    
	,pipe_id 
	,map_grid    
	,map_quad    
	,pipe_num    
--	,pipe_length1  
--	,ats 
from   GARLAND.UTSTOPIP;

commit;
alter rollback segment rb1   offline;


--	***************************************************
   
select 'UTSTOPON' " "  from dual;
    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

	explain plan  set statement_id = 'UTSTOPON' for 
  
insert into JDEACUTIS.UTSTOPON
(    
	 mslink  
	,mapid   
)
select  
	 mslink  
	,mapid   
from   GARLAND.UTSTOPON;

commit;
alter rollback segment rb1   offline;


--	***************************************************
/*   
select 'UTWATARW' " "  from dual;
    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

	explain plan  set statement_id = 'UTWATARW' for 
  
insert into JDEACUTIS.UTWATARW
(    
	 mslink  
	,mapid   
--	,ats 
)
select  
	 mslink  
	,mapid   
--	,ats 
from   GARLAND.UTWATARW;

commit;
alter rollback segment rb1   offline;

*/
--	***************************************************
   
select 'UTWATFIT' " "  from dual;
    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

	explain plan  set statement_id = 'UTWATFIT' for 
  
insert into JDEACUTIS.UTWATFIT
(    
	 mslink  
	,mapid   
	,fitting_id    
	,fitting_type  
	,fitting_size  
--	,fitting_width 
--	,fitting_length    
--	,material    
--	,class   
--	,structure_type    
--	,structure_id  
--	,fitting_use   
--	,fitting_status    
	,map_grid    
	,map_quad    
	,fitting_num   
--	,x_coord 
--	,y_coord 
--	,up_node_id    
--	,down_node_id  
	,manufacturer  
--	,asbuilt_date  
--	,owner   
--	,owner_status  
--	,contractor    
--	,contract_num  
--	,line_num    
--	,zone    
--	,sub_basin   
--	,sub_subbasin  
--	,flowline_elev 
--	,ground_elev   
	,pressure_normal   
--	,pressure_max  
	,pressure_source   
--	,repair_date   
	,work_order_num    
--	,inspection_date   
--	,data_source   
--	,user_flag   
--	,post_mode   
--	,date_add    
--	,ats 
)
select  
	 mslink  
	,mapid   
	,fitting_id    
	,fitting_type  
	,fitting_size  
--	,fitting_width 
--	,fitting_length    
--	,material    
--	,class   
--	,structure_type    
--	,structure_id  
--	,fitting_use   
--	,fitting_status    
	,map_grid    
	,map_quad    
	,fitting_num   
--	,x_coord 
--	,y_coord 
--	,up_node_id    
--	,down_node_id  
	,manufacturer  
--	,asbuilt_date  
--	,owner   
--	,owner_status  
--	,contractor    
--	,contract_num  
--	,line_num    
--	,zone    
--	,sub_basin   
--	,sub_subbasin  
--	,flowline_elev 
--	,ground_elev   
	,pressure_normal   
--	,pressure_max  
	,pressure_source   
--	,repair_date   
	,work_order_num    
--	,inspection_date   
--	,data_source   
--	,user_flag   
--	,post_mode   
--	,date_add    
--	,ats 
from   GARLAND.UTWATFIT;

commit;
alter rollback segment rb1   offline;


--	***************************************************
   
select 'UTWATHYD' " "  from dual;
    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

	explain plan  set statement_id = 'UTWATHYD' for 
  
insert into JDEACUTIS.UTWATHYD
(    
	 mslink  
	,mapid   
	,hydrant_id    
--	,hydrant_type  
--	,hydrant_material  
	,map_quad    
	,map_grid    
	,hydrant_num   
--	,x_coord 
--	,y_coord 
--	,valve_id    
--	,flowline_elev 
--	,ground_elev   
	,manufacturer  
--	,asbuilt_date  
	,hydrant_status    
	,hydrant_owner 
--	,owner_status  
--	,contractor    
--	,project_name  
--	,contract_num  
--	,line_num    
	,zone    
--	,sub_basin   
--	,sub_sub_basin 
	,pressure_static   
--	,pressure_max  
	,pressure_flow_test   
	,pressure_test_date  
--	,req_flow_rate 
--	,repair_date   
	,work_order_num    
--	,inspect_date  
--	,data_source   
--	,user_flag   
--	,post_mode   
--	,date_add    
--	,line_size   
--	,ats 
)
select  
	 mslink  
	,mapid   
	,hydrant_id    
--	,hydrant_type  
--	,hydrant_material  
	,map_quad    
	,map_grid    
	,hydrant_num   
--	,x_coord 
--	,y_coord 
--	,valve_id    
--	,flowline_elev 
--	,ground_elev   
	,manufacturer  
--	,asbuilt_date  
	,hydrant_status    
	,hydrant_owner 
--	,owner_status  
--	,contractor    
--	,project_name  
--	,contract_num  
--	,line_num    
	,zone    
--	,sub_basin   
--	,sub_sub_basin 
	,pressure_static   
--	,pressure_max  
	,pressure_flowtest   
	,pressure_test_date  
--	,req_flow_rate 
--	,repair_date   
	,work_order_num    
--	,inspect_date  
--	,data_source   
--	,user_flag   
--	,post_mode   
--	,date_add    
--	,line_size   
--	,ats 
from   GARLAND.UTWATHYD;

commit;
alter rollback segment rb1   offline;


--	***************************************************
   
select 'UTWATMTR' " "  from dual;
    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

	explain plan  set statement_id = 'UTWATMTR' for 
  
insert into JDEACUTIS.UTWATMTR
(    
	 mslink  
	,mapid   
--	,ats 
)
select  
	 mslink  
	,mapid   
--	,ats 
from   GARLAND.UTWATMTR;

commit;
alter rollback segment rb1   offline;


--	***************************************************
   
select 'UTWATPIP' " "  from dual;
    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

	explain plan  set statement_id = 'UTWATPIP' for 
  
insert into JDEACUTIS.UTWATPIP
(    
--	 project_no    
--	,project_name  
--	,subdivision_name  
--	,project_desc  
--	,asbuilt_date  
--	,inspector_name    
--	,contract_name 

	 map_grid    
	,map_quad    
	,mslink  
	,mapid   
	,pipe_diameter 
	,pipe_length   
	,pipe_material 
--	,up_node_id    
--	,dn_node_id    
--	,up_node_elev  
--	,up_node_grnd_elev   
--	,dn_node_elev  
--	,dn_node_grnd_elev   
--	,slope   
--	,pipe_class    
	,manufacturer   
--	,pipe_use    
--	,pipe_status   
--	,pipe_owner    
--	,pipe_owner_status   
--	,contractor    
--	,contract_num  
--	,line_num    
	,zone    
--	,sub_basin   
--	,sub_sub_basin 
	,pressure_normal   
--	,pressure_max  
--	,pressure_source   
--	,repair_date   
	,work_order_num    
--	,inspect_date  
--	,from_x_coord  
--	,from_y_coord  
--	,to_x_coord    
--	,to_y_coord    
--	,data_source   
--	,user_flag   
--	,post_mode   
--	,date_add    
	,pipe_id 
	,pipe_num    
--	,ats 
--	,comments    
)
select  
--	 project_no    
--	,project_name  
--	,subdivision_name  
--	,project_desc  
--	,asbuilt_date  
--	,inspector_name    
--	,contract_name 

	 map_grid    
	,map_quad    
	,mslink  
	,mapid   
	,pipe_diameter 
	,pipe_length   
	,pipe_material 
--	,up_node_id    
--	,dn_node_id    
--	,up_node_elev  
--	,up_node_grnd_elev   
--	,dn_node_elev  
--	,dn_node_grnd_elev   
--	,slope   
--	,pipe_class    
	,pipe_manufacturer   
--	,pipe_use    
--	,pipe_status   
--	,pipe_owner    
--	,pipe_owner_status   
--	,contractor    
--	,contract_num  
--	,line_num    
	,zone    
--	,sub_basin   
--	,sub_sub_basin 
	,pressure_normal   
--	,pressure_max  
--	,pressure_source   
--	,repair_date   
	,work_order_num    
--	,inspect_date  
--	,from_x_coord  
--	,from_y_coord  
--	,to_x_coord    
--	,to_y_coord    
--	,data_source   
--	,user_flag   
--	,post_mode   
--	,date_add    
	,pipe_id 
	,pipe_num    
--	,ats 
--	,comments    
from   GARLAND.UTWATPIP;

commit;
alter rollback segment rb1   offline;


--	***************************************************

select 'UTWATPSTA' " "  from dual;
   
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

	explain plan  set statement_id = 'UTWATPSTA' for 
 
insert into JDEACUTIS.UTWATPSTA
( 
	 mslink  
	,mapid   
	,pumpsta_id    
	,pumpsta_type  
	,map_grid    
	,map_quad    
	,pumpsta_num   
--+	,asbuilt_date  
--	,ats 
)
select  
	 mslink  
	,mapid   
	,pumpsta_id    
	,pumpsta_type  
	,map_grid    
	,map_quad    
	,pumpsta_num   
--	,asbuilt_date  
--	,ats 
from   GARLAND.UTWATPSTA;

commit;
alter rollback segment rb1   offline;

--	***************************************************
  
select 'UTWATTNK' " "  from dual;
    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

	explain plan  set statement_id = 'UTWATTNK' for 
  
insert into JDEACUTIS.UTWATTNK
(    
	 mslink  
	,mapid   
	,tank_id 
	,tank_type   
	,map_grid    
	,map_quad    
	,tank_num    
--	,asbuilt_date  
--	,ats 
)
select  
	 mslink  
	,mapid   
	,tank_id 
	,tank_type   
	,map_grid    
	,map_quad    
	,tank_num    
--	,asbuilt_date  
--	,ats 
from   GARLAND.UTWATTNK;

commit;
alter rollback segment rb1   offline;


--	***************************************************
   
select 'UTWATVLV' " "  from dual;
    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

	explain plan  set statement_id = 'UTWATVLV' for 
  
insert into JDEACUTIS.UTWATVLV
(    
	 mslink  
	,mapid   
	,valve_id    
	,valve_type    
	,valve_size    
--	,valve_use   
	,valve_status  
	,map_grid    
	,map_quad    
	,valve_num   
--	,x_coord 
--	,y_coord 
--	,up_node_id    
--	,down_node_id  
--	,structure_type    
--	,structure_id  
--	,fit_width   
--	,fit_length    
	,manufacturer  
--	,asbuilt_date  
--	,owner   
--	,owner_status  
--	,contractor    
--	,project_name  
--	,contract_num  
--	,line_num    
	,zone    
--	,sub_basin   
--	,sub_subbasin  
--	,flowline_elev 
--	,ground_elev   
	,pressure_normal   
--	,pressure_max  
--	,pressure_source   
--	,repair_date   
	,work_order_num    
--	,inspect_date  
--	,data_source   
--	,user_flag   
--	,post_mode   
--	,date_add    
--	,material    
--	,class   
--	,ats 
)
select  
	 mslink  
	,mapid   
	,valve_id    
	,valve_type    
	,valve_size    
--	,valve_use   
	,valve_status  
	,map_grid    
	,map_quad    
	,valve_num   
--	,x_coord 
--	,y_coord 
--	,up_node_id    
--	,down_node_id  
--	,structure_type    
--	,structure_id  
--	,fit_width   
--	,fit_length    
	,manufacturer  
--	,asbuilt_date  
--	,owner   
--	,owner_status  
--	,contractor    
--	,project_name  
--	,contract_num  
--	,line_num    
	,zone    
--	,sub_basin   
--	,sub_subbasin  
--	,flowline_elev 
--	,ground_elev   
	,pressure_normal   
--	,pressure_max  
--	,pressure_source   
--	,repair_date   
	,work_order_num    
--	,inspect_date  
--	,data_source   
--	,user_flag   
--	,post_mode   
--	,date_add    
--	,material    
--	,class   
--	,ats 
from   GARLAND.UTWATVLV;

commit;
alter rollback segment rb1   offline;


--	***************************************************
   
