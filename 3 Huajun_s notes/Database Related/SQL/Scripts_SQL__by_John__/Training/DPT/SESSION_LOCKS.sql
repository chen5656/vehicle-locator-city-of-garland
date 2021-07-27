
--	DISPLAY LOCKED OBJECTS IN SESSIONS

	SELECT
		LO.SESSION_ID,
		LO.OS_USER_NAME,
		RPAD (OB.OBJECT_NAME, 30)		"OBJECT",
		RPAD (LK.TYPE, 04)			"LOCK",

		DECODE (	LK.LMODE,
				0,	'NONE',
				1,	'NULL',
				2,	'SS',
				3,	'SX',
				4,	'SHARE',
				5,	'SSX',
				6,	'X',
					'?'	)		"LMODE",
	
		DECODE (	LK.REQUEST,
				0,	'NONE',
				1,	'NULL',
				2,	'SS',
				3,	'SX',
				4,	'SHARE',
				5,	'SSX',
				6,	'X',
					'?'	)		"RMODE"

	FROM		V$LOCKED_OBJECT		LO,
			V$LOCK			LK,
			USER_OBJECTS		OB

	WHERE		LO.SESSION_ID	= LK.SID
	AND		LO.OBJECT_ID 	= OB.OBJECT_ID

	ORDER BY	1, 2;

			