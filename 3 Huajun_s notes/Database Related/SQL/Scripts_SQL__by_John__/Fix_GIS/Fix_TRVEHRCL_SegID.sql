
	alter table	trvehrcl	disable all triggers;

	alter rollback segment	rb1		online;
	set transaction use rollback segment rb1;

	update trvehrcl
	set	segment_id = seq_segment_id.nextval
	where	segment_id is null;

	commit;
	alter rollback segment	rb1		offline;

	alter table	trvehrcl	enable all triggers;