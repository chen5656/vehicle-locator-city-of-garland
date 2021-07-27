	set serveroutput on	size 99999;
--	===============================================================================
--	display "mixed street" choices
--	===============================================================================

		drop synonym	temp_syn;
		create synonym	temp_syn		for garland.adrResult;
--		create synonym	temp_syn		for garland.adrResult_Tax_Account;

declare

		do_compile		number		:= 0;

		spec_seq		number		:= 01;		-- show rec_seq (0,1)
		spec_key		number		:= 0;			-- show rec_key (0,1)

		spec_verify		number		:= 12;
		spec_label1		char(16)	:= 'mixed   street';
		spec_label2		char(16)	:= 'valid   street';

		count_errors	number		:= 0;

		find_name		varchar2(20);
		find_type		varchar2(20);
		find_pfx		varchar2(20);
		find_sfx		varchar2(20);
		find_num		number;

		show_seq		varchar2(10);
		show_key		varchar2(20);

cursor	read_adrResult		is

		select distinct addr_name, addr_type, addr_pfx, addr_sfx, addr_num, rec_seq, rec_key

--		from	garland.adrResult
		from	garland.temp_syn

		where	mod(verify_code, 10) = 02;
--		where	verify_code = spec_verify;


cursor	read_address		is

		select distinct addr_name, addr_type, addr_pfx, addr_sfx
		from	garland.adrStreets
		where	addr_name	= find_name;

--	===============================================================================

begin

	if	do_compile > 0		then
		return;	
	end if;


for 	look in read_adrResult				loop

	if	look.addr_name	= find_name
	and	look.addr_type	= find_type
	and	look.addr_pfx	= find_pfx
	and	look.addr_sfx	= find_sfx	
	and	spec_seq + spec_key = 0			then
		goto	end_look;
	else
		find_name		:= look.addr_name;	
		find_type		:= look.addr_type;	
		find_pfx		:= look.addr_pfx;	
		find_sfx		:= look.addr_sfx;	
	end if;

	if	spec_seq > 0	then
		show_seq		:= lpad (look.rec_seq, 06);
	else
		show_seq		:= null;
	end if;

	if	spec_key > 0	then
		show_key		:= rpad (look.rec_key, 20);
	else
		show_key		:= null;
	end if;

	count_errors	:= count_errors + 01;

	dbms_output.put_line (  ' ' );
	dbms_output.put_line (  spec_label1 || 		--	  lpad(look.addr_num, 06) ||' '|| 
					rpad(look.addr_pfx, 02) ||' '|| rpad(look.addr_name,20) ||' '|| 
					rpad(look.addr_type,04) ||' '|| rpad(look.addr_sfx, 02) ||' '|| 
					show_seq ||' '|| show_key);	

	
for	scan in read_address		loop

	dbms_output.put_line (  spec_label2 || 		--	  lpad(scan.addr_num, 06) ||' '|| 
					rpad(scan.addr_pfx, 02) ||' '|| rpad(scan.addr_name,20) ||' '|| 
					rpad(scan.addr_type,04) ||' '|| rpad(scan.addr_sfx, 02) );	
end loop;


<<end_look>>
	null;
end loop;


	dbms_output.put_line ('');
	dbms_output.put_line ('Total Errors ' || count_errors);

end;
