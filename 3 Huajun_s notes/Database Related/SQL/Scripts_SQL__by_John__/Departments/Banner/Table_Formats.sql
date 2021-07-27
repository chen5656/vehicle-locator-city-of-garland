	set echo off;

	select 
--		rpad(owner,      10) owner,
		rpad(table_name, 20) table_name, 
		column_name, 
		rpad(data_type,  10) data_type,  
		lpad(data_length,06) length

	from all_tab_columns@BPRD.world 

--	where table_name = 'UCBPREM'
	where table_name = 'UCBCUST'

--	where column_name like '%PREM_CODE%'
--	and	table_name like 'UCB%'

	order by column_id;

