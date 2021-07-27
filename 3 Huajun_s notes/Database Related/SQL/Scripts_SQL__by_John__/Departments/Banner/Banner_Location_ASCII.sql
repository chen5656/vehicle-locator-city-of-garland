	set echo	off;
	set termout	off;
--	=======================================================================
--	UBCCUST = OCCUPANT INFO
--	UCRACCT = linkage

--	select * from ucbcust@bprd.world where rownum < 11;
--	should access banprd.world
--	=======================================================================
	spool	c:\deacutis\extract\banner_location.txt

	select 'premisenum,streetnum,streetprefix,streetname,streetype,streetsuffix,unittype,unitnum'  " "
	from dual
	UNION ALL
(
	select 
		premise_num			||','||
		streetnum			||','||
		streetprefix		||','||
		streetname			||','||
		streettype			||','||
		streetsuffix		||','||
		unit_type			||','||
		unit_num			
		" "
	from
(
	select 
		translate(ucbprem_code,'/ ','/')		premise_num,	
		rtrim(ucbprem_street_number)			streetnum,		
		rtrim(ucbprem_pdir_code_pre)			streetprefix,	
		rtrim(ucbprem_street_name)			streetname,		
		rtrim(ucbprem_ssfx_code)			streettype,		
		rtrim(ucbprem_pdir_code_post)			streetsuffix,	
		rtrim(ucbprem_utyp_code)			unit_type,		
		rtrim(ucbprem_unit)				unit_num		
	from  ucbprem@bprd.world 
	where	translate(ucbprem_code, '/ 1234567890','/') is null
	and	ucbprem_street_number is not null
	order by streetname, streettype, streetprefix, streetsuffix, streetnum
));

--	=======================================================================
	spool off;
	set termout	on;
