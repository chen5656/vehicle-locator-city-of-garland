	set echo 		off;
	set charwidth	200;
--	=======================================================================================================

	select '   select ''' ||table_name|| ''' " " from dual;'		||chr(10)||
		 '   select * from ('							||

--		 ' select * from garland.' ||table_name|| '_COPY'		||	
--		 ' minus select * from garland.' 					||
--		   table_name ||'@SDET.WORLD ' 					|| 

--		 ' select * from garland.' ||table_name|| '@SDET.WORLD'	||	
--		 ' minus select * from garland.' 					||
--		   table_name ||'_COPY ' 						|| 


--		 ' select * from garland.' ||table_name|| '_COPY'		||	
--		 ' minus select * from garland.' 					||
--		   table_name 			 					|| 


		 ' select * from garland.' ||table_name				||	
		 ' minus select * from garland.' 					||
		   table_name ||'_COPY ' 						|| 


		 ' );'
	" "
	from	all_tables
	where	owner = 'GARLAND'
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


