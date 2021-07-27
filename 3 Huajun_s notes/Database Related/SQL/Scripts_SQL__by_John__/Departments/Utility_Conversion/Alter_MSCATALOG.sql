	set echo	off;
--	=================================================================================

--	update garland.mscatalog  set tablename = 'utsanlatr' where entitynum = 2170;
--	update garland.mscatalog  set tablename = 'utsanlift' where entitynum = 2169;
--	update garland.mscatalog  set tablename = 'utsanmanh' where entitynum = 2167;

--	update garland.mscatalog  set tablename = 'utsanpipe' where entitynum = ;

--	update garland.mscatalog  set tablename = 'utstoinlt' where entitynum = 2184;
--	update garland.mscatalog  set tablename = 'utstomanh' where entitynum = 2186;
--	update garland.mscatalog  set tablename = 'utstochan' where entitynum = 2185;

--	update garland.mscatalog  set tablename = 'utstojunc' where entitynum = 5031;
--	update garland.mscatalog  set tablename = 'utstooutf' where entitynum = 5032;
--	update garland.mscatalog  set tablename = 'utstopond' where entitynum = 5033;

	update garland.mscatalog  set tablename = 'utstohwal' where entitynum = 5029;

--	update garland.mscatalog  set tablename = 'utstopipe' where entitynum = .


--	update garland.mscatalog  set tablename = 'utwatfitt' where entitynum = 1436;
--	update garland.mscatalog  set tablename = 'utwathydr' where entitynum = 1595;
--	update garland.mscatalog  set tablename = 'utwattank' where entitynum = 2188;
--	update garland.mscatalog  set tablename = 'utwatvalv' where entitynum = 1596;

--	update garland.mscatalog  set tablename = 'utwatpump' where entitynum = ;
--	update garland.mscatalog  set tablename = 'utwatpipe' where entitynum = ;


	commit;
	rollback;

--	=================================================================================

/*

--	select '	select max(mslink) "' || new_table || '" from garland.' || new_table || ';'  " "
--	from		temp_view;


*/

--	=================================================================================
	set echo	on;
