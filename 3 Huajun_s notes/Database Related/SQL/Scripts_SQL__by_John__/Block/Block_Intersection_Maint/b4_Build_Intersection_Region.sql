
	select to_char(sysdate, 'Mon dd,yyyy  hh24:mi') || '  UPDATE INTERSECTION REGIONS' " "	from dual;

--	Clone to update each Intersection region column


	update garland.Intersection		x
	set	 x.POLICE_BEAT	=				--  SPECIFY
(
	select r.region_id
	from	 garland.Intersection_Region	r,
		 garland.Specification		s

	where	 r.intersect_id	= x.intersect_id
	and	 r.priority		= 01
	and	 r.region_type	= s.region_type
	and	 s.topic		= 'REGION TYPE'
	and	 s.region_name	= 'POLICE BEAT'		--  SPECIFY
);