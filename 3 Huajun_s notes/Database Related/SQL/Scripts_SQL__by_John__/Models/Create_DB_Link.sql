
--	========================================================
--	successful
--	obtain connect string from SID in ORANT/NETWORK/ADMIN/TNSNAMES.ORA

	create public database link 	umsp.world	
	using 'umsp';

	select * from all_tables@umsp.world		where rownum < 11;

--	========================================================





--	========================================================

	drop database link	rms;

	create database link 	rms
	connect to 			leads
	identified by 		leads
	using 			'rms';

	select count(*) from	lwmain@rms;

--	========================================================

	drop database link	icad;

	create database link 	icad
	connect to 			leads
	identified by 		leads
	using 			'icad';

	select count(*) from	user_tables@icad;

--	========================================================

