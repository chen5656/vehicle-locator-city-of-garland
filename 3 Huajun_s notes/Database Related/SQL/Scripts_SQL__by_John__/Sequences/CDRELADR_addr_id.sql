
--	drop sequence	garland.cdreladr_addr_id;

	create sequence	garland.cdreladr_addr_id

	start with		66480			-- jul 28, 2003

	increment by	001
	minvalue		001
	maxvalue		999999
--	cache	
--	order
	nocycle;

