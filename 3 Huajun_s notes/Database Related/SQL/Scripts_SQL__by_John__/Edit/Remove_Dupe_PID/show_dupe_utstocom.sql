
--	desc utstocom;
	set fetchrows;
	select rpad(' ', 70, ' ') " "	from dual;


--	truncate table	plan_table;
--	explain plan	set statement_id = 'test'		for

--	select	count(*)

	select	u.parcel_id				"parcel id"
			,rpad(u.mslink,  6)		"mslink"
			,rpad(u.account, 7)		"account"
			,rpad(a.addr_num,5)		" "
			,a.addr_pfx				" "
			,a.addr_name			"address"
			,a.addr_type			" "
			,a.addr_sfx				" "

	from		utstocom	u,
			cdreladr	a

	where		u.addr_name	= a.addr_name	(+)
	and		u.addr_type	= a.addr_type	(+)
	and		u.addr_pfx	= a.addr_pfx	(+)
	and		u.addr_num	= a.addr_num	(+)

	and		u.parcel_id	in		
(
	select 	parcel_id						
	from		utstocom
	group by	parcel_id
	having	count(*) > 1
)
	order by	u.parcel_id, u.mslink;



--	select * from explain_plan;
--	select * from explain_indexed;
--	select * from explain_analyze;

