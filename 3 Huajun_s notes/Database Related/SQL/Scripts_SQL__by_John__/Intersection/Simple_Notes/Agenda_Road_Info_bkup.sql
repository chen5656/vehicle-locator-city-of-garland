=========================================================================
/*
		Road ID	(overlay ObjectID)
		Street ID
		Lo Block
		Hi BLock
		Quadrant
*/
=========================================================================


	update garland.ROAD_NODE_BLOCK	B
	set	(roadid, streetid, lo_block, hi_block) = 
(
	select	
		roadid, streetid, trunc(rangelo,-2), trunc(rangehi,-2)
	from	gis.ROAD_SDE	R
	where	r.objectid = b.roadid
);

=========================================================================

