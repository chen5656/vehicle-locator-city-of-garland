
	drop sequence	garland.Common_Address_Refs_seq;

	create sequence	garland.Common_Address_Refs_seq

	start with		1000000		

	increment by	001
	minvalue		001
	maxvalue		9999999999
--	cache	
--	order
	nocycle;


