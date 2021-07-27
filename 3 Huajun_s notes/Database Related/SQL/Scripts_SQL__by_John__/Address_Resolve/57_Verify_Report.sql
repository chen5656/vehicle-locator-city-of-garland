	set echo 		off;
	set charwidth	100;
	set serveroutput	on	size 99999;


	@c:\deacutis\scripts\address_resolve\reports\make_report\V14_Partial_Street.sql;

	@c:\deacutis\scripts\address_resolve\reports\make_report\V12_Mixed_Street.sql;

	@c:\deacutis\scripts\address_resolve\reports\make_report\V11_Poor_Street.sql;


	@c:\deacutis\scripts\address_resolve\reports\make_report\V54_Partial_Address.sql;

	@c:\deacutis\scripts\address_resolve\reports\make_report\V53_Wrong_Address.sql;

	@c:\deacutis\scripts\address_resolve\reports\make_report\V52_Mixed_Address.sql;

	@c:\deacutis\scripts\address_resolve\reports\make_report\V51_Poor_Address.sql;


	@c:\deacutis\scripts\address_resolve\reports\make_report\V34_Partial_Block.sql;

	@c:\deacutis\scripts\address_resolve\reports\make_report\V33_Wrong_Block.sql;

	@c:\deacutis\scripts\address_resolve\reports\make_report\V32_Mixed_Block.sql;

	@c:\deacutis\scripts\address_resolve\reports\make_report\V31_Poor_Block.sql;


	@c:\deacutis\scripts\address_resolve\reports\make_report\V24_Partial_Orphan.sql;

	@c:\deacutis\scripts\address_resolve\reports\make_report\V22_Mixed_Orphan.sql;

	@c:\deacutis\scripts\address_resolve\reports\make_report\V21_Poor_Orphan.sql;


	@c:\deacutis\scripts\address_resolve\reports\make_report\V44_Partial_Range.sql;

	@c:\deacutis\scripts\address_resolve\reports\make_report\V43_Wrong_Range.sql;

	@c:\deacutis\scripts\address_resolve\reports\make_report\V42_Mixed_Range.sql;

	@c:\deacutis\scripts\address_resolve\reports\make_report\V41_Poor_Range.sql;


	set echo 		on;