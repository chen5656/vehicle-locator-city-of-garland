	set echo		off;
	set charwidth	200;
--	================================================================================================
--	
--	================================================================================================

	select	'	update garland.' || table_name || '  set ' || object_num ||
			'  =  garland.Assign_Utility_Num (''' || table_name || ''', map_grid, map_quad );'
	" "

	from		garland.Temp_View1;

--	================================================================================================
	set echo		on;
	set charwidth;
