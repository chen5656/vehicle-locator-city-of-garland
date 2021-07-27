
--	========================================================================
/*
	
	SIDE CONTROL

		str			the street being processed
		
		last_id		last region id before empty region (lo_seq)

		lo_seq		where is first empty region
		hi_seq 		where is last  empty region

		lo_blk		hundred block of first empty block
		hi_blk		hundred block of last  empty block
	

	SIDE CONTROL OBJECTS

		side
		even
		odd


	CONTROLS

		parity		which side of the street (0=even, 1=odd)

		this.str		current street on adrBlock_Side
		this.id		current region

	CONSTANTS

		empty 		space


	CONCEPTS

		a street consists of a series of 100 blocks (adrBlock)
		each street has 1 or more blocks
		each street has 2 sides: even or odd
		each side has a parity = 0 or 1 (even or odd)

		a street side may contain a string of blocks with the same region
		a street side may contain a string of blocks with empty (unassigned) regions

		if a string of empty regions lies between 2 blocks with the same region,
			then the empty regions are "filled" with that region id
		if a string of empty regions lies between 2 blocks with different regions,
			then those empty regions are left "vacant"
		if a street side begins or ends with a string of empty regions,
			then those empty regions are left "dangling"

		gis_app_rowid is a table containing a sequence number and a rowid field pointing to
			each record in adrBlock 
		gis_app_rowid is sequenced to point to adrBlock in street hundred-block order
	
		the "side control" is a means of tracking the empty strings of blocks on a street
		two "side controls" exist: one for even addresses & one for odd addresses


--	an empty region (lo_id) will trigger either:
--		nothing,	if the previous region was empty
--		initialize	side controls for empty series

--	a non_empty (existing) region (hi_id) will trigger either:
--		nothing,	 if no empty regions are around
--		a "filling", if it borders an empty series and matches the last region		(lo_id)
--		a "vacancy", if it borders an empty series and doesn't match the last region	(lo_id)



--	if the region is empty   then track its lower & upper row sequences
--	if the empty just began, then remember the previous existing region (lo = hi)
--	if at beginning of street, then hi_id will be null
--	lo_seq > 0 indicates that an empty string is currently being processed


	DDD


--	if the same region id bounds a series of empty regions,
--		then "fill" the empty regions
--	if the region ids are different or one of them is null, 
--		then continue on
--	only existing & equal region ids are considered


	LLL

--	"initial" or "interior" vacancy
--	if different regions bound a series of empty regions
--	then the interior regions are left "vacant"

	PPP

--	save this side info
--	obtain next block record
--	get  next side info

	TTT

--	"dangling" vacancy
--	if this is a new street,	
--		then check for previous "vacant" status
--		then reset side controls

*/
--	========================================================================

