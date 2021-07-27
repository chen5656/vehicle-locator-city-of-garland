	set echo off;
--	====================================================================================     
--	Find invalid grid/quad/num
--	Find invalid id
--	====================================================================================     

--	SPECIFY:	TABLE NAME,  ID,  NUM

--	====================================================================================     

	create or replace view	temp_view (rec_id, rec_num, map_grid, map_quad)

	as	select PIPE_ID, PIPE_NUM,		--  CHANGE
			 map_grid, map_quad  

		from	 garland.UTWATPIPE;		--  CHANGE

--	====================================================================================     

--	select count(*)
	select  REC_ID, map_grid, map_quad, REC_NUM

	from	TEMP_VIEW

	where not	(
		REC_NUM	>   0
	and	map_grid	>  '0'
	and	ltrim(map_grid,'0123456789ABCD') is null
	and	map_quad	between 'A' and 'D'
			);

--	============================================================

--	select count(*)
	select  REC_ID, map_grid, map_quad, REC_NUM

	from	TEMP_VIEW
	where REC_ID > '0'
	and not	(

		translate (REC_ID,'123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ','000000000AAAAAAAAAAAAAAAAAAAAAAAAAA') 
		like 'AA0%A%-0%AA'

	and	translate (REC_ID,'A`~!@#$%^&*()_=+\|[{]};:",<.>/?''', 'A')  = REC_ID
			);

--	============================================================
