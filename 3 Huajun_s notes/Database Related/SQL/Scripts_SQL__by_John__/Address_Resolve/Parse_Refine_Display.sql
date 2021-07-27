	set echo off;
--	=========================================================================================
--	Recombine separated street name in adrResult.form_ 
--	Final street name correction is done by \\Jobs\030_Run_Name.sql

--	Example:	name = BOIS			unit1 = D'ARC
--	becomes	name = BOIS D'ARC		unit1 = null
--	=========================================================================================

	drop synonym	garland.temp_syn;
--	create synonym	garland.temp_syn		for garland.adrResult_Input;
	create synonym	garland.temp_syn		for garland.adrResult_Output;	

--	=========================================================================================
--	display proposed changes

	select 	rpad(r.appl_name, 30)					"appl name",
			rpad(r.form_name, 30)					"form name",
			rpad(r.form_unit1,10)					"form unit1", 
			lpad(r.addr_num,  06)					"number",
			rpad(ltrim(form_name ||' '|| form_unit1), 25)	"reform name",
			rpad(r.form_unit2,10)					"form unit2" 
	from		garland.adrStreets		s,
			garland.temp_syn		r
	where		form_unit1 		 > 'A'
	and		length(form_unit1) >  1
	and		s.addr_reduced = 
			garland.adr_compress_name (form_name ||' '|| form_unit1, 01);

--	=========================================================================================

