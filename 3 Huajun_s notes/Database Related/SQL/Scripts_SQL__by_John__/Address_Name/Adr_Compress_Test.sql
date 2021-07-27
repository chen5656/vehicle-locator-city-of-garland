	set echo	on;
--	=====================================================================================================
--	Test Name Compression
--	=====================================================================================================

	drop synonym	test_syn;

	create synonym	test_syn		for ADR_compress_name;
--	create synonym	test_syn		for TST_compress_name;

--	=====================================================================================================

	select test_syn ('a aseed2ggf fs', '2')		" " from dual;
	select test_syn ('a aseed2ggf fs', '4')		" " from dual;
	select test_syn ('a aseed2ggf fs', '6')		" " from dual;

--	=====================================================================================================

	select test_syn ('r rseed2ggs fs', '2')		" " from dual;
	select test_syn ('r rseed2ggs fs', '4')		" " from dual;
	select test_syn ('r rseed2ggs fs', '6')		" " from dual;

--	=====================================================================================================

	select test_syn ('a aseed,2ggf-fs', '0')		" " from dual;

	select test_syn ('a aseed2ggf fs', '4I')		" " from dual;

	select test_syn ('a aseed2ggf fs', '6S')		" " from dual;
	select test_syn ('r rseed2ggs fs', '6S')		" " from dual;

--	=====================================================================================================

