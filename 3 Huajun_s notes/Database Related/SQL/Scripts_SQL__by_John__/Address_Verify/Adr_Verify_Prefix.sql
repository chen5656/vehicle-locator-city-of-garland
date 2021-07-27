
create or replace function	garland.adr_verify_street_prefix (user_prefix  varchar2)		
					return	varchar2

as

	user_pfx		varchar2(20);
	this_pfx		varchar2(20);
	return_pfx		varchar2(20);


cursor  read_adritem			is

	select	/*+ cache */	all *
	from		garland.adrItem
	where		class = 'D'
	and		user_pfx in (possible, name);	

--	===================================================================================================

begin

	user_pfx	:= rtrim(user_prefix);
	this_pfx	:= null;

for	item in read_adrItem				loop

	this_pfx	:= item.standard;

end loop;

	return_pfx	:= this_pfx;

	return	return_pfx;

end;
