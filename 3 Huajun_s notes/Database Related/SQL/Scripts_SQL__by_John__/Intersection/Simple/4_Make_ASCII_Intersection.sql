--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	2000;
set pagesize	9999;
-- set pagesize	74;
-- set pagesize	57;
-- alter session set nls_date_format = 'yyyymmdd hh24:mi:ss';  
--	=======================================================
--	Make ASCII file of Intersections
--	=======================================================

	spool	c:\deacutis\extract\WATER_INTERSECTIONS.TXT

--	desc temp_view4;

--	=======================================================

	select 
--		strblok1			||','||

		strpre1			||','||
		strname1			||','||
		strtype1			||','||
		strsuf1			||','||

--		strblok2			||','||

		strpre1			||','||
		strname2			||','||
		strtype2			||','||
		strsuf1			||','||

		rownum			--  Intersection ID
	
	" "
	from	
(
	select *
	from	garland.temp_view4
	where	intersect_type = 'SS'
	order by 1,2,3,4,6,7,8,9
)
;

--	=======================================================

	spool off;

--	=======================================================
