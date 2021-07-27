	set echo off;
--	=========================================================================================
--	Recombine separated street name in adrResult.form_ 
--	Final street name correction is done by \\Jobs\030_Run_Name.sql

--	Example:	name = BOIS			unit1 = D'ARC
--	becomes	name = BOIS D'ARC		unit1 = null
--	=========================================================================================

	drop synonym	garland.temp_syn;
--	create synonym	garland.temp_syn		for garland.adrResult_Input;
	create synonym	garland.temp_syn		for garland.adrResult_Output;		--	NORMALLY USED

--	=========================================================================================

--	reformat form_name & form_unit1

	update	garland.temp_syn		-- adrResult

	set		form_name	= ltrim(form_name ||' '|| form_unit1),
			form_unit1	= null,
			addr_name	= null,
			addr_unit1	= null,
			do_parse	= do_parse || ' m+u'
	where		rec_seq	in 
(
	select 	r.rec_seq
	from		garland.adrStreets	s,
			garland.temp_syn		r			-- adrResult

	where		form_unit1 		 > 'A'
	and		length(form_unit1) >  1
	and		s.addr_reduced = 
			garland.adr_compress_name (form_name ||' '|| form_unit1, 01)
);

	commit;

--	=========================================================================================


