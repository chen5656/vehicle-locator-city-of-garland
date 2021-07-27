	set echo	off;
--	========================================================================

	drop package			garland.Find_Regions;

	create or replace package	garland.Find_Regions		As

--	========================================================================

	Type Region_Array  is table of   varchar2(20)
		index by binary_integer;

--	========================================================================

	Procedure 	Main 
(
		Address_id		in		number,	
		Region_List	  	in out	Region_Array
);

	end	Find_Regions;

--	========================================================================


