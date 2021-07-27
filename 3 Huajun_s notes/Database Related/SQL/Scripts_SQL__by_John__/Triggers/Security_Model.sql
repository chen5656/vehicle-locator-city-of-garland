
	create or replace trigger	garland.adrName_Update

	before	insert or update or delete
	on		garland.adrName
	for		each row

declare

	user_terminal	varchar2(40);
	table_id		varchar2(40)	:= 'ADRNAME';

begin

	select lower(userenv('TERMINAL')) 
	into	 user_terminal 
	from	 dual;
	
	if	user_terminal like '%jdeacuti'
	or	user_terminal like '%enavarro'
	or	user_terminal like '%nstimely'
--	or	user_terminal like '%staplin'
--	or	user_terminal like '%njones'
	or	user_terminal like '%fsouza'
	or	user_terminal like '%wlangley'
	then	
		null;
	else
		raise_application_error (-20101, 'Update not processed on ' || table_id ); 
	end if;

end;
