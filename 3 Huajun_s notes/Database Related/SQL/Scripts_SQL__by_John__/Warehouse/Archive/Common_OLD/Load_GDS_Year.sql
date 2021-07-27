
	truncate table garland.gds_year  reuse storage;

	insert --+ append
	into   garland.gds_year  
			(account, year, acct_type)
	select	 account, year, acct_type 
	from jdeacutis.gds_year_external;

   commit;   
