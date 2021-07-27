
--	define Oracle Sequence


	create sequence	TMP_WORK_SEQ

	start with		00000001
	increment by	01
	minvalue		00000001
	nomaxvalue
	nocycle
	cache			02
	order
	;