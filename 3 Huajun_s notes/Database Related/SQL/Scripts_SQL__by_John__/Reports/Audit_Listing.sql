	set echo	off;
--	==================================================================================================
	
	select 'CDRELPAR  ' " ", person, to_char(timestamp,'mm-yyyy') time, action, counter "     TOTAL"
	from
(
	select person, trunc(timestamp,'mm') timestamp, action, count(*) counter
	from garland.cdrelpar_audit

	where	lower(person)	= 'snguyen'
	and	action		= 'I'	 	
	group by person, trunc(timestamp,'mm'), action
)
	order by person, timestamp, action;

--	==================================================================================================
	
	select 'CDRELADR  ' " ", person, to_char(timestamp,'mm-yyyy') time, action, counter "     TOTAL"
	from
(
	select person, trunc(timestamp,'mm') timestamp, action, count(*) counter
	from garland.cdreladr_audit

	where	lower(person)	= 'ddarby'
	and	action		= 'I'	 	
	group by person, trunc(timestamp,'mm'), action
)
	order by person, timestamp, action;

--	==================================================================================================
	set echo	on;

