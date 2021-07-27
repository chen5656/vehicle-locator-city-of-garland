	set echo	on;
--	========================================================================
--	Obtain requested geographic regions for Hundred Block
--	Region_List input  = sequences associated w/ geographic types
--	Region_List output = geographic regions 
--	========================================================================

	drop package body				garland.Find_Block_Region;

	create or replace package body	garland.Find_Block_Region	As

--	========================================================================
--	========================================================================

	do_trace			binary_integer	:= 01;

	Region_Entry		Find_Address.Region_Array;

	this_region_id		Find_Address.Region_ID%type;
	this_region_type		binary_integer;

	this_block_id		binary_integer;
	this_block_parity		binary_integer;

--	========================================================================

Cursor	Read_Block_Side		is

		select s.*

		from	 garland.Block_Side	s,
			 garland.Block		b			--  T E M P O R A R Y

		where	 b.block_id		= this_block_id
		and	 s.addr_parity	= this_block_parity

		and	 s.addr_pfx		= b.addr_pfx		--  T E M P O R A R Y
		and	 s.addr_name	= b.addr_name
		and	 s.addr_type	= b.addr_type
		and	 s.addr_sfx		= b.addr_sfx
		and	 s.addr_block	= b.addr_block
		;

		BLOCK		Read_Block_Side%rowtype;

--	========================================================================
--	========================================================================

Procedure	Get_Zip_Code	is

begin
	this_region_id	:= block.zip_code;

end ;

--	========================================================================

Procedure	Get_Council		is

begin
	this_region_id	:= block.Council_ID;
end ;

--	========================================================================

Procedure	Get_Code_Inspect		is

begin
	this_region_id	:= block.Code_Inspect_Area;
end ;

--	========================================================================

Procedure	Get_Police_Beat		is

begin
	this_region_id	:= block.Police_Beat;
end ;

--	========================================================================

Procedure	Get_Police_District	is

begin
	this_region_id	:= block.Police_District;
end ;

--	========================================================================

Procedure	Get_Fire_District		is

begin
	this_region_id	:= block.Fire_District;
end ;

--	========================================================================

Procedure	Get_Animal_Control		is

begin
	this_region_id	:= null;
--	this_region_id	:= block.Animal_Control;
end ;

--	========================================================================

Procedure	Get_Landuse		is

begin
	this_region_id	:= null;
--	this_region_id	:= block.Landuse;
end ;

--	========================================================================

Procedure	Get_Zoning		is

begin
	this_region_id	:= null;
--	this_region_id	:= block.Zoning;
end ;

--	========================================================================

Procedure	Get_Zoning_Sup	is

begin
	this_region_id	:= null;
--	this_region_id	:= block.Zoning_Sup;
end ;

--	========================================================================

Procedure	Get_Subdivision		is

begin

	this_region_id	:= null;

--		select subdiv_name
--		into	 this_region_id
--		from	 garland.Tax_Subdiv_ID
--		where	 subdiv_id = block.subdiv_id;

end ;

--	========================================================================
--	========================================================================

Procedure 	MAIN
	(
		Block_ID		in		number,	
		Block_Parity	in		number,	-- actual parity or streeet number			

		Region_List	  	in out	Find_Address.Region_Array
	)	
IS

	seq		binary_integer;

--	========================================================================

begin

	this_block_id	:= Block_ID;
	this_block_parity	:= Block_Parity;
	Region_Entry	:= Region_List;

	this_block_parity	:= mod(this_block_parity, 02);


	open	Read_Block_Side;
	fetch	Read_Block_Side		into Block;
	if	read_block_side%notfound
	or	read_block_side%notfound	is null		then
		region_list (1) := Find_Address.end_of_list;
		close	Read_Block_Side;
		return;
	end if;
	close	Read_Block_Side;

	seq	:= 0;

loop
	seq			:= seq + 01;

	this_region_id	:= region_entry (seq);

	exit when	this_region_id = Find_Address.end_of_list;

	this_region_type	:= this_region_id;
	this_region_id	:= null;

--	--------------------------------------------------------------------------

	if	this_region_type = '1'		then
		GET_ZIP_CODE;

	elsif	this_region_type = '2'		then
		GET_COUNCIL;

	elsif	this_region_type = '3'		then
		GET_CODE_INSPECT;

	elsif	this_region_type = '4'		then
		GET_POLICE_BEAT;

	elsif	this_region_type = '5'		then
		GET_POLICE_DISTRICT;

	elsif	this_region_type = '6'		then
		GET_FIRE_DISTRICT;

	elsif	this_region_type = '7'		then
		GET_ANIMAL_CONTROL;

	elsif	this_region_type = '8'		then
		GET_SUBDIVISION;

	elsif	this_region_type = '10'		then
		GET_LANDUSE;

	elsif	this_region_type = '11'		then
		GET_ZONING;

	elsif	this_region_type = '12'		then
		GET_ZONING_SUP;

	end if;

--	--------------------------------------------------------------------------

	region_entry (seq) := this_region_id;

<<end_loop>>
	null;
end loop;

	Region_List	:= Region_Entry;
	return;	

end;

--	========================================================================

end	Find_Block_Region;

--	========================================================================

