--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	400;
set pagesize	9999;
--	===============================================================
--	View of Application addess				
--	NEW VERSION

--	Input to \\address_resolve\jobs\002_Load_Table
--	Make clones for different App Sources
--	===============================================================

	create or replace	view	garland.adrResult_Source_
	AS	SELECT	

	null			addr_num,
	null			addr_pfx,
	null			addr_name,
	null			addr_type,
	null			addr_sfx,
	null			addr_code1,
	null			addr_unit1,
	null			addr_code2,
	null			addr_unit2,
	null			verify_code,
	null			do_parse,
	null			do_alias,
	null			do_name,
	null			do_qual,

	0			rec_seq,		
	null			rec_rowid,
				REC_KEY,

	null			parcel_id,
	null			segment_id,
	null			form_pfx,	
	null			form_name,	
	null			form_type,	
	null			form_sfx,
	null			form_code1,
	null			form_unit1,
	null			form_code2,
	null			form_unit2,

				APPL_PFX,
				APPL_NAME,
				APPL_TYPE,
				APPL_SFX,
				APPL_CODE1,
				APPL_UNIT1,
				APPL_CODE2,
				APPL_UNIT2,
				APPL_NUM,

	null			alias_score,
	null			name_score,
	null			qual_score

	from			(app table);

--	===============================================================

	insert --+ append
	into	garland.adrResult_Input
	( rec_key, rec_seq, appl_num, appl_name )
