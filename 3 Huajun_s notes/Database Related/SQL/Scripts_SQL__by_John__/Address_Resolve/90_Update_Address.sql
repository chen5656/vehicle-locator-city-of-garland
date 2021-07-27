

--	******************************************************************************

--	THIS JOB HAS BEEN REPLACED BY SCRIPTS IN \\ADDRESS_RESOLVE\UPDATE

--	******************************************************************************

--	===========================================================================================
--	update application table with results of gis address verification (gis_verify_addr table)
--	===========================================================================================

	set echo		off;
	set timing		on;
	set serveroutput	on;

--	==========================================================================================

declare

		app_table_name		varchar2(80) := 'NSA_CRIME';

		minimum_verify_code	number	:= 10;

--	==========================================================================================

		do_compile			number	:= 0;

		update_count		number	:= 0;
		prev_seqn			number	:= 0;


cursor	read_gis_verify	is

		select	--+ index (v)
			v.*

		from	gis_verify_addr		v
		where	rec_seq > prev_seqn
		and	rownum  < 2;

	ver	read_gis_verify%rowtype;

--	==========================================================================================

begin
	
	if	do_compile > 0		then
		return;
	end if;

loop

	open	read_gis_verify;
	fetch	read_gis_verify				into ver;
	exit when	read_gis_verify%notfound
		or	read_gis_verify%notfound is null;

	if	ver.verify_code < minimum_verify_code		then
		goto	end_loop;
	end if;

--	=====================================================

	if	app_table_name = 'NSA_CODE_INSPECT'		
	and	ver.verify_code > 0

	then	update 		NSA_CODE_INSPECT		

		set	addr_pfx		= ver.addr_pfx,
			addr_name		= ver.addr_name,
			addr_type		= ver.addr_type,
			addr_sfx		= ver.addr_sfx,
			addr_num		= ver.addr_num

			,unit_code		= ver.addr_code
			,unit_num		= ver.addr_unit
			,parcel_id		= ver.parcel_id
			,segment_id		= ver.segment_id
			,verify_code	= ver.verify_code

			where	rowid = ver.rec_rowid;

		update_count := update_count + 01;
	end if;

--	=====================================================
/*

	if	app_table_name = 'NSA_CODE_VIOLATION'		
	and	ver.verify_code > 0

	then	update 		JDEACUTIS.NSA_CODE_VIOLATION		
		set	addr_pfx		= ver.addr_pfx,
			addr_name		= ver.addr_name,
			addr_type		= ver.addr_type,
			addr_sfx		= ver.addr_sfx,
			addr_num		= ver.addr_num

			,addr_code		= ver.addr_code
			,addr_unit		= ver.addr_unit
			,parcel_id		= ver.parcel_id
			,segment_id		= ver.segment_id
			,verify_code	= ver.verify_code

			where	rowid = ver.rec_rowid;

		update_count := update_count + 01;
	end if;

*/
--	=====================================================

	if	app_table_name = 'NSA_CODE_RENTAL'		
	and	ver.verify_code > 0

	then	update 		NSA_CODE_RENTAL		
		set	addr_pfx		= ver.addr_pfx,
			addr_name		= ver.addr_name,
			addr_type		= ver.addr_type,
			addr_sfx		= ver.addr_sfx,
			addr_num		= ver.addr_num

--			,addr_code		= ver.addr_code
			,addr_unit		= ver.addr_unit
			,parcel_id		= ver.parcel_id
			,segment_id		= ver.segment_id
			,verify_code	= ver.verify_code

			,certify_num	= ver.rec_key

			where	rowid = ver.rec_rowid;

		update_count := update_count + 01;
	end if;

--	=====================================================

	if	app_table_name = 'NSA_CRIME'			then
		update		NSA_CRIME		
		set	
			 addr_name		= ver.addr_name
			,addr_type		= ver.addr_type
			,addr_pfx		= ver.addr_pfx
			,addr_sfx		= ver.addr_sfx

--			,addr_code		= ver.addr_code
			,addr_unit		= ver.addr_unit

			,parcel_id		= ver.parcel_id
			,segment_id		= ver.segment_id
			,verify_ID		= ver.verify_code	

--			,LWMAINID		= ver.rec_key

			where	rowid 	= ver.rec_rowid;

		update_count := update_count + 01;
	end if;

--	=====================================================
/*

	if	app_table_name = 'NSA_CODEADDR'		
	and	ver.verify_code >= minimum_verify_code

	then	update  cog.NSA_CODEADDR@cdep.world		
		set
			address_name	= ver.addr_name,
			address_type	= ver.addr_type,
			address_prefix	= ver.addr_pfx,
			address_suffix	= ver.addr_sfx,
			parcel_id		= ver.parcel_id

		where	rowid 		= ver.rec_rowid

		and	address_name	= ver.app_name
		and	address_type	= ver.app_type
		and	address_prefix	= ver.app_pfx
		and	address_suffix	= ver.app_sfx

--		and	nvl (ver.addr_sfx, ' ')	in ( ' ', 'N', 'S', 'E', 'W' )
		and	nvl (ver.addr_code,' ')	< '0'
		and	nvl (ver.addr_unit,' ') < '0'
		;

		update_count := update_count + sql%rowcount;
	end if;

*/
--	=====================================================

<<end_loop>>

	prev_seqn := ver.rec_seq;

	commit;
	close read_gis_verify;

end loop;

	dbms_output.put_line ( ' ' );
	dbms_output.put_line (  app_table_name || '   ' || to_char (sysdate, 'mon dd,yyyy  hh24:mi')  );
	dbms_output.put_line ( 'Update app table with address verification results (gis_verify_addr)' );
	dbms_output.put_line ( 'Updates = ' || update_count );

end;

