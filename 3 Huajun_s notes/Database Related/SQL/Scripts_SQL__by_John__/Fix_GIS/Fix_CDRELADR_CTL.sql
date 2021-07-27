	load

--	insert
--	append
	replace

	into table		GIS_OBJECTS

	fields terminated by 	","
--	fields terminated by 	whitespace

	optionally enclosed by 	'"'
	trailing nullcols
(
	 item01			--	mslink
	,item02			--	parcel id

	,item03			--	addr num
	,item04			--	addr pfx
	,item05			-- 	addr name
	,item06			--	addr type
	,item07			--	addr sfx


	,item08			--	x coord
	,item09			--	y coord

	,item10			--	parcel id	replacement

--	=============================================================================
