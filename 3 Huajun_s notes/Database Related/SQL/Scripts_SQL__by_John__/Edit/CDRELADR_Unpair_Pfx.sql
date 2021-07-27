
--	display street names containing unpaired prefix
--	Example:   E Apollo exists, but no W Apollo exists


	select	
			addr_pfx		"pf",
			addr_name		"name",
			addr_type		"type",
			addr_sfx		"sf"

	from		garland.adrstreets
	where	(	addr_name,
			addr_type	)


	in
(
	select	addr_name,
			addr_type
	from		garland.adrstreets
	group by	addr_name,
			addr_type

	having	variance	(
			decode	(addr_pfx,
					' ',		'1',
					'N',		'2',
					'S',		'2',
					'E',		'3',
					'W',		'3',
							'0')
					)				> 0

);
