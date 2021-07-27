--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================
--	Remove duplicate UMS with same Address and Person
--	=====================================================================

--	execute	garland.CCS_UMS_Remove_Dupe;

	create or replace procedure garland.CCS_UMS_Remove_Dupe		as

--	DECLARE

--	=====================================================================

	compile_only	integer := 0;
	do_delete		integer := 01;
	do_print		integer := 0;

	delete_count	integer := 0;

	total_processed	integer := 0;
	title			varchar2(100);
	heading		varchar2(100);
	script		varchar2(2000);

	adr_num		number;
	adr_name		varchar2(20);
	adr_type		varchar2(20);
	adr_pfx		varchar2(20);
	adr_sfx		varchar2(20);

	effective		date;
	last_name		varchar2(80);

cursor	Read_Basic_UMS	is
	
	select   addr_name, addr_num, addr_type, addr_pfx, addr_sfx, effective_date, last_name, rowid row_id
	from	 garland.Basic_UMS
	where (  addr_name, addr_num, addr_type, addr_pfx, addr_sfx, effective_date, last_name) IN
(
	select   addr_name, addr_num, addr_type, addr_pfx, addr_sfx, effective_date, last_name
	from	garland.Basic_UMS
	group by addr_name, addr_num, addr_type, addr_pfx, addr_sfx, effective_date, last_name
	having count(*) > 1
)
	order by 1,2,3,4,5,6;

begin

	if	compile_only > 0	then
		return;
	end if;

	title := 'REMOVE UMS DUPES  ';	dbms_output.put_line(title);

for	read in Read_Basic_UMS		loop

	if	read.addr_name		= adr_name
	and	read.addr_num		= adr_num
	and	read.addr_type		= adr_type
	and	read.addr_pfx		= adr_pfx
	and	read.addr_sfx		= adr_sfx
	and	read.effective_date	= effective
	and	read.last_name		= last_name		then
		delete_count := delete_count + 01;

		if	do_delete > 0				then
			delete from garland.Basic_UMS
			where	rowid = read.row_id;
		end if;


		if	do_print > 0				then
			dbms_output.put_line (
				lpad(adr_num,5) ||' ' || adr_pfx ||' '|| rpad(adr_name,15) ||' '|| rpad(adr_type,4) ||' '||
				rpad(adr_sfx,2) ||'     //  '|| effective ||'  '|| last_name );
		end if;

	end if;

	adr_name		:= read.addr_name;
	adr_num		:= read.addr_num;
	adr_type		:= read.addr_type;
	adr_pfx		:= read.addr_pfx;
	adr_sfx		:= read.addr_sfx;
	effective		:= read.effective_date;
	last_name		:= read.last_name;

end loop;

	COMMIT;

	dbms_output.put_line ( 'Total Deleted: ' || delete_count);

end;
