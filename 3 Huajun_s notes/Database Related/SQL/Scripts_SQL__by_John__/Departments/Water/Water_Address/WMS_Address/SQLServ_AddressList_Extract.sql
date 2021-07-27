	set echo 	off;
	set termout	off;
--	=======================================================================================

	spool  c:\deacutis\extract\WMS_Address_ASCII.txt

	select id 		 ||','|| 
		 streetnum   ||','|| streetprefix ||','|| streetname ||','|| streettype ||','|| streetsuffix ||','||
		 streetlabel ||','|| UMS   ||','|| 
			zone   ||','|| meter ||','|| basin ||','|| mappage

	" "
	from	garland.wms_address_view

	order by	streetname, streettype, streetprefix, streetsuffix, streetnum; 

	spool off;

--	=======================================================================================
	set termout	on;
