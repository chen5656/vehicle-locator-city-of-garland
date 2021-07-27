	set echo	off;
	set timing	on;

--	analyze table	garland.gis_verify_addr		compute statistics;

--	truncate table	plan_table;
--	explain plan	set statement_id = 'a'		for
--	=======================================================

	truncate table 	garland.gis_objects	reuse storage;

	insert into garland.gis_objects (item01, item02, item03)

	select	distinct
			l.location_no,
			p.person_lnm,
			p.person_fnm

/*
	select 	count(*)

	select	distinct
			rpad(p.person_lnm, 20)  " ", 
			rpad(p.person_fnm, 10)  " ", 

			lpad(p.person_no,  06)	" ",	
			lpad(a.account_no, 06)	" ",
			lpad(l.location_no,05)	" ",
			chr(10),

			rpad(r.addr_num,  05) " ", 
			rpad(r.form_pfx,  02) " ", 
			rpad(r.form_name, 20) " ", 
			rpad(r.form_type, 04) " ", 
			rpad(r.form_sfx,  02) " ", 
			chr(10),

--			rpad(r.addr_num,  05) " ", 
--			rpad(r.addr_pfx,  02) " ", 
--			rpad(r.addr_name, 20) " ", 
--			rpad(r.addr_type, 04) " ", 
--			rpad(r.addr_sfx,  02) " ", 
--			chr(10)

*/

	from		sfg.sg00100m@umsrep.world		p,
			sfg.um00200m@umsrep.world		a,
			sfg.um00250t@umsrep.world		l
			,garland.adrResult		r

	where		a.person_no		= p.person_no
	and		a.account_no	= l.account_no

	and		r.rec_key		= l.location_no
	and		r.verify_code	= 53

--	and		rownum < 11
--	order by	rpad(r.addr_name,20), rpad(r.addr_type,04), rpad(r.addr_pfx,02), rpad(r.addr_num,05)
	;	


	commit;
			
--	=======================================================
--	select * from explain_plan;

--	select * from explain_indexed;
--	select * from explain_constraint;
--	select * from explain_table;
--	select * from explain_index;
--	select * from explain_analyze;
--	select * from explain_cost;

--	=======================================================
	set echo	on;
	set timing	off;
