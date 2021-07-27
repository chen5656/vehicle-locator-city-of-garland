	set echo	off;


--	===========================================================================

--	how many of each intersection type was generated

	select	substr(intersect_id, 01,02)	"id",
			count(*)				"    total"
	from		intersection
	group by	substr(intersect_id, 01,02);

--	===========================================================================

	set echo	on;
