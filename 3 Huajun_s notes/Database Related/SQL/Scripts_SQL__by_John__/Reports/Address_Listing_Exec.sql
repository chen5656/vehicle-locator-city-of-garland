
	set	termout off;
	spool	c:\deacutis\extract\Address_Listing.txt



	@c:\deacutis\scripts\reports\Address_Listing.sql


	spool off;
	set	termout on;

