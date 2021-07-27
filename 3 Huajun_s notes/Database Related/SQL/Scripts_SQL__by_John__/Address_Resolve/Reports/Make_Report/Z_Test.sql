	set echo off;
	set charwidth	90;

--	display partial address choices


	select	c1					|| 
			rpad(c2||label, 16)		||

			c2					||
			lpad(addr_num,  05)		||' '|| 
			rpad(addr_pfx,  02) 		||' '||	
			rpad(addr_name, 20)		||' '|| 
			rpad(addr_type, 04)		||' '|| 
			rpad(addr_sfx,  02)		||'	'
			|| lpad(rec_id, 06)		||' '
			|| rpad(rec_key,20)
			" "
	from
(
	select	
			r.rec_seq, 
			r.addr_name, r.addr_type, r.addr_pfx, r.addr_sfx, to_number(r.addr_num) addr_num, 
			r.addr_name a, r.addr_type b, r.addr_pfx c, r.addr_sfx d, r.addr_num e, 
			'partial address'		label,
			rtrim(r.rec_seq)		rec_id,
			r.rec_key,
			chr(10)			c1,
			' '				c2
	from		adrResult		r
	where		verify_code	= 54

	union

	select
			r.rec_seq, 
			a.addr_name, a.addr_type, a.addr_pfx, a.addr_sfx, a.addr_num, 
			r.addr_name a, r.addr_type b, r.addr_pfx c, r.addr_sfx d, r.addr_num e, 
			'valid   address'		label,
			' '				rec_key,
			' '				rec_id,
			' '				c1,
			''				c2
	from		adrResult		r,
			cdreladr		a
	where		r.addr_name	= a.addr_name
	and		r.addr_num	= a.addr_num
	and		verify_code = 54
)

	order by	a,b,c,d,e, rec_seq;


	select rpad(' ',70) " " from dual;
	set echo on;
