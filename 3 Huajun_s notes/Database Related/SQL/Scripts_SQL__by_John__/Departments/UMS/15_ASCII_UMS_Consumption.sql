	set echo	off;
	set termout	off;

	spool  c:\deacutis\extract\ums_charge.sql;

	select
		rtrim(parcel_id)		||','||
		rtrim(service_type)	||','||
		rtrim(bill_year)		||','||
		rtrim(consumption)
		" "

	from 	ums_charge

--	where	rownum < 1111
	;


	spool		off;
	set echo	on;
	set termout	on;
