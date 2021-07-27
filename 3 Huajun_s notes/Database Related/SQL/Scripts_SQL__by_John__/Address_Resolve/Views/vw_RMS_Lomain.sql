--	=========================================================
--	gis_app_addr view of gis_objects for police rms
--	=========================================================
--	CAUTION:  verify ROWNUM  constraint
--	CAUTION:  verify ADDUSER constraint
--	CAUTION:  verify ADDTIME constraint
--	CAUTION:  verify SPACES  constraint
--	=========================================================

	create or replace	view	garland.gis_app_addr		
	(
		addr_num,
		addr_pfx,
		addr_name,
		addr_type,
		addr_sfx,
		addr_code,
		addr_unit,

--		parcel_id,
--		segment_id,
--		verify_code,

		rec_key,
		row_id
		,app_id
	)
	as

	select
			s1number,
			s1dir,
			s1name,
			s1type,
			s1quad,
			'',
			apt,

			lomainid,
			rowid
			,'***  ***'

	from		rms_lomain
--	from		leads.lomain

	where		loctype = 0

	and		instr (rtrim(s1name), ' ', 1, 2 ) > 0
	and		s1number > ' '

	and		adduser	<> 'CONV'
--	and		addtime	> to_date ('jan 01, 2001', 'mon dd, yyyy')

	and		rownum 	< 1111	 	

	and		instr (s1name, 'BLOCK')		+
			instr (s1name, 'BLK')		+
			instr (s1name, '&')		+
			instr (s1name, '@')		+
			instr (s1name, '/')		+
			instr (s1name, ' NEAR ')	+
			instr (s1name, ' AT ')		+
			instr (s1name, ' OF ')		+
			instr (s1name, ' AND ')		+
			instr (s1name, ' IN ')		+
			instr (s1name, ' ON ')		+
			instr (s1name, ' OFF ')		+
			instr (s1name, ' BOX ')		+
--			instr (s1name, '')		+
--			instr (s1name, '')		+
--			instr (s1name, '')		+
--			instr (s1name, '')		+
--			instr (s1name, '')		+
--			instr (s1name, '')		+
--			instr (s1name, '')		+
			0 = 0

	and	(
		nvl (length (translate (rtrim(city), '/GARLAND', '/')), 0) 
	+	nvl (length (translate ('GARLAND', '/' || rtrim(city) , '/')), 0) 	<=  2 
	
--	or	city = ' '	
		)

	and	city not in ( 	'CRANDALL','DARLING',  'DURANGO', 'GARDEN',    'GARDNER', 'GLENDORA',
				  	'HARLAND', 'LAGRANGE', 'RANDALL', 'RIDGELAND', 'SUGARLAND',
					'CRANDAL', 'DRANGO',   'LA GRANDE'	
				)


;
--	=====================================================================================================

