	set echo		off;
	set termout 	off;
	set charwidth	300;
--	=============================================================================
--	build ascii file from NSA_CODE_INSPECT & NSA_DCAD_RES for loading into Excel
--	=============================================================================

--	PREPARATION
--		specify nsa_code_inspect_YYYY	 (year)
--		decide whether to include legal descriptions
--	======================================================================

	spool	c:\deacutis\excel\nsa_code_inspect_full.txt;		--  CHANGE
--	spool	c:\deacutis\excel\nsa_code_inspect_part.txt;

--	======================================================================

	select
	'CASE_NUMBER;INSPECTION_DATE;CLOSE_DATE;NUM;PFX;NAME;TYPE;SFX;BLDG;UNIT;ZIP;ISSUE;FOLLOW_UP;ACTION;' ||
	'STATUS;CODE;VIOLATION_ID;VIOLATION;INSPECTOR;INSPECT_AREA;COUNCIL_ID;SUBDIV;PARCEL_ID;MSLINK'
	" "
	from dual
	union all 

	select
	c.CASE_NUMBER                ||';'||
	to_char(c.INSPECTION_DATE,  'mm-dd-yyyy')         ||';'||
	to_char(c.CASE_CLOSED_DATE, 'mm-dd-yyyy')         ||';'||
	c.ADDR_NUM                   ||';'||
	c.ADDR_PFX                   ||';'||
	c.ADDR_NAME                  ||';'||
	c.ADDR_TYPE                  ||';'||
	c.ADDR_SFX                   ||';'||
	c.UNIT_CODE                  ||';'||
	c.UNIT_NUM                   ||';'||
	c.ZIP_CODE                   ||';'||
	to_char(c.ISSUE_DATE,	'mm-dd-yyyy')             ||';'||
	rtrim  (c.FOLLOW_UP_ACTION)  ||';'||
	c.ACTION                     ||';'||
	c.STATUS                     ||';'||
	c.CODE_ID                    ||';'||
	c.VIOLATION_ID               ||';'||
	c.VIOLATION                  ||';'||
	c.INSPECTOR                  ||';'||
	c.INSPECT_AREA               ||';'||
	c.COUNCIL_ID                 ||';'||
	c.SUBDIV_ID                  ||';'||
	c.PARCEL_ID 		     ||';'||	                 
	c.SEGMENT_ID

	" "
	from
(
	select * from garland.NSA_CODE_INSPECT	

	where 	(									--  CHANGE
--	where NOT	(									--  CHANGE
		decode (addr_name, null, ' ', 'addr')	= 'addr'
	and	decode (parcel_id, null, ' ', 'gis ')	= 'gis '
	and	decode (violation, null, ' ', 'viol')	= 'viol'
--	and	decode (issue_date,null, ' ', 'citn')	= 'citn'
			)

	order by case_number
)					C;

--	======================================================================

	spool off;

	set echo		on;
	set termout 	on;
	set charwidth;

--	======================================================================
