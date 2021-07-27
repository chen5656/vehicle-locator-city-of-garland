	set echo off;
--	=========================================================================
--	what are the average number of daily requests for each month
--	=========================================================================

	select 
		rpad(substr(req_date,1,7),8)	"MONTH", 
		count(counter)			"     DAYS",
		sum  (counter)			"    TOTAL", 
		trunc(avg(counter),3)		"  AVERAGE", 
		trunc(min(counter),3)		"   LOWEST", 
		trunc(max(counter),3)		"  HIGHEST"
	from
(	
	select replace(replace(to_char(req_date,'yyyy-mm-dd'),'2098','1998'),'2099','1999')	req_date, 
		 count(*)	counter

	from	(
			select req_date from garland.Pave_Proj_ARCH  
			UNION ALL	
			select req_date from garland.Pave_Proj
		)

	where	 to_char(req_date,'D') between 2 and 6
	group by  replace(replace(to_char(req_date,'yyyy-mm-dd'),'2098','1998'),'2099','1999')
)
	group by rpad(substr(req_date,1,7),8)
	order by rpad(substr(req_date,1,7),8);

--	=========================================================================
	set echo 		on;
