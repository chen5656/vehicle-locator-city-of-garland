
create or replace function	garland.adr_verify_unit_code (user_unit_code  varchar2)		
					return	varchar2

as

	user_code		varchar2(20);
	this_code		varchar2(20);
	return_code		varchar2(20);


cursor  read_adritem			is

	select	/*+ cache */	all *
	from		garland.adrItem
	where		class = 'U'
	and		user_code in (possible, name);	

--	==========================================================================================

begin

	user_code	:= rtrim(user_unit_code);
	this_code	:= null;

for	item in read_adrItem				loop

	this_code	:= item.standard;

end loop;

	return_code	:= this_code;

	return	return_code;

end;
