
	select rtrim(text, ' ' || chr(10) || chr(13) ) 
	from user_source
	where	name = 'FIND_ADDRESS'
	and	type = 'PACKAGE BODY';