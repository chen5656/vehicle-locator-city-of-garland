
--	***************************************************
   
select 'UTWATFITT' " "  from dual;

	-- truncate table	GARLAND.UTWATFITT		REUSE STORAGE;
    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

   -- explain plan  set statement_id = 'UTWATFITT' for 
  
insert into GARLAND.UTWATFITT
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
	,zone    
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
	,zone    
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
   
select 'UTWATHYDR' " "  from dual;

	-- truncate table	GARLAND.UTWATHYDR		REUSE STORAGE;
    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

   -- explain plan  set statement_id = 'UTWATHYDR' for 
  
insert into GARLAND.UTWATHYDR
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
   
select 'UTWATMETR' " "  from dual;

	-- truncate table	GARLAND.UTWATMETR		REUSE STORAGE;
    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

   -- explain plan  set statement_id = 'UTWATMETR' for 
  
insert into GARLAND.UTWATMETR
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
   
select 'UTWATPIPE' " "  from dual;

	-- truncate table	GARLAND.UTWATPIPE		REUSE STORAGE;
    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

   -- explain plan  set statement_id = 'UTWATPIPE' for 
  
insert into GARLAND.UTWATPIPE
(    
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

select 'UTWATPUMP' " "  from dual;

	-- truncate table	GARLAND.UTWATPUMP		REUSE STORAGE;
   
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

   -- explain plan  set statement_id = 'UTWATPUMP' for 
 
insert into GARLAND.UTWATPUMP
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
  
select 'UTWATTANK' " "  from dual;

	-- truncate table	GARLAND.UTWATTANK		REUSE STORAGE;
    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

   -- explain plan  set statement_id = 'UTWATTANK' for 
  
insert into GARLAND.UTWATTANK
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
   
select 'UTWATVALV' " "  from dual;

	-- truncate table	GARLAND.UTWATVALV		REUSE STORAGE;
    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

   -- explain plan  set statement_id = 'UTWATVALV' for 
  
insert into GARLAND.UTWATVALV
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
   

COMMIT;
