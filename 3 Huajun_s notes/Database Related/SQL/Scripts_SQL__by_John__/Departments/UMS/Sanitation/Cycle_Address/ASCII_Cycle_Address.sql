	set echo 		off;
	set termout		off;
	set fetchrows;
--	=======================================================
--	list addresses for each UMS cycle code
--	=======================================================

	spool c:\deacutis\extract\sani_location_cycle.txt;

--	analyze table	garland.adrResult_UMS_Location		compute statistics;
--	insert into plan_table (object_name, object_owner) values (upper( ' ' ),	'GARLAND');

--	truncate table	plan_table;
--	explain plan	set statement_id = 'a'		for

	select	'zip,number,prefix,street name,type,suffix,cycle'  " " from dual;

	select
			p.zip_code		||','||
			a.addr_num		||','||
			a.addr_pfx		||','||
			rtrim(a.addr_name)||','||
			a.addr_type		||','||
			a.addr_sfx		||','||
			rtrim(o.item02)	||' '||	--	cycle code
			' '			" "

	from		garland.gis_objects			o,
			garland.adrResult_UMS_Location	a,
			garland.nsa_dcad_res			t,
			garland.cdrelpar				p

	where		a.parcel_id		= t.parcel_id		--	(residential)
	and		a.parcel_id		= p.parcel_id (+)		--	(zip code)

	and		o.item01		= a.rec_key			--	location_no

	and	(	o.item02	between '05' and '08'		--	cycle code
	or		o.item02	= '14'	)

	order by	zip_code, addr_name, addr_type, addr_pfx, addr_sfx, addr_num, item02;

--	======================================================================
--	select * from explain_plan;
--	select * from explain_analyze;
--	select * from explain_indexed;
--	select * from explain_constraint;
--	select * from explain_table;
--	select * from explain_index;
--	select * from explain_cost;
--	======================================================================

	spool off;

	set echo 		on;
	set termout		on;
	set fetchrows;
