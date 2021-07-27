	set echo		off;
--	======================================================================
--	update adrResult segment id = dcad account number
--	======================================================================

	alter rollback segment rb1		online;
	commit;
	set transaction	use rollback segment	rb1;

	update garland.nsa_dcad_res
	set		
		street_typ	= nvl(street_typ, ' '),
		street_dir	= nvl(street_dir, ' '),
		street_sfx	= nvl(street_sfx, ' '),
		street_num	= nvl(street_num,   0)
	;

	commit;
	alter rollback segment rb1		offline;

	set echo		on;

