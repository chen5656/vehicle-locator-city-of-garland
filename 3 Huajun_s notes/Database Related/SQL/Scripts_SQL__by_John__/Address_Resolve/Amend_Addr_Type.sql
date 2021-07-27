	set echo	off;
--	========================================================
--	Look for partial addresses		in adrResult
--	where form_type exists		
--	and   addr_type is empty		in adrResult_Input

--	Update the addr_type = form_type	in adrResult_Input
--	=========================================================

	update garland.adrResult_Input
	set	addr_type = form_type
	where	rec_seq	in
(
	select rec_seq
	from	 garland.adrResult
	where	 mod(verify_code,10) = 4
	and	 form_type > '0'
	and	 addr_type = ' '
)	;

--	ROLLBACK;
	commit;
	
--	===================================================
	set echo	on;

