	set echo	on;
--	========================================================================
--	Obtain requested geographic regions for Address
--	Region_List input  = sequences associated w/ geographic types
--	Region_List output = geographic regions 
--	========================================================================

	drop package body				garland.Find_Address_Region;

	create or replace package body	garland.Find_Address_Region		As

--	========================================================================

	do_trace			binary_integer	:= 0;

	Region_Entry		Find_Address.Region_Array;

	this_region_id		Find_Address.Region_ID%type;
	this_region_type		binary_integer;

	this_address_id		binary_integer;

--	========================================================================

Cursor	Read_Parcel		is

		select p.*
		from	 cdrelPAR		p,
			 cdrelADR		a

		where	 a.mslink 		= this_address_id
		and	 a.parcel_id	= p.parcel_id;

		PARCEL	Read_Parcel%rowtype;

--	========================================================================
--	========================================================================

Procedure	Get_Zip_Code	is

begin
	this_region_id	:= parcel.zip_code;
end ;

--	========================================================================

Procedure	Get_Council		is

begin
	this_region_id	:= parcel.Council_ID;
end ;

--	========================================================================

Procedure	Get_Code_Inspect		is

begin
	this_region_id	:= parcel.Code_Inspect_Area;
end ;

--	========================================================================

Procedure	Get_Police_Beat		is

begin
	this_region_id	:= parcel.Police_Beat;
end ;

--	========================================================================

Procedure	Get_Police_District	is

begin
	this_region_id	:= parcel.Police_District;
end ;

--	========================================================================

Procedure	Get_Fire_District		is

begin
	this_region_id	:= parcel.Fire_District;
end ;

--	========================================================================

Procedure	Get_Animal_Control		is

begin
	this_region_id	:= parcel.Animal_Control;
end ;

--	========================================================================

Procedure	Get_Landuse		is

begin
	this_region_id	:= parcel.Landuse;
end ;

--	========================================================================

Procedure	Get_Zoning		is

begin
	this_region_id	:= parcel.Zoning;
end ;

--	========================================================================

Procedure	Get_Zoning_Sup	is

begin
	this_region_id	:= parcel.Zoning_Sup;
end ;

--	========================================================================

Procedure	Get_Subdivision		is

begin
		select subdiv_name
		into	 this_region_id
		from	 garland.Tax_Subdiv_ID
		where	 subdiv_id = parcel.subdiv_id;
end ;

--	========================================================================
--	========================================================================

Procedure 	MAIN
	(
		Address_id		in		number,	
		Region_List	  	in out	Find_Address.Region_Array
	)	
IS

	seq		binary_integer;

--	========================================================================

begin

	this_address_id	:= Address_ID;
	Region_Entry	:= Region_List;

	open	Read_Parcel;
	fetch	Read_Parcel		into Parcel;
	if	read_parcel%notfound
	or	read_parcel%notfound	is null		then
		region_entry (1)	:= Find_Address.end_of_list;
		close	Read_Parcel;
		return;
	end if;
	close	Read_Parcel;


	if	do_trace > 0	then
	null;
	dbms_output.put_line ('Address Region/' );
--	dbms_output.put_line ('             /' || '' ||'/'|| '' ||'/'|| '' ||'/'|| '' ||'/'|| '' );
	dbms_output.put_line (' ');
	end if;



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

end loop;

	Region_List	:= Region_Entry;
	return;	

end;

--	========================================================================

end	Find_Address_Region;

--	========================================================================
