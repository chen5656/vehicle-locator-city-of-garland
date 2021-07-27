	set echo	off;
--	=================================================================================================

	insert into cdrelsubdv (subdiv_id, mapid, mslink) values ( '',		1009,		111031 );	
	insert into cdrelsubdv (subdiv_id, mapid, mslink) values ( 0,		1009,		111032 );	
	insert into cdrelsubdv (subdiv_id, mapid, mslink) values ( 1999,		1009,		111033 );	
	insert into cdrelsubdv (subdiv_id, mapid, mslink) values ( 1999,		1009,		111034	 );	

	insert into cdrelsubdv (subdiv_id, mapid, mslink) values ( 1956,		1009,		111561 );	
	insert into cdrelsubdv (subdiv_id, mapid, mslink) values ( 1956123,	1009,		111562 );	
	insert into cdrelsubdv (subdiv_id, mapid, mslink) values ( 1992,		1009,		111921 );	

	insert into cdrelsubdv (subdiv_id, mapid, mslink) values ( 1993,		1009,		111911 );	
	update cdrelsubdv_vw 	set subdiv_id = 1999					where mslink = 111911;

	insert into cdrelsubdv (subdiv_id, mapid, mslink) values ( 1999009,	1009,		111912 );	
	update cdrelsubdv_vw 	set subdiv_id = 1991019					where mslink = 111912;

	insert into cdrelsubdv (subdiv_id, mapid, mslink) values ( 1993,		1009,		111913 );	
	update cdrelsubdv_vw 	set subdiv_id = 1999					where mslink = 111913;


	update cdrelsubdv_vw	set mslink = 111801					where mslink = 111562;
	update cdrelsubdv_vw	set mapid  = 1001						where mslink = 111562;

	update cdrelsubdv_vw	set filing_date = '20010911'				where mslink = 111032;
	update cdrelsubdv_vw	set filing_date = '2001/09/12'			where mslink = 111033;

	update cdrelsubdv_vw	set login_date = '200304'				where mslink = 111032;
	update cdrelsubdv_vw	set login_date = '2003/05'				where mslink = 111033;

	update cdrelsubdv_vw	set filing_date = null					where mslink = 111032;
	update cdrelsubdv_vw	set login_date  = null					where mslink = 111032;


/*
--	ERRORS
	set echo on;

	update cdrelsubdv_vw	set subdiv_id = null					where mslink = 111561;

	update cdrelsubdv_vw	set subdiv_id = 1899					where mslink = 111561;

	update cdrelsubdv_vw	set filing_date = '200109'				where mslink = 111032;

	update cdrelsubdv_vw	set filing_date = '2001/09/31'			where mslink = 111033;

	update cdrelsubdv_vw	set login_date = '2003'					where mslink = 111032;

	update cdrelsubdv_vw	set login_date = '2003/20'				where mslink = 111033;

	set echo off;

--	SUBDIVISION ID = NO DEFAULT

--	insert into cdrelsubdv (subdiv_id, mapid, mslink) values ( null,		1009,		111031 );	
--	update cdrelsubdv_vw 	set subdiv_id = null					where mslink = 111031;

*/
--	=================================================================================================

--	select subdiv_id, filing_date, login_date, mslink, mapid 	from garland.cdrelsubdv	order by mslink;
	select subdiv_id, filing_date, login_date, mslink, mapid 	from garland.cdrelsubdv	order by subdiv_id;

	rollback;
--	commit;

--	=================================================================================================

--	delete from cdrelsubdv	where mslink >= 111000;
--	commit;

--	=================================================================================================
--	desc	cdrelsubdv;

--	=================================================================================================
	set echo	on;
