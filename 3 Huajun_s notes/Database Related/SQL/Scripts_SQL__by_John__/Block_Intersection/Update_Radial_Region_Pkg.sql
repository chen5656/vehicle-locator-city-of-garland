	set echo	off;
--	====================================================

--	drop			package	Update_Radial_Region;

	create or replace	package	Update_Radial_Region	as
--	====================================================

	do_input		number	:= 099999;	--	total records to be processed

	do_update		number	:= 00;
	do_print		number	:= 001;	--	01 = filled;  02 = filled & vacant
	do_test		number	:= 00;	--	start test at this record sequence

	min_differ		number	:= 100;	--	min coordinate differ in order to choose quadrant

--	====================================================

	procedure	Update_Driver 
	( 	
		job_update		binary_integer, 	
		job_print		binary_integer, 	
		job_test		binary_integer
	);


	procedure	Linear_Update;

--	procedure	Corner_Update;

end;


