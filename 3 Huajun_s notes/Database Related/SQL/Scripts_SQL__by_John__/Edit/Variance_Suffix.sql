	set	echo off;

--	display streets having both blank & non-blank suffixes

	select	addr_pfx	"pf",
			addr_name	"name",
			addr_type	"type",
			addr_sfx	"sf",
			street_id	"id"
	from		adrStreets

	where	    (	addr_name, addr_type, addr_pfx  )	in
(
	select	addr_name, addr_type, addr_pfx
	from		adrstreet
	group by	addr_name, addr_type, addr_pfx
	having	variance (translate (addr_sfx, ' NSEW', '01122')) > 0
);

--	==================================================================================

	select	addr_name	"name", 
			addr_type	"type", 
			addr_pfx	"pf", 
			to_char (variance (translate (addr_sfx, ' NSEW', '01122')), 'b999.999') "variance"

	from		adrstreet
	group by	addr_name, addr_type, addr_pfx
	having	variance (translate (addr_sfx, ' NSEW', '01122')) > 0

--	==================================================================================

