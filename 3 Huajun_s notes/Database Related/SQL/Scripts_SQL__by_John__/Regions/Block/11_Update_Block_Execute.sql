	set echo		off;
	set serveroutput	on		size 999999;
--	=================================================================	

declare

		job_update		number	:= 0;
		job_print		number	:= 0;
		job_dangle		number	:= 0;
		job_test		number	:= 0;
		job_input		number	:= 0;

		job_empty		varchar2(4)	:= '0';

begin

	select empty	into job_empty 
	from  block_region_view	
	where rownum < 2;

--	-------------------------------------------------------------------------------------------

--	Update_Block_Region.Update_Driver ( job_update, job_print, job_dangle, 
--							job_empty,  job_test,  job_input	);

--	-------------------------------------------------------------------------------------------

	Update_Block_Region.Linear_Update;
--	Update_Block_Region.Corner_Update;

--	-------------------------------------------------------------------------------------------

end;

