	set echo		off;
	set serveroutput	on		size 99999;
--	==============================================================
--	replace wrong street on adrResult with unique valid street 

--	optional:	include listing of selected adrResult rec_key's 
--			from \\Alterations\00_Make\\Make_Wrong_Street.sql
--			in cursor Read_adrResult
--	==============================================================

--	VERIFY CURSOR QUERY (source table & columns)

--	==============================================================


declare

	do_compile		number		:= 0;
	do_update		number		:= 001;	--	update address
	do_commit		number		:= 00;	--	update address			-- jan 2004
	do_audit		number		:= 00;	--	update verify_code & do_qual

--	do_print		number		:= 00;	--	do not print
--	do_print		number		:= 01;	--	print before & after address
	do_print		number		:= 02;	--	print before & after & block options

	per_block		number		:= 01;
	per_lowest		number		:= 01;
	per_highest		number		:= 01;

	tolerance		number		:= 00;	--	max gap between addr_num and lowest addr_num
									--	for which street correction is permitted
	choose_code		char			:= 'A';	--	address
	choose_verify	number		:= 53;	--	wrong address 

--	==============================================================

	append_type		char(04)		:= choose_code || 'at ';
	remove_type		char(04)		:= choose_code || 'rt ';
	change_type		char(04)		:= choose_code || 'ct ';
	append_pfx		char(04)		:= choose_code || 'ap ';
	remove_pfx		char(04)		:= choose_code || 'rp ';
	change_pfx		char(04)		:= choose_code || 'cp ';
	append_sfx		char(04)		:= choose_code || 'as ';
	remove_sfx		char(04)		:= choose_code || 'rs ';
	change_sfx		char(04)		:= choose_code || 'cs ';

	total_input		number		:= 0;
	total_update	number		:= 0;
	total_full		number		:= 0;
	total_partial	number		:= 0;

	this_name		varchar2(20)	:= ' ';
	this_type		varchar2(04);
	this_pfx		varchar2(02);
	this_sfx		varchar2(02);
	this_qual		varchar2(40);
	this_key		varchar2(40);
	this_seq		number;
	this_num		number;
	this_block		number;
	this_verify		number;
	this_lowest		number;
	this_highest	number;
	this_rowid		rowid;

	good_type		varchar2(04);
	good_pfx		varchar2(02);
	good_sfx		varchar2(02);
	good_qual		varchar2(40);
	good_verify		varchar2(02);
	good_parcel		varchar2(11);

	prev_name		varchar2(20);
	prev_block		number;

	read_type		varchar2(04);
	read_pfx		varchar2(02);
	read_sfx		varchar2(02);
	read_parcel		varchar2(11);

	fetch_count		number;
	street_count	number;
	block_count		number;
	accept_count	number;
	reject_count	number;
	count_type		number;
	count_pfx		number;
	count_sfx		number;

	permit_update	char(3);

--	================================================================================

cursor	read_adrResult	is

		select	distinct

				addr_name, addr_num, addr_type, addr_pfx, addr_sfx 		--	CHANGE

--				form_name addr_name, addr_num, form_type addr_type, 
--				form_pfx  addr_pfx,  form_sfx  addr_sfx

				,ltrim(do_qual) ,verify_code 
				,rec_key, rec_seq ,rowid

		from		garland.adrResult								--	CHANGE
--		from		garland.adrResult_Extract

		where		mod(verify_code,10) = 3				-- jan 2004

--	--------------------------------------------------------------------------------------
/*
		and	(	do_qual like '%Ac%'		
		or		do_qual like '%Bc%'
		or		do_qual like '%Rc%'	)
*/
--	--------------------------------------------------------------------------------------
/*
	and		rec_key in 
(

)

*/
--	--------------------------------------------------------------------------------------

		order by	addr_name, addr_type, addr_pfx, addr_sfx, addr_num;

cursor	read_address	is

		select	addr_pfx, addr_type, addr_sfx, parcel_id
		from		garland.cdreladr
		where		addr_name	= this_name
		and		addr_num	= this_num;


cursor	read_segment	is

		select	addr_pfx, addr_type, addr_sfx, rtrim(mslink) parcel_id
		from		garland.trvehrcl
		where		addr_name	= this_name
		and		this_num	between addr_lo and addr_hi;

cursor	read_block	is

		select	addr_pfx, addr_type, addr_sfx, null
		from		garland.adrBlock
		where		addr_name	= this_name
		and		addr_block	= this_block;

cursor	read_block_range	is

		select addr_name, addr_type, addr_pfx, addr_sfx, 
			 min(addr_block)	min_block, 
			 max(addr_block)	max_block 
		from	 garland.adrBlock  
		where	(addr_name, addr_type, addr_pfx, addr_sfx)	in 
		(
			select addr_name, addr_type, addr_pfx, addr_sfx
			from	 garland.adrBlock
			where  addr_name  = this_name  
			and	 addr_block = this_block 
		)
		group by addr_name, addr_type, addr_pfx, addr_sfx;

--	================================================================================

begin

	if	do_compile > 0	then
		return;
	end if;

	dbms_output.put_line ( ' ' );
	dbms_output.put_line (	'tolerance ' || tolerance );
	dbms_output.put_line (	'per block=' || per_block  || 
					'   per lowest=' || per_lowest || '   per highest=' || per_highest);

	open	read_adrResult;

loop

	prev_name  := this_name;
	prev_block := this_block;

	fetch	read_adrResult	into	 this_name, this_num,    this_type, this_pfx, this_sfx 
						,this_qual ,this_verify 
						,this_key  ,this_seq  	,this_rowid			--	optional
						;
	exit when	read_adrResult%notfound
		or	read_adrResult%notfound is null;

	total_input := total_input + 01;

	fetch_count	:= 0;
	street_count:= 0;
	count_type	:= 0;
	count_pfx	:= 0;
	count_sfx	:= 0;
	good_type	:= null;
	good_pfx	:= null;
	good_sfx	:= null;

	this_block	:= trunc (this_num, -2);

	if	choose_verify = '53'		then
		open	read_address;
	elsif	choose_verify = '43'		then
		open	read_segment;
	elsif	choose_verify = '33'		then
		open	read_block;
	end if;

--	================================================================

	select count(*)
	into	 block_count
	from	 garland.adrBlock
	where	 addr_name	= this_name
	and	 addr_block = this_block;

	select count(*)
	into	 accept_count
	from	 garland.adrBlock
	where	 addr_name	= this_name
	and	 addr_block = this_block
	and	 addr_type	= this_type;

	select count(*)
	into	 reject_count
	from	 garland.adrBlock
	where	 addr_name	= this_name
	and	 addr_block = this_block
	and	 addr_type	<> this_type
	and	 addr_pfx	<> this_pfx;

--	================================================================

begin		
	select nvl (trunc (min (addr_num), -2), 99999),
		 nvl (trunc (max (addr_num), -2), 99999)
	into	this_lowest,
		this_highest
	from	garland.cdreladr
	where	addr_name = this_name
--	and	addr_type = this_type
--	and	addr_pfx  = this_pfx
--	and	addr_sfx  = this_sfx
	group by addr_name;

exception
	when others	then	this_lowest := 99999;
end;

--	================================================================

	this_lowest := nvl(this_lowest,0);

	if	do_print > 0			then
		dbms_output.put_line ( ' ' );
	end if;

	if	do_print > 0			then
		dbms_output.put_line (	lpad(this_num, 5) ||' '|| 
						rpad(this_pfx, 2) ||' '|| rpad(this_name,20) ||' '|| 
						rpad(this_type,4) ||' '|| rpad(this_sfx,2)	);
	end if;

loop

	if	choose_verify = '53'		then
		fetch	read_address		into	read_pfx, read_type, read_sfx, read_parcel;
		exit when	read_address%notfound
			or	read_address%notfound is null;
	elsif	choose_verify = '43'		then
		fetch	read_segment		into	read_pfx, read_type, read_sfx, read_parcel;
		exit when	read_segment%notfound
			or	read_segment%notfound is null;
	elsif	choose_verify = '33'		then
		fetch	read_block			into	read_pfx, read_type, read_sfx, read_parcel;
		exit when	read_block%notfound
			or	read_block%notfound is null;
	end if;

	fetch_count	:= fetch_count + 01;

	if	good_type is null
	or	good_type <> read_type		then
		count_type	:= count_type + 01;
	end if;

	if	good_pfx is null
	or	good_pfx <> read_pfx		then
		count_pfx	:= count_pfx + 01;
	end if;

	if	good_sfx is null
	or	good_sfx <> read_sfx		then
		count_sfx	:= count_sfx + 01;
	end if;

	if	read_type	= good_type
	and	read_pfx	= good_pfx
	and	read_sfx	= good_sfx		then
		null;
	else
		street_count:= street_count + 01;
		good_type	:= read_type;
		good_pfx	:= read_pfx;
		good_sfx	:= read_sfx;
		good_parcel := read_parcel;
	end if;

end loop;

	if	choose_verify = '53'		then
		close	read_address;
	elsif	choose_verify = '43'		then
		close	read_segment;
	elsif	choose_verify = '33'		then
		close	read_block;
	end if;

	if	fetch_count = 1			
	or	count_type * count_pfx * count_sfx = 1		then
		good_verify	:= rpad(choose_verify,1) || '5';		--	full street
		total_full	:= total_full + 01;

	elsif	fetch_count  > 1		
	and	street_count = 1						then
		good_verify	:= rpad(choose_verify,1) || '4';		--	partial street
		total_partial:= total_partial + 01;

	else
		dbms_output.put_line (	lpad(this_verify,5)||'    '|| rpad(this_qual,20) ||' '|| 
						this_seq ||' '|| this_key );
		goto	end_result_loop;
	end if;

	if	count_type > 1	then
		good_type	:= this_type;
	end if;
	if	count_pfx > 1	then
		good_pfx	:= this_pfx;
	end if;
	if	count_sfx > 1	then
		good_sfx	:= this_sfx;
	end if;

	good_qual := null;	

	if	this_pfx <> good_pfx		then
		if	this_pfx = ' '
		and	good_pfx > ' '		then
			good_qual := good_qual || append_pfx;
		elsif	this_pfx > ' '
		and	good_pfx = ' '		then
			good_qual := good_qual || remove_pfx;
		elsif	this_pfx > ' '
		and	good_pfx > ' '		then
			good_qual := good_qual || change_pfx;
		end if;
	end if;

	if	this_type <> good_type		then
		if	this_type = ' '
		and	good_type > ' '		then
			good_qual := good_qual || append_type;
		elsif	this_type > ' '
		and	good_type = ' '		then
			good_qual := good_qual || remove_type;
		elsif	this_type > ' '
		and	good_type > ' '		then
			good_qual := good_qual || change_type;
		end if;
	end if;

	if	this_sfx <> good_sfx		then
		if	this_sfx = ' '
		and	good_sfx > ' '		then
			good_qual := good_qual || append_sfx;
		elsif	this_sfx > ' '
		and	good_sfx = ' '		then
			good_qual := good_qual || remove_sfx;
		elsif	this_sfx > ' '
		and	good_sfx > ' '		then
			good_qual := good_qual || change_sfx;
		end if;
	end if;

	if	reject_count = 0
	and (	per_block   > 0	and accept_count = 1 						-- jan 2004
	or  (	per_lowest  > 0	and this_block   - this_lowest <= tolerance )
	or  (	per_highest > 0	and this_highest - this_block  <= tolerance )	
	    )						then
		permit_update	:= 'yes';
	else
		permit_update	:= 'no';
	end if;

	if	do_audit = 0			then				--	may 2002
		good_qual	:= null;
		good_verify	:= this_verify;
	end if;

	if	do_update > 0
	and	permit_update = 'yes'		then

			update garland.adrResult
			set	addr_pfx	= good_pfx,
				addr_type	= good_type,
				addr_sfx	= good_sfx,
				do_qual	= do_qual || good_qual,
				verify_code = good_verify,
				parcel_id	= good_parcel
			where	rowid	= this_rowid;	

			total_update := total_update + 01;
	end if;

	if	do_print > 0			then
		dbms_output.put_line (	lpad(this_num, 5)	 	  ||' '|| rpad(good_pfx,2) 
						||' '|| rpad(this_name,20) 
						||' '|| rpad(good_type,4) ||' '|| rpad(good_sfx,1)	);
	end if;


	if	do_print > 0			then
		dbms_output.put_line (	lpad(permit_update,5) 		
				||' '||	lpad(good_verify,  5)		
				||'   '||	rpad(this_qual||good_qual,17) 
					||	'rec seq = '|| this_seq 		--	optional
				||'  '||	'rec key = '|| this_key 		--	optional
				);
	end if;

	if	do_print > 01	
	and	block_count > 01
	and	not
	(	this_name	= prev_name		and
		this_block	= prev_block		)	then
	
		for	look in read_block_range
		loop
			dbms_output.put_line (	lpad(this_block,5)	||' '|| 
							rpad(look.addr_pfx,  2) ||' '|| rpad(look.addr_name,20) ||' '|| 
							rpad(look.addr_type, 4) ||' '|| rpad(look.addr_sfx, 02) ||'		'||
							lpad(look.min_block,05) ||' - '|| rpad(look.max_block,05)	
							);
		end loop;
	end if;

<<end_result_loop>>
	null;

end loop;

	close	read_adrResult;

	if	do_commit > 0		then			-- jan 2004
		commit;
	else
		rollback;
	end if;

	dbms_output.put_line (' ' );
	dbms_output.put_line ('REPLACE WRONG STREET	' || to_char(sysdate, 'mon dd,yyyy hh24:mi'));
	dbms_output.put_line ('Input   Count	' 	|| total_input);
	dbms_output.put_line ('Full    Count	' 	|| total_full);
	dbms_output.put_line ('Partial Count	' 	|| total_partial);
	dbms_output.put_line ('Update  Count	' 	|| total_update);
	dbms_output.put_line ('Tolerance		' 	|| tolerance);

end;
