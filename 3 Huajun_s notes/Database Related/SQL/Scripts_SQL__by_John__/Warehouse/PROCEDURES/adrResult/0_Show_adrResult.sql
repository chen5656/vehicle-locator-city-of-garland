--	=====================================================================
set echo		on;
set linesize	500;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================

select * from (

select
'APPL:   '|| rpad(appl_num,10)|| rpad(appl_pfx,05)  || rpad(appl_name,20) || rpad(appl_type,05)||rpad(appl_sfx,05)||chr(10)||
'FORM:   '|| rpad(addr_num,10)|| rpad(form_pfx,05)  || rpad(form_name,20) || rpad(form_type,05)||rpad(form_sfx,05)||chr(10)||
'ADDR:   '|| rpad(addr_num,10)|| rpad(addr_pfx,05)  || rpad(addr_name,20) || rpad(addr_type,05)||rpad(addr_sfx,05)||chr(10)||
'KEYS:   '|| rpad(rec_key,15)||'pid='||rpad(parcel_id,16)||'aid='||rpad(segment_id,8)||'seq='||rpad(rec_seq,05)||chr(10)||
'ACTS:   '|| 'vc='||rpad(verify_code,12)||'parse='||rpad(do_parse,26)|| 'alias='||rpad(do_alias,10)|| 
		 'name='||rpad(do_name,05)  ||'qual='||rpad(do_qual,20)  ||
	' ' " "

	from	garland.adrResult
	where rownum < 11

	and	verify_code >= 0
	and	addr_num  between 0	and 999999
	and	addr_name like '%'
	and	do_parse like '%%'
	and	do_alias like '%%'
	and	do_name  like '%%'
	and	do_qual  like '%%'

	order by addr_name, addr_type, addr_pfx, addr_sfx, addr_num
)
	where rownum < 11
;