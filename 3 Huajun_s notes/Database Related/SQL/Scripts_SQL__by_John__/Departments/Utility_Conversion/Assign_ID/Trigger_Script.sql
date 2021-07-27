	set echo off;
--	=========================================================================
--	Utility trigger script template for cloning
--	Clone cases must be in utility Name specs (temporary table)
--	=========================================================================

--	issue		this_grid	varchar2(03)
--	=========================================================================

	create or replace trigger	garland.===AAA===_EDIT		-- insert & update
	before	insert  
	or		update
	on  		garland.===AAA===
	for each row

declare

	id_prefix		varchar2(5)	:= '===DDD===';
	id_suffix		varchar2(5)	:= '===EEE===';

	this_id		varchar2(20);
	this_grid		number;
	this_quad		char;
	this_num		number;

begin

	if	inserting
		this_id	:= upper(nvl(:new.===CCC===,	:old.===CCC===));
		this_quad	:= upper(nvl(:new.map_quad,	:old.map_quad));
		this_grid	:= upper(nvl(:new.map_grid,	:old.map_grid));
	end if;

	if	inserting
	and	this_id is null
	and	this_grid between  1  and 88					--	FORMAT ?
	and	this_quad between 'A' and 'D'		then

		this_num := garland.Assign_Utility_Num ( '===AAA===', this_grid, this_quad );

		:new.===CCC=== := id_prefix || this_grid || this_quad || '-' || this_num || id_suffix;
	end if;

<<eoj>>
	null;

end;

--	=========================================================================
