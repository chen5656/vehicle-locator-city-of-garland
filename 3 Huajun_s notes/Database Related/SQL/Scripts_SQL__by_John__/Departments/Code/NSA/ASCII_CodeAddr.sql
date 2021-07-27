
	set echo		off;
	set charwidth	240;

	spool c:\deacutis\extract\codeaddr.txt;

	select

	'"'||	ADDR_NUM			||'";'||
	'"'||	ADDR_PFX			||'";'||
	'"'||	ADDR_NAME			||'";'||		
	'"'||	ADDR_TYPE			||'";'||		
	'"'||	ADDR_SFX			||'";'||		

	'"'||	ADDR_CODE			||'";'||		
	'"'||	ADDR_UNIT			||'";'||		
	
	'"'||	COUNCIL_DISTRICT		||'";'||
	'"'||	ADDR_ID			||'";'||
	' '	" "

	from	nsa_codeaddr

	where	nvl (verify_code, 0) >= 0

	and	rownum < 11
	;



	set charwidth;
	spool	off;