	set echo off;
--	=========================================================================
--	what are the average number of daily requests for each month
--	=========================================================================

	select 
		to_char(req_date,'yyyy-mm')	"MONTH", 
		count(counter)			"     DAYS",
		sum  (counter)			"    TOTAL", 
		trunc(avg(counter),3)		"  AVERAGE", 
		trunc(min(counter),3)		"   LOWEST", 
		trunc(max(counter),3)		"  HIGHEST"
	from
(	
	select req_date, count(*) counter

	from	 garland.Pave_Proj_ARCH
--	from	 garland.Pave_Proj

	where	 to_char(req_date,'D') between 2 and 6
	group by req_date
)
	group by to_char(req_date, 'yyyy-mm')
	order by to_char(req_date, 'yyyy-mm');

--	=========================================================================
	set echo 		on;
