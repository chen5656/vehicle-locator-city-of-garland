
--	DEFINE SEQUENCE OBJECT FOR RESULT_TABLE



DROP	SEQUENCE		garland.ADR_WORK_SEQ;

CREATE SEQUENCE		garland.ADR_WORK_SEQ
	START WITH		001
	INCREMENT BY	001
	MINVALUE		001
	MAXVALUE		999999
	CACHE			002		-- buffer size
	CYCLE					-- wrap from max to min
	NOORDER				-- not 1st come 1st serve
	;


/*

DROP	SEQUENCE		garland.TMP_TEST_SEQ;

CREATE SEQUENCE		garland.TMP_TEST_SEQ
	START WITH		001
	INCREMENT BY	001
	MINVALUE		001
	MAXVALUE		1000
	CACHE			002		-- buffer size
	CYCLE					-- wrap from max to min
	NOORDER				-- not 1st come 1st serve
	;

COMMIT;

*/