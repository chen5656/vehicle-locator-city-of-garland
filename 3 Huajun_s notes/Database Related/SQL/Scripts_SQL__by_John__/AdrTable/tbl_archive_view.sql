
--	template for archive view table
--	template for creation of archive table from adrdebug



	Create table	archive_xxxx_views
	(
		View_name         varchar2(25),
		Line_seq          varchar2(03),
		View_text         varchar2(80)	
	);



	Insert into		archive_xxxx_views
	(
	Select	distinct
		Rpad(item01, 25)		"view_name", 
		Lpad(item02, 03)		"line_seq",
		Rpad(item03, 80) 		"view_text"
	From	gis_objects
	);



	Select * from archive_xxxx_views;


