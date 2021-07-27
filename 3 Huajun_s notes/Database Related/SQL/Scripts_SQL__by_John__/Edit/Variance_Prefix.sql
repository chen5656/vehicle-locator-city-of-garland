	set	echo off;

--	display streets having both blank & non-blank prefixes

	select	addr_pfx	"pf",
			addr_name	"name",
			addr_type	"type",
			addr_sfx	"sf",
			street_id	"id"
	from		adrStreets

	where	    (	addr_name, addr_type, addr_sfx  )	in
(
	select	addr_name, addr_type, addr_sfx
	from		adrstreet
	group by	addr_name, addr_type, addr_sfx
	having	variance (translate (addr_pfx, ' NSEW', '01122')) > 0
);

--	==================================================================================

	select	addr_name	"name", 
			addr_type	"type", 
			addr_sfx	"sf", 
			to_char (variance (translate (addr_pfx, ' NSEW', '01122')), 'b999.999') "variance"

	from		adrstreet
	group by	addr_name, addr_type, addr_sfx
	having	variance (translate (addr_pfx, ' NSEW', '01122')) > 0

--	==================================================================================
