	set echo 		off;
	set fetchrows	11;
--	========================================

	select min(parcel_id)
	from	garland.water_ivr_parcel
	where	cluster_id	in	
	(  120901, 109290, 108297, 120864, 115234 )
	group by cluster_id;

--	========================================
/*
	select cluster_id
	from
(
	select cluster_id, count(*) counter
	from	garland.water_ivr_parcel
	group by cluster_id
)
	order by counter desc
);
*/
--	========================================
