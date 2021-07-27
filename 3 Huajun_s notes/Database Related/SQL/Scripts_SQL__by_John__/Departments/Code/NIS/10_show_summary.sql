	set echo	off;
--	===================================================================
--	final summary
--	===================================================================

--	desc nsa_code_inspect

--	===================================================================
--	HOW MANY CODE INSPECTION RECORDS FOR YEAR

	select count(*) "TOTAL CODE"  from nsa_code_inspect;

--	===================================================================
--	HOW MANY RECORDS FOR EACH MONTH

	select to_char(inspection_date,'mm/yyyy') "MONTH", count(*) "     COUNT"
	from	 nsa_code_inspect
	group by to_char(inspection_date,'mm/yyyy');
	
--	===================================================================
--	HOW MANY RECORDS CONTAIN  (1) VERIFIED ADDRESS  (2) ADDRESS  (3) VIOLATION  (4) CITATION

	select addr, gis, viol, citn, count(*) "     COUNT"
	from
(
	select 
		decode (addr_name, null, ' ', 'addr')	addr,
		decode (parcel_id, null, ' ', 'gis ')	gis,
		decode (violation, null, ' ', 'viol')	viol,
		decode (issue_date,null, ' ', 'citn')	citn

	from	garland.nsa_code_inspect
)
	group by addr, gis, viol, citn;


--	===================================================================
--	HOW MANY CITATION  (1) RECORDS  (2) ISSUE DATE   (3)  COMPLY DATE

	select count(*) "CITATIONS", count(citation_issue_date) "ISSUE",  count(citation_comply_date) "COMPLY"
	from nsa_code_citation;

--	===================================================================
	set echo	on;
