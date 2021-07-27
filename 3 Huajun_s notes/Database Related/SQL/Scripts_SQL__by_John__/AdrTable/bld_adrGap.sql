--	========================================================================
--	refresh adrgap

--	look for gaps in cdreladr addresses
--	the standard difference for even or odd addresses is 04
--	a gap is any 2 addresses in which the addr_num difference = 08
--	========================================================================

	truncate table		adrgap	reuse storage;

	set serveroutput		on;

--	======================================================

declare

	job_parity			number := 0;

	job_total			number := 0;

	non_std_total		number := 0;

	num_gap			number := 0;
	max_gap			number := 20;

--	======================================================

	prev_addr_name		varchar2(20);
	prev_addr_type		varchar2(04);
	prev_addr_pfx		varchar2(02);
	prev_addr_sfx		varchar2(02);
	prev_addr_num		number;

	do_compile_only		number		:= 0;

cursor read_address		is

	select	distinct
			addr_name,
			addr_type,
			addr_pfx,
			addr_sfx,
			addr_num
	from		cdreladr

	where		mod (addr_num, 02) = job_parity
	order by	1,2,3,4,5;


begin

	if	do_compile_only > 0		then
		return;
	end if;


--	dbms_transaction.use_rollback_segment ('RB1');

<<search_for_gaps>>

for look in	read_address		loop

	if	look.addr_name	= prev_addr_name
	and	look.addr_type	= prev_addr_type
	and	look.addr_pfx	= prev_addr_pfx
	and	look.addr_sfx	= prev_addr_sfx			then

		num_gap :=  look.addr_num - prev_addr_num;

		if	num_gap = 08					then	

			job_total	:= job_total + 01;

			insert into	adrgap	
			values (
				prev_addr_num + 04,
				prev_addr_pfx, 			
				prev_addr_name, 			
				prev_addr_type, 			
				prev_addr_sfx 	
				);

		end if;


		if	num_gap < max_gap
		and	num_gap not in ( 02, 04, 08 )		
		and	round (look.addr_num, -2) = round (prev_addr_num , -2)	then

			non_std_total	:= non_std_total + 01;
		
			if	job_total < 0				then
				dbms_output.put_line ( 
					'address number gap   '		||  
					lpad (prev_addr_num, 4) 	||' '||
					lpad (look.addr_num, 4) 	||' '||
					prev_addr_pfx 			||' '||
					prev_addr_name 			||' '||
					prev_addr_type 			||' '||
					prev_addr_sfx 	
				);
			end if;
		
		end if;	

	end if;

	prev_addr_name	:= look.addr_name;
	prev_addr_type	:= look.addr_type;
	prev_addr_pfx	:= look.addr_pfx;
	prev_addr_sfx	:= look.addr_sfx;
	prev_addr_num	:= look.addr_num;


end loop;

	if	job_parity  = 0		then
		job_parity := 1;
		goto	search_for_gaps;
	end if;


	dbms_output.put_line ( 'total address gaps = 	  ' || job_total);
	dbms_output.put_line ( 'total non-standard gaps = ' || non_std_total ||'  under ' || max_gap );

	dbms_transaction.commit;
	
end;

