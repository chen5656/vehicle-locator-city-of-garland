--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	400;
set pagesize	9999;
-- alter session	set nls_date_format = 'yyyymmdd hh24:mi:ss';  
--	=====================================================================


	select rpad(a.column_name,25) column_name,  
		a.data_length, b.data_length, 
		lpad(a.data_type, 10) " ",	lpad(b.data_type, 10) " ", 
		lpad(a.table_name,20) " ",	lpad(b.table_name,20) " "
	from	all_tab_columns    A,
		all_tab_columns    B
	where a.column_name = b.column_name
	and	a.owner = 'GARLAND'
	and	b.owner = 'GARLAND'
	and	a.table_name = 'CCS_ADDRESS'
	and	b.table_name = 'CCS_ADDRESSES_MAKE'
	and (	a.data_length < b.data_length
	or	a.data_type <> b.data_type	
	or	a.column_id <> b.column_id	)
	;   