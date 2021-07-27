	set echo		off;
    set linesize	2000;
	set serveroutput	on	size 99999;
--	=====================================================================
--	Remove duplicate TAX with same Address and Owner
--	=====================================================================

	alter session	set nls_date_format = 'yyyy-mm-dd';

--	=====================================================================

declare

	compile_only	integer := 0;
	do_print		integer := 01111;
	do_delete		integer := 0;

	delete_count	integer := 0;

	adr_num		number;
	adr_name		varchar2(20);
	adr_type		varchar2(20);
	adr_pfx		varchar2(20);
	adr_sfx		varchar2(20);

	owner_name		varchar2(80);

cursor	Read_Common_TAX	is
	
	select   tax_addr_name, tax_addr_num, tax_addr_type, tax_addr_pfx, tax_addr_sfx, tax_owner, 
			rowid row_id
	from	 garland.COMMON_TAX

	where (  tax_addr_name, tax_addr_num, tax_addr_type, tax_addr_pfx, tax_addr_sfx, tax_owner) IN
(
(
	select   tax_addr_name, tax_addr_num, tax_addr_type, tax_addr_pfx, tax_addr_sfx, tax_owner
	from	garland.COMMON_TAX
	group by tax_addr_name, tax_addr_num, tax_addr_type, tax_addr_pfx, tax_addr_sfx, tax_owner
	having count(*) > 1
)
)
	order by 1,2,3,4,5,6;

begin

	if	compile_only > 0	then
		return;
	end if;

for	read in Read_Common_TAX		loop

	if	read.tax_addr_name	= adr_name
	and	read.tax_addr_num		= adr_num
	and	read.tax_addr_type	= adr_type
	and	read.tax_addr_pfx		= adr_pfx
	and	read.tax_addr_sfx		= adr_sfx
	and	rtrim(read.tax_owner)	= rtrim(owner_name)	then

		delete_count := delete_count + 01;

		if	do_print > 0					then
			dbms_output.put_line (
				lpad(adr_num,5) ||' ' || adr_pfx ||' '|| rpad(adr_name,15) ||' '|| rpad(adr_type,4) ||' '||
				rpad(adr_sfx,2) ||'     //  '|| owner_name );
			do_print := do_print - 01;
		end if;

		if	do_delete > 0					then
			delete from garland.COMMON_TAX
			where	rowid = read.row_id;
		end if;
	end if;

	adr_name		:= read.tax_addr_name;
	adr_num		:= read.tax_addr_num;
	adr_type		:= read.tax_addr_type;
	adr_pfx		:= read.tax_addr_pfx;
	adr_sfx		:= read.tax_addr_sfx;
	owner_name		:= read.tax_owner;

end loop;

	Commit;

	dbms_output.put_line ( 'Total Deleted: ' || delete_count);

end;
