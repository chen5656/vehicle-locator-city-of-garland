
	drop database link	police;

	create database link 	police
	connect to 			leads	
	identified by 		leads
	using 			'rms.world';

	select	count(*) from ucr2st@police;








