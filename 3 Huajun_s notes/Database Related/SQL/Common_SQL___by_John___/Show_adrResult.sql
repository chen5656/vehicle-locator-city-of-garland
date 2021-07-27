--	=====================================================================
	select * from viewer.me;
	BEGIN  TEST TEST TEST TEST TEST  TEST TEST TEST TEST TEST  TEST TEST TEST TEST TEST  END;
set	TIMING		OFF;
set	sqlblanklines	on;
set	serveroutput	on	size 99999;
set	linesize		1000;
set	pagesize		0000;
--	execute jdeacutis.show_table_column	('', '', '');
--	execute jdeacutis.show_source		('test_proc', 'jdeacutis', '');
--	execute jdeacutis.show_error		('test_proc', 'jdeacutis', '');
--	execute jdeacutis.show_view		('', '', '');
--	execute jdeacutis.show_index_column	('', '', '');
--	SELECT  to_char(sysdate,'Mon dd,yyyy hh24:mi')||'  ***  ' " "  from dual;
--	EXECUTE jdeacutis.TEST_PROC;
--	CREATE or replace procedure jdeacutis.TEST_PROC  as
--	DECLARE
--	=====================================================================	

select * from (

select
'APPL:   '|| rpad(appl_num,10)|| rpad(appl_pfx,05)  || rpad(appl_name,20) || rpad(appl_type,05)||rpad(appl_sfx,05)||chr(10)||
'FORM:   '|| rpad(addr_num,10)|| rpad(form_pfx,05)  || rpad(form_name,20) || rpad(form_type,05)||rpad(form_sfx,05)||chr(10)||
'ADDR:   '|| rpad(addr_num,10)|| rpad(addr_pfx,05)  || rpad(addr_name,20) || rpad(addr_type,05)||rpad(addr_sfx,05)||chr(10)||
'KEYS:   '|| rpad(rec_key, 40)||'pid='||rpad(parcel_id,16)||'aid='||rpad(segment_id,8)||'seq='||rpad(rec_seq,05)||chr(10)||
'ACTS:   '|| 'vc='||rpad(verify_code,12)||'parse='||rpad(do_parse,26)|| 'alias='||rpad(do_alias,10)|| 
		 'name='||rpad(do_name,05)  ||'qual='||rpad(do_qual,20)||
	' ' " "
	from	garland.adrResult
	where rownum < 11

--	where	addr_name like '%'
--	and	addr_num	between 0	and 999999
--	and	verify_code > 0
--	and	do_parse > '0'
--	and	do_alias > '0'
--	and	do_name  > '0'
--	and	do_qual  > '0'
	order by addr_name, addr_num
)
	where rownum < 11
;
