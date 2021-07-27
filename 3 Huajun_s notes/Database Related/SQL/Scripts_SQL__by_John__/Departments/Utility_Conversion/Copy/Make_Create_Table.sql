	set echo		off;
	set charwidth	200;


	select '	drop table GARLAND.'	|| new_table	|| ';'	||chr(10)||

		'	create table GARLAND.'	|| new_table			||chr(10)||

--		 	'_BKUP' 								||chr(10)|| 

		 '	tablespace  gis_data ' 						||chr(10)||
		 '	nologging'		 						||chr(10)||
		 '	storage (initial 50k  next 50k  pctincrease 0)'		||chr(10)||
		 '	as select * from JDEACUTIS.' || new_table  || ';'	||chr(10)



	" "
	from	temp_view
	;


	set charwidth;
	set echo		on;


