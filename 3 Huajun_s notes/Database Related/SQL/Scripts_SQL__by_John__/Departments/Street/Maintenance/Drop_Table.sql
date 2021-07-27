	set echo off;
	set charwidth	200;
--	================================================================================================================

	select '  drop  table garland.' || rpad(table_name,30) || ';' " "
	from	all_tables
	where owner = 'GARLAND'
	and	table_name in
(
	 'PAVEMENT_MASTER'
	,'PAVE_CUST'
	,'PAVE_CUST_ARCH'
	,'PAVE_MAST'
	,'PAVE_PROJ'
	,'PAVE_PROJ_APPR'
	,'PAVE_PROJ_ARCH'
	,'PAVE_SURF_MAST'
	,'PAVE_TASK'
	,'INSPECTION_MASTER'
	,'INSP_ARCH'
	,'WORK_MAST'
	,'GARLAND_WORK_MASTER'
	,'SURFACE_MASTER'
	,'N_PAVE_MAST'
	,''
);




--	================================================================================================================
/*

PAVEMENT_MASTER               
PAVEMENT_MASTER_COPY          
PAVE_CUST                     
PAVE_CUST_ARCH                
PAVE_CUST_ARCH_COPY           
PAVE_CUST_COPY                
PAVE_MAST                     
PAVE_MAST_COPY                
PAVE_MAST_TEST                
PAVE_PROJ                     
PAVE_PROJ_APPR                
PAVE_PROJ_APPR_COPY           
PAVE_PROJ_ARCH                
PAVE_PROJ_ARCH_COPY           
PAVE_PROJ_COPY                
PAVE_SURF_MAST                
PAVE_SURF_MAST_COPY           
PAVE_TASK                     
PAVE_TASK_COPY                

INSPECTION_MASTER             
INSP_ARCH                     
INSP_ARCH_BKUP                
WORK_MAST                     
GARLAND_WORK_MASTER           
SURFACE_MASTER                
N_PAVE_MAST

*/

--	================================================================================================================
/*
	select table_name from all_tables 
	where owner = 'GARLAND' 
	and table_name like '%PAVE%'
	order by table_name;


	select table_name from all_tables 
	where owner = 'GARLAND' 
	and table_name like '%COPY'
	order by table_name;

*/
--	================================================================================================================

