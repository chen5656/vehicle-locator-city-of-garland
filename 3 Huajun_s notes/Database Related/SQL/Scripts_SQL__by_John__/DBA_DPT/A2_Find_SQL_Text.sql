	set echo 	off;;
--	==============================================================================================
--	look for sql text having specific words
--	place the results into cursor filter in Show_SQLText.sql 
--	==============================================================================================

	select	distinct
			'	''' || t.address || ',' || t.hash_value || ''''
			" "
	from		v$sqltext		t

--	---------------------------------------------------------------------------------------------
	where	upper(t.sql_text)	like	'%TRVEHRCL%'	
--	---------------------------------------------------------------------------------------------
	;

	set echo	on;