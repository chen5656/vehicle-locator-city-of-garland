--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================

--	drop sequence	Garland.CCS_IDENTIFIER_Seq;

	create sequence	Garland.CCS_IDENTIFIER_Seq
	start with		01
	increment by	01
	minvalue		01
	maxvalue		999999999
	nocache		-- buffer size
	nocycle		-- not wrap from max to min
	noorder		-- not 1st come 1st serve
	;

--	=====================================================================
