	set echo		off;
	set serveroutput	on;
--	=====================================================================
--	Remove duplicate UMS with same Address and Person
--	=====================================================================

	alter session set nls_date_format = 'yyyy-mm-dd'

declare

	compile_only	integer := 0;
	do_print		integer := 01;
	do_delete		integer := 0;

	delete_count	integer := 0;

	adr_name		varchar2(20);
	adr_num		number;
	adr_type		varchar2(20);
	adr_pfx		varchar2(20);
	effective		varchar2(20);
	last_name		varchar2(80);

cursor	Read_Basic_UMS	is
	
	select addr_name, addr_num, addr_type, addr_pfx, effective_date, last_name, rowid row_id
	from	 garland.Basic_UMS
	where (addr_name, addr_num, addr_type, addr_pfx, effective_date, last_name) in
(
	select addr_name, addr_num, addr_type, addr_pfx, effective_date, last_name
	from	garland.Basic_UMS
	group by addr_name, addr_num, addr_type, addr_pfx, effective_date, last_name
	having count(*) > 1
)
	order by 1,2,3,4,5,6;

begin

	if	compile_only > 0	then
		return;
	end if;

for	read in Read_Basic_UMS		loop

	if	read.addr_name		= adr_name
	and	read.addr_num		= adr_num
	and	read.addr_type		= adr_type
	and	read.addr_pfx		= adr_pfx
	and	read.effective_date	= effective
	and	read.last_name		= last_name		then
		delete_count := delete_count + 01;

		if	do_print > 0				then
			dbms_output.put_line (lpad(adr_num,5) ||' ' || adr_pfx ||' '|| rpad(adr_name,15) ||' '|| adr_type 
				||'     //  '|| effective ||'  '|| last_name );
		end if;

		if	do_delete > 0				then
			delete from garland.Basic_UMS
			where	rowid = read.row_id;
		end if;
	end if;

	adr_name		:= read.addr_name;
	adr_num		:= read.addr_num;
	adr_type		:= read.addr_type;
	adr_pfx		:= read.addr_pfx;
	effective		:= read.effective_date;
	last_name		:= read.last_name;

end loop;

	Commit;

	dbms_output.put_line ( 'Total Deleted: ' || delete_count);

end;
