	set echo	off;


--	verify street prefixes

	select	parcel_id,
			rpad (addr_num, 06)	"num",
			rpad (addr_pfx, 02)	"pf",
			rpad (addr_name,20)	"name",
			rpad (addr_type,04)	"type",
			rpad (addr_sfx, 02)	"sf"
	from		garland.cdreladr
	where		nvl (addr_pfx, ' ') not in (' ', 'N', 'S', 'E', 'W', 'NE', 'NW', 'SE', 'SW')
	;


--	verify street suffixes 

	select	parcel_id,
			rpad (addr_num, 06)	"num",
			rpad (addr_pfx, 02)	"pf",
			rpad (addr_name,20)	"name",
			rpad (addr_type,04)	"type",
			rpad (addr_sfx, 02)	"sf"

	from		garland.cdreladr
	where		nvl (addr_sfx, ' ') not in (' ', 'N', 'S', 'E', 'W', 'NE', 'NW', 'SE', 'SW')
	;


	set echo	on;