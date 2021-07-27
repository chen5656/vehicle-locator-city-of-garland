
--	calculate data usage space in a table	(admin guide p.8-18)


--	======================================================================================================
	set echo	off;
--	======================================================================================================

	truncate table	gis_specs	reuse storage;

	insert into		gis_specs	( spec01, spec02, spec03)
		select	'TABLE DATA', table_name, max (column_id)
		from		dba_tab_columns

		where		table_name in ( 'CDRELADR',	'CDRELADR_COPY',		' ')
		and		owner = 'GARLAND'

		group by	table_name;

--	======================================================================================================

	select	rpad (segment_name, 30)			"TABLE NAME",
			extents					"   EXTENTS",
			to_char (bytes, '999,999,999')	"       BYTES"

	from		dba_segments	sg,
			dba_objects		ob,
			gis_specs		sp

	where		sg.segment_type	= 'TABLE'
	and		sg.owner	 	= 'GARLAND'
	and		sg.owner	 	= ob.owner

	and		spec01 		= 'TABLE DATA'
	and		sg.segment_name 	= sp.spec02
	and		sg.segment_name 	= ob.object_name
	;

--	======================================================================================================

	select tb.table_name		"TABLE NAME",

		to_char (

		(tb.blocks / (tb.blocks + tb.empty_blocks)) * sg.bytes		-- used blocks 

		- ( (57 + 23 + 4 + (2 * tb.num_rows / tb.blocks) ) * tb.blocks)	-- block header 

		- ( tb.avg_space * tb.blocks )						-- block free space 

		- ( spec03 * tb.num_rows )							-- column length indicators

		, '999,999,999')		"  INFO BYTES"

	from		tabs			tb,
			user_segments	sg,
			gis_specs	

	where		spec01 = 'TABLE DATA'
	and		tb.table_name = spec_02
	and		tb.table_name = sg.segment_name

	order by	1;

--	======================================================================================================
	set echo	on;
