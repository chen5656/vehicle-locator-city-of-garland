--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	800;
set pagesize	9999;
--	alter session	set nls_date_format = 'yyyymmdd';  
--	=====================================================================

	select
		rpad(table_owner,	15)		table_owner,
		rpad(table_name,	15)		table_name,
		index_name, 
		rpad(column_name,	30)		column_name, 
		lpad(column_position,4)		posn

	from all_ind_columns 

	where table_name in ( 'UCBPREM',  'UCBCUST', 'UCRACCT'  ) 

	order by 1,2;


--	======================================================================
