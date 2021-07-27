
--	========================================================

	alter rollback segment		rb_large		online;
	commit;
	set transaction	use rollback segment		rb_large;


	commit;
	alter rollback segment		rb_large		offline;

--	========================================================
