	set echo	on;
--	=================================================================================================
--	Assign _Num for _ID column in utility table
--	Trigger on any utility table calls this routine to obtain the next _Num value.
--	=================================================================================================

--	Assign _NUM value for Utility water, storm water, & sanitation tables
--	Maintain control record for each Grid & Quad within each utility table
--	Increment the NUM value each time the function is called

--	If invalid call parameters,	then set return _Num =  0
--	If duplicate control records, then set return _Num = -1
--	=================================================================================================

--	issue		Grid  varchar2(3)
--	issue		commit within trigger routine
--	note		translate (ID,'123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ') like 'AA0%A-0%AA'
--			translate (ID,'`~!@#$%^&*()_=+\|[{]};:''",<.>/?')  = ID

--	=================================================================================================

	create or replace function	garland.Assign_Utility_Num  
						(pass_table varchar2, pass_grid number, pass_quad varchar2)
					Return  Number
	as

	this_table			varchar2(20);
	this_grid			number;
	this_quad			varchar2(01);
	this_num			number;

	read_count			number;
	read_num			number;

begin

	this_table		:= pass_table;
	this_grid		:= pass_grid;
	this_quad		:= pass_quad;

	if	this_table > 'A'	
	and	ltrim(this_grid, '0123456789ABCD') is null
	and	this_quad between 'A' and 'D'			then
		null;
	else
		this_num	:= 0;				--  invalid call parameters
		goto	terminate;
	end if;

--	=======================================================================

	Select count(*), 	 max (nvl(Num,0))			--	look for control record
	into	 read_count, read_num 
	from	garland.Utility_Num_Control
	Where	tablename	= this_table
	and	grid		= this_grid
	and	quad		= this_quad;

	if	read_count = 1			then		--	update control record
		this_num  		:= read_num + 01;
		Update garland.Utility_Num_Control
		set	 num   	= this_num
		Where	tablename	= this_table
		and	grid		= this_grid
		and	quad		= this_quad;

	elsif	read_count = 0			then		--	insert control record
		this_num  := 01;
		Insert into	garland.Utility_Num_Control
		Values (this_table, this_grid, this_quad, this_num);

	else
		this_num	:= -1;				--	duplicate control records
		goto	terminate;
	end if;

--	commit;

--	=======================================================================

<<terminate>>
	
	return	this_num;

end;

