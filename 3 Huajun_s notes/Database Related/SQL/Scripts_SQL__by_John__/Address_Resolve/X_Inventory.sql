
	INVENTORY OF ADDRESS VERIFICATION SCRIPTS


========================
department / engineering
========================

	adr_parse_address			keep
	test_parse_address

	gis_address_scrub			adr_address_resolve
	exec_address_scrub

	tbl_gis_verify_addr		gis_address_scrub output
	gis_stnd_addr_*			gis_stnd_addr_view of app table
	gis_stnd_str_view			street view of gis_stnd_addr_view

	gis_addr_express			rowid table of gis_stnd_str_view (app)
	gis_addr_express			rowid table of gis_verify_addr   (corrections)

	report_verify_results		address scrub reports
	report_verify_errors


	sql_flood_ascii			ascii copy of table
	tbl_flooding			app table
	flooding_extract			from access
	flood_prep				clean up flooding for gis_stnd_addr_view


=====
icads
=====

	cads_adr_scrub			address correction & verification
	01_scrub_addr			drives cads_adr_scrub
	rpt_scrub_results			summary of cads_adr_scrub results
	cads_sample				sample  of cads_adr_scrub results

	cads_change_adr			load gis_change_id table
	01_change_id			drives cads_change_adr

	cads_change_app			replace duplicate address ids in cads/rms application table

	cads_indexes			define indexes for adrstreet & adralias

	cads_queries			query icad tables

	cads_update_rowid			update gis_verify_addr rowid = gis_stnd_addr rowid (app) per addr_id

	tbl_gis_addr_specs		specs  for cads_adr_scrub
	tbl_gis_verify_addr		result table from cads_adr_scrub
	tbl_gis_express_addr		rowid table for gis_verify_addr

	tbl_gis_change_id			table maps duplicate addr id to primary addr id
	tbl_gis_app_audit			audits addr id changes to app table

	gis_stnd_addr_rms			gis_stnd_addr_view	for rms lomain
	gis1_stnd_str_view		gis_stnd_str_view		for primary   street
	gis2_stnd_str_view		gis_stnd_str_view		for secondary street
	gis_verify_addr_view		gis_verify_addr_view	of gis_verify_addr subset

	gis_app_lwmain_view		define gis_app_view	of lwmain matching file key to addr id

	tbl_gis_trim_addr_view		select rtrim address 	of gis_stnd_addr_view
	tbl_adrstreet			create adrstreet & index
	tbl_lomain				create lomain & index	copy leads to train
	ascii_adrstreet			extract adrstreet + trvehrcl for sql*loader

==========
adrresolve
==========

	tbl_adraudit			keep

	adr_compare_*			keep

	adrresolve_*			merge w/ adr_resolve
	test_resolve_address		replace by gis_address_scrub

	tbl_adrresolve_user		adrresolve input
	tbl_adrresolve			adrresolve output

	fix_user_addr			scrub name & quals in adrresolve view
	fix_user_address			ditto for app table syn

	make_alias_name			generate adralias insert template from invalid names
	show_verify				show adrresolve verify ids


========
scrubber
========

	distinct_street			define as view
	format_address			update app table w/ formatted address
	format avenue			format:name=avenue sfx=letter

	discard
		define_table		replaced by ora_create/create_table
		extract_duplex		replaced by gis_address_scrub
		resolve_street		replaced by gis_address_scrub
		resolve_street_run
		record_seq			initialize app table record_id


======
verify
======

	adr_match_alias			adr_alias_match	

	adr_compress			adr_compact_match

	adr_permute_name			adrstreet
	adr_permute_numb			adrstreet
	adr_ending				adrstreet

	adr_verify_prefix
	adr_verify_type
	adr_verify_unit

	discard

		adr_format_*		replaced by gis_address_scrub

		adr_match_length		finds longest matching name prefix
		name_srch_recd		finds length of common name prefix
						replacable by adr_compare_name revector
			
		adr_verify_address package
			adr_verify_street
			adr_scan_near_numb			


==========
sanitation
==========

	address_job_flow			agenda: how to use the following
	address_clean			update: scrub qualifiers in app table & cdreladr
	address_correct			update: scrub app name & quals using adralias & adrstreet
	address_name_num			update: scrub app qualifiers per unique name & number
	addr_verify				update: reset app verify id to zero for invalid addresses	

	discard

		address_compare		replaced by gis_verify_addr reports
		resolve_address		replaced by gis_verify_addr

