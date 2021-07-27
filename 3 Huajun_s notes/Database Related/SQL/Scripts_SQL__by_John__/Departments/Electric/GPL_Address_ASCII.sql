	set echo		off;
	set fetchrows;

--	desc cdreladr;

	spool	c:\deacutis\extract\gpl_address.txt;

	select 
		addr_num		||','||
		addr_pfx		||','||
		addr_name		||','||
		addr_type		||','||
		addr_sfx		||','||
		parcel_id		||','||
		mslink
		" "
	from
(
	select distinct
		addr_name, addr_type, addr_pfx, addr_sfx, addr_num,
		max(parcel_id)	parcel_id, 
		max(mslink)		mslink
	from		garland.cdreladr
	group by	addr_name, addr_type, addr_pfx, addr_sfx, addr_num
	order by	1,2,3,4,5
);


	spool		off;
	set echo	on;
	set fetchrows;

