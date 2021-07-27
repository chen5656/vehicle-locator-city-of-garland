	set echo off;
--	========================================================================================

--	select '	truncate table JDEACUTIS.' || table_name || '  reuse storage; '		" "


	select '	alter table JDEACUTIS.' || table_name || ' modify ' || column_name || 
		 ' varchar2(10); '

	" "
	from	all_tab_columns

--	where	owner = 'JDEACUTIS'
	where	owner = 'GARLAND'

	and	table_name like 'UTWAT%'
	and	length(table_name) <= 10

	and	column_name like '%BASIN%'
	;


/*
--------------------------------------------------------------------------------
	alter table JDEACUTIS.UTSANLAT modify BASIN varchar2(10);                      
	alter table JDEACUTIS.UTSANLAT modify SUB_BASIN varchar2(10);                  
	alter table JDEACUTIS.UTSANLAT modify SUB_SUBBASIN varchar2(10);               
	alter table JDEACUTIS.UTSANLST modify BASIN varchar2(10);                      
	alter table JDEACUTIS.UTSANLST modify SUB_BASIN varchar2(10);                  
	alter table JDEACUTIS.UTSANLST modify SUB_SUBBASIN varchar2(10);               
	alter table JDEACUTIS.UTSANMH modify BASIN varchar2(10);                       
	alter table JDEACUTIS.UTSANMH modify SUB_BASIN varchar2(10);                   
	alter table JDEACUTIS.UTSANMH modify SUB_SUBBASIN varchar2(10);                
	alter table JDEACUTIS.UTSANPIP modify BASIN varchar2(10);                      
	alter table JDEACUTIS.UTSANPIP modify SUB_BASIN varchar2(10);                  
	alter table JDEACUTIS.UTSANPIP modify SUB_SUBBASIN varchar2(10);               
	alter table JDEACUTIS.UTSANPIP modify UP_BASIN_ID varchar2(10);                
	alter table JDEACUTIS.UTSANPIP modify UP_SUB_BASIN_ID varchar2(10);            
	alter table JDEACUTIS.UTSANPIP modify DN_BASIN_ID varchar2(10);                
	alter table JDEACUTIS.UTSANPIP modify DN_SUB_BASIN_ID varchar2(10);            

--------------------------------------------------------------------------------

	alter table JDEACUTIS.UTWATFIT modify SUB_BASIN varchar2(10);                  
	alter table JDEACUTIS.UTWATFIT modify SUB_SUBBASIN varchar2(10);               
	alter table JDEACUTIS.UTWATHYD modify SUB_BASIN varchar2(10);                  
	alter table JDEACUTIS.UTWATHYD modify SUB_SUBBASIN varchar2(10);              
	alter table JDEACUTIS.UTWATPIP modify SUB_BASIN varchar2(10);                  
	alter table JDEACUTIS.UTWATPIP modify SUB_SUBBASIN varchar2(10);              
	alter table JDEACUTIS.UTWATVLV modify SUB_BASIN varchar2(10);                  
	alter table JDEACUTIS.UTWATVLV modify SUB_SUBBASIN varchar2(10);               
	alter table JDEACUTIS.UTSTOOUT modify RECEIVING_SUB_BASIN varchar2(10);        

--------------------------------------------------------------------------------
*/

--	========================================================================================
	set echo on;
