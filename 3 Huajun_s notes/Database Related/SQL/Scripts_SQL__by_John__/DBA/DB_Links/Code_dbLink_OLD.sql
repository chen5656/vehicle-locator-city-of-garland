
--	========================================================

	drop database link	code_enforce.world;

	create database link 	code_enforce.world
	connect to 			cog
	identified by 		cogmstr
	using 			'cdep';

	select	count(*)
	from 		complain@code_enforce;


--	========================================================
