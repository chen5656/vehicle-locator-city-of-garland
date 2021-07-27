	set echo		off;
	set timing		on;
	set serveroutput	on	size 99999;
--	============================================================================================
--	rebuild entire intersection table
--	============================================================================================

--	choose which types of intersection should be produced
--	0 = no	1 = yes	2 = 1 + removed suffix

--	============================================================================================
--	1 = yes
--	Partial Street excludes prefix
--	Full Street    includes prefix
--	Full Block	   includes prefix & includes hundred block
--	Part Block	   excludes prefix & includes hundred block

--	2 = 1 & removed suffix
--	Removed Suffix excludes suffix

--	Partial options 5 - 12 are produced only at N-S and E-W street boundaries
--	Removed suffixes are produced when suffixes exist & job spec = 2
--	No duplicate intersections of any type are produced
--	============================================================================================

--	truncate table	gis_objects	reuse storage;

--	============================================================================================

	select 'Build Intersection' " ", to_char(sysdate, 'Mon dd,yyyy  hh24:mi') " " from dual;

begin

	build_intersection.build_intersection_table
(

	02,	--	    S First  St /     E Main       		(1)	Full Street	   / Full Street		=A
	02,	--	100 S First  St / 100 E Main       		(2)	Full Block	   / Full Block		=B

	02,	--	100 S First  St /     W Main       		(3)	Full Block	   / Full Street		=C
	02,	--	    S First  St / 100 W Main       		(4)	Full Street	   / Full Block		=D

	02,	--	100 S First  St / 100	Main       		(5)	Full Block	   / Part Block		=E
	02,	--	100	Main      / 100 S First  St		(6)	Part Block	   / Full Block		=F

	02,	--	100 S First  St /	      Main       		(7)	Full Block	   / Partial Street	=G
	02,	--	      Main      / 100 S First  St		(8)	Partial Street / Full Block		=H

	02,	--	    S First  St / 100	Main       		(9)	Full Street	   / Part Block		=I
	02,	--	100	Main      /     S First  St		(10)	Part Block	   / Full Street		=J

	02,	--	    S First  St /       Main       		(11)	Full Street	   / Partial Street	=K
	02,	--	      Main      /     S	First  St		(12)	Partial Street / Full Street		=L

	02,	--	  	First  St /	     	Main    		(13)	Partial Street / Partial Street	=M
	02	--	100	First  St /	100  	Main    		(14)	Part Block	   / Part Block		=N					=L


	,-200			--	report size		if negative, 	then trace is included
--	,999			--	report size		if magnitude=999, then do insert
				--	report size		if absent,		then zero is default

	,-290			--	max insert		if negative, 	then specifies test node id
				--	max insert		if absent,	 	then max value is default

);

end;


/*
--	====================================================================================================
	node		intersection						distinct prefix-suffix 

	2768		SYLVAN / NASH							--	0/0 
	1735		FIFTH  / AUSTIN							--	1/0
	2811		FIFTH  / WALNUT							--	1/1
	2799		FIRST  / WALNUT							--	2/1	
	2116		COUNTRY CLUB S / ' ', 'E', 'W'				--
	3648		N GEO BUSH SERV W   / N SHILOH E				--	
	3634		GEORGE BUSH SERVICE / SHILOH, TELECOM			--	1/1/0
	 290		SATURN / W CENTERVILLE / LBJ CENTERVILLE ON,OFF N

--	============================================================================================
*/
