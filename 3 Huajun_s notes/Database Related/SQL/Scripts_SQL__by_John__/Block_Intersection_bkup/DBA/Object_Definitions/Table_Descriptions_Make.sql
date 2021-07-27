	set echo off;

	select '	desc ' || table_name || ';' " "

	from	tabs

	where table_name not like '%COPY'	
	and	table_name not like '%BKUP'	
	and	table_name not like '%ATS1'	
	and	table_name not like 'POPCN%'	
	and	table_name not like 'RI05%'	
	and	table_name not like 'EVT%'	
	and	table_name not like 'SM%'	

	order by 1;

	set echo on;

