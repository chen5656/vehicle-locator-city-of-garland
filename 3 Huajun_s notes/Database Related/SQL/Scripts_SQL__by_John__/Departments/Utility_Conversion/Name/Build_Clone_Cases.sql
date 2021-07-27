	set echo	off;
--	==========================================================================
--	build standard case table for utility clones
--	==========================================================================

	create or replace view	clone_view

	(	case_id,	 table_name, object_num, object_id,   id_prefix, id_suffix		)

	as	select
		case_id,	 item_A,     item_B,     item_C,      item_D,	 item_E	

		from		 garland.clone_case;

--------------------------------------------------------------------------------

	delete from		garland.clone_case
	where case_id = 'UTILITY CONVERT';
	
	commit;

--------------------------------------------------------------------------------

	insert into		garland.clone_view  (case_id, table_name, object_num, object_id, id_prefix, id_suffix)

	select	'UTILITY CONVERT',		--  case id
			item01, 				--  table name		AAA	
			item03 || '_NUM',			--  object num		BBB
			item03 || '_ID',			--  object id		CCC
			item06,				--  object prefix		DDD
			item07				--  object suffix		EEE

	from		garland.GIS_OBJECTS
	where		item03 > '0';
	
	commit;

--------------------------------------------------------------------------------

	select * from garland.clone_view;

--------------------------------------------------------------------------------
	set echo	on;
