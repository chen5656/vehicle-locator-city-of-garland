--	==========================================================================================
--	REMOVE DUPLICATE PARCEL IDS ON CDRELPAR - WITH MSLINK UNDER 50,000
--	==========================================================================================

	set fetchrows	111;
	set echo		off;

--	delete from gis_objects where item01 like '--%';
--	update gis_objects set item01 = rtrim(item01, ' ?' || chr(09) );
--	commit;

--	==========================================================================================

	alter rollback segment	rb1			online;
	set transaction use rollback segment	rb1;

--	truncate table	plan_table;
--	explain plan	set statement_id = 'test'		for

--	delete from	cdrelpar	where	mslink in

(
	select	to_char (mslink, '99999')	mslink
			,parcel_id

	from		cdrelpar		p,
			gis_objects		o

	where		p.mslink = o.item01

	and		mslink < 50000				-- 	all those cdrelpar mslinks < 50,000

	and		parcel_id		in			--	associated with a duplicate parcel id
(
	select 	parcel_id						
	from		cdrelpar
	group by	parcel_id
	having	count(*) > 1
)
)
	order by parcel_id, mslink
;

--	select * from explain_plan;
--	select * from explain_indexed;

	rollback;
	commit;

	alter rollback segment	rb1		offline;

	set echo	on;

--	==========================================================================================
