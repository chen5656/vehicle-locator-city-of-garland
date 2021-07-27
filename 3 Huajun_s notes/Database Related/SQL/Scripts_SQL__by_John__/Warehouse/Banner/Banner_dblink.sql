--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	800;
set pagesize	9999;
--	alter session	set nls_date_format = 'yyyymmdd';  
--	=====================================================================
--	User LogOn	

--		umstrn01
--		one_up_it 
--		banBPRD , banTST1
--	======================================================================

	select owner, rpad(table_name,30) tablename, column_name, 
		 rpad(data_type,20)  data_type, 
		 data_length, nullable
	from all_tab_columns@banbprd
	where table_name = 'UCBPREM'
	order by column_id;


	select count(*), min(ucbprem_code), max(ucbprem_code)  
	from UCBPREM@banbprd
	where translate(ucbprem_code, '/1234567890','/') is null
	and ucbprem_code < '9';

--	======================================================================
