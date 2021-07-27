
--	DEFINE SEQUENCE OBJECT FOR RESULT_TABLE


drop sequence		garland.trvehrcl_segment_seq;

create sequence		garland.trvehrcl_segment_seq
	start with		001
	increment by	001
	minvalue		001
	maxvalue		999999
	cache			010
	order
	nocycle;

