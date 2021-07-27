	set echo	off;

	select rpad(notes,10) "NOTES", 
		flag1, name1, 
		flag2, name2, 
		chr(10) " ",	rpad( chr(09),02,chr(09)) " ",
		flag3, name3,	chr(10)

	from adrAlter 

	where upper(name1) like 	'%9%'
	or	upper(name2) like 	'%9%'

	or	upper(name1) like 	'%SWEETLEAL%'
	or	upper(name2) like 	'%SWEETLEAL%'

	;


	set echo	on;

--	desc adrAlter;

