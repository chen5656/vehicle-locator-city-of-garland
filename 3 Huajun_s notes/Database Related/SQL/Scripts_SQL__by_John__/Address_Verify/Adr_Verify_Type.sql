

create or replace function	garland.adr_verify_street_type	( user_street_type  varchar2)
					return	varchar2


as

	user_type		varchar2(20);
	this_type		varchar2(20);
	return_type		varchar2(20);

cursor  read_adritem			is

	select	/*+ cache */	all *
	from		garland.adrItem
	where		class = 'T'
	and		user_type in (possible, name);	

--	======================================================================================================

begin

	user_type	:= rtrim(user_street_type);
	this_type	:= null;

for	item in read_adritem			loop

	this_type := item.standard;

end loop;

	return_type	:= this_type;

	return	return_type;

end;
