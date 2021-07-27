	set echo	off;
	set timing	off;

	select count(*)		 	  "parcel"	from cdrelpar;
	select count(subdiv_id)	 	  "subdiv"	from cdrelpar;
	select count(council_id )	  "coun"	from cdrelpar;
	select count(police_beat)	  "beat"	from cdrelpar;
	select count(zip_code)		  "zip"	from cdrelpar;
	select count(code_inspect_area) "code"	from cdrelpar;
	select count(fire_district)	  "fire"	from cdrelpar;
	
	desc cdrelpar;

	set echo	on;