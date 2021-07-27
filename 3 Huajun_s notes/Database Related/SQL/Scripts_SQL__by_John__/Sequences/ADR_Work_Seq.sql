
--	define sequence object for result_table


	drop	sequence		garland.Adr_Work_Seq;

	create sequence		garland.Adr_Work_Seq

	start with		200000

	increment by	001
	minvalue		001
	maxvalue		999999

	nocache				-- buffer size
--	cache			01		-- buffer size

	nocycle				-- not wrap from max to min
	order					-- 1st come 1st serve
	;

commit;





