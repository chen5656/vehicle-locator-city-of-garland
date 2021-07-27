	set echo off;
--	==============================================================

	select null,

		decode(col, 01,   chr(10), ' ')	" ",
		rpad(rec,   04)	rec,			
		rpad(col,   04)	col,			
		rpad(title, 20)	title,	
		rpad(info,  30)	info

	from	garland.Temp_View1
	where	rec <=20
	order by	rec, col;
		
--	==============================================================
/*
	select * from temp_view1  
	where rec 	in
(
	select rec 
--	,count(*)  counter
	from temp_view1
	group by rec
	having count(*) > 7
);

*/	
--	==============================================================
	set echo on;
