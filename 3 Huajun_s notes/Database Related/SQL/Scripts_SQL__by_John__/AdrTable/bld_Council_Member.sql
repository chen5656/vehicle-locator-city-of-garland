
--	=============================================================================================================

--	truncate table	garland.council_member		reuse storage;

  insert into garland.Council_Member values ( '2', 'PERKINS COX', 'LAURA', '214-364-9319' );
  insert into garland.Council_Member values ( '3', 'HICKEY', 'HARRY', '972-226-2577' );
  insert into garland.Council_Member values ( '4', 'JEFFUS', 'LARRY', '972-686-5698' );
  insert into garland.Council_Member values ( '5', 'FEAGIN', 'JACKIE', '972-278-8315' );
  insert into garland.Council_Member values ( '6', 'CHICK', 'BARBARA', '972-276-2524' );
  insert into garland.Council_Member values ( '7', 'MONROE', 'MARK', '972-495-8028' );
  insert into garland.Council_Member values ( '8', 'DUNNING', 'RANDALL', '972-495-9654' );
  insert into garland.Council_Member values ( '0', 'DAY', 'BOB', '972-926-9971' );
  insert into garland.Council_Member values ( '1', 'ATHAS', 'DOUGLAS', '972-205-2121' );

	commit;

--	=============================================================================================================

	select * from garland.council_member;

--	=============================================================================================================
--	get current records

      select
	'  insert into garland.Council_Member values ( '''   ||
	council_district || ''', '''  || last_name || ''', ''' || first_name || ''', ''' || 
	home_phone || ''' );'
	" "
	from garland.council_member;

--	=============================================================================================================
--	demote current records
--	insert new records
--	delete demoted records

--	update garland.Council_Member set last_name = lower(last_name);

--	delete from garland.Council_Member where last_name = lower(last_name);

--	=============================================================================================================

