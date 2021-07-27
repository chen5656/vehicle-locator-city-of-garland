--	==============================================================
--	build ascii file from NSA_CODE_INSPECT
--	==============================================================

	set charwidth	200;
	set termout 	off;

	spool	c:\deacutis\loader\nsa_code_insp.dat;
--	==============================================================

select

c.CASE_NUMBER                	||';'||
to_char(c.INSPECTION_DATE,  'mm-dd-yyyy')         ||';'||
to_char(c.CASE_CLOSED_DATE, 'mm-dd-yyyy')         ||';'||
c.ADDR_NUM                   	||';'||
c.ADDR_PFX                   	||';'||
c.ADDR_NAME                  	||';'||
c.ADDR_TYPE                  	||';'||
c.ADDR_SFX                   	||';'||
c.UNIT_CODE                  	||';'||
c.UNIT_NUM                   	||';'||
c.ZIP_CODE                   	||';'||
to_char (c.ISSUE_DATE,	'mm-dd-yyyy')             ||';'||
to_char (c.COMPLY_DATE,	'mm-dd-yyyy')             ||';'||
rtrim (c.ACTION)             	||';'||
rtrim (c.FOLLOW_UP_ACTION)  	||';'||
c.STATUS                     	||';'||
c.CODE_ID                    	||';'||
c.VIOLATION_ID               	||';'||
c.VIOLATION                  	||';'||
c.INSPECTOR				||';'||
c.INSPECT_AREA			||';'||
c.COUNCIL_ID			||';'||
c.LEGAL1			     	||';'||
c.LEGAL2			     	||';'||
c.SUBDIV_ID                  	||';'||
c.PARCEL_ID 		     	||';'||	                 
c.SEGMENT_ID

from	nsa_code_inspect		c
order by case_number
;

--	==============================================================

	spool	off;

	set termout on;

--	==============================================================
