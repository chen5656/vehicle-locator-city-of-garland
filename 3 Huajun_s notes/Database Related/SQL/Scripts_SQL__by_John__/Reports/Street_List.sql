	set echo	off;

--	display streets from CDRELADR & TRVEHRCL


	select 	'	' " ", addr_pfx " ", addr_name " ", addr_type " ", addr_sfx " ", '	' " "			
	from		garland.cdreladr

	union

	select 	'	', addr_pfx, addr_name, addr_type, addr_sfx, '	centerline'		
	from		garland.trvehrcl		r
	where		addr_name > '0'
	and		not exists
(
	select	'x'
	from		garland.cdreladr
	where		addr_name = r.addr_name
	and		addr_type = r.addr_type
	and		addr_pfx  = r.addr_pfx
	and		addr_sfx  = r.addr_sfx
)
	order by 	3,4,2,5;



	set echo	on;
