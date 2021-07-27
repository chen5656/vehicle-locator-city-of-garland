	set echo	on;
--	========================================================================

	drop package			garland.Find_Block_Region;	

	create or replace package	garland.Find_Block_Region		As

--	========================================================================

	Procedure 	Main 
(
		Block_ID		in		number,	
		Block_Parity	in		number,	
		Region_List	  	in out	Find_Address.Region_Array
);

	end	Find_Block_Region;

--	========================================================================

