	set echo	on;
--	========================================================================

	drop package			garland.Find_Address_Region;		

	create or replace package	garland.Find_Address_Region		As

--	========================================================================

	Procedure 	Main 
(
		Address_id		in		number,	
		Region_List	  	in out	Find_Address.Region_Array
);

	end	Find_Address_Region;

--	========================================================================

