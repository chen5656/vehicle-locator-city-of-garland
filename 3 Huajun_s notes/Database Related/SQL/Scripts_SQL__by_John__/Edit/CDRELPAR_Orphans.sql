	set echo off;

--	display parcel id's not associated with either an address or a tax account

--	select count(*) from cdrelpar;				--	64159
--	select count(*) from tax_abstract;				--	924


--	truncate table 	plan_table;
--	explain plan	set statement_id = 'test'	for


--	select	count(*)  "Orphans"				--	2059

	select	rpad (mslink, 07)		mslink,
			parcel_id,
			tax_acct

	from		garland.cdrelpar
	where		parcel_id		in

(
	select 	parcel_id						
	from		garland.cdrelpar

	minus
	select	parcel_id
	from		garland.cdreladr

	minus
	select	parcel_id
	from		garland.tax_abstract
)
	order by	parcel_id;	
	

--	@c:\deacutis\scripts\plans\exhibit.sql;

	set echo	on;