	set echo		off;
	set serveroutput	on;
--	============================================================================
--	Update CDRELADR  UMS/TAX keys from adrResult table
--	============================================================================

	select '*** build App RowID ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " " from dual;

	truncate table	garland.gis_app_rowid	reuse storage;
	alter rollback segment	rb1			online;
	commit;
	set transaction	use rollback segment	rb1;

	insert into		garland.gis_app_rowid
	(
		select	rownum,
				rec_rowid
		from	
		(	select
				addr_name,
				addr_type,
				addr_pfx,
				addr_sfx,
				addr_num,
				rowid			rec_rowid

--			from		garland.adrResult_UMS_Location			-- UMS
			from		garland.adrResult_TAX_Account				-- TAX


			where		parcel_id > '00'
			order by	1,2,3,4,5,6
		)
	);

	commit;
	alter rollback segment	rb1			offline;

--	======================================================================
	select count(*) from 	garland.gis_app_rowid;
	analyze table		garland.gis_app_rowid	compute statistics;
--	======================================================================

--	select '*** update UMS_Key ***  ' " ", 						-- UMS
	select '*** update TAX_Key ***  ' " ", 						-- TAX
		 to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " " from dual;

	drop synonym	temp_synonym;
--	create synonym	temp_synonym	for garland.adrResult_UMS_Location;		--  UMS TABLE
	create synonym	temp_synonym	for garland.adrResult_TAX_Account;		--  TAX TAble

declare

	do_compile		binary_integer	:= 0;
	do_update		binary_integer	:= 0;

	total_match		binary_integer	:= 0;
	total_update	binary_integer	:= 0;

	this_seq		binary_integer	:= 0;

--	============================================================================
cursor	read_APP_address		is

		select t.rec_key, 
			 t.addr_name, t.addr_type, t.addr_pfx, t.addr_sfx, 
			 t.addr_num
		from	 garland.temp_synonym		t,
			 garland.gis_app_rowid		g

		where	 g.row_seq	= this_seq
		and	 g.row_id	= t.rowid;

	APP	read_APP_address%rowtype;

--	============================================================================
cursor	read_GIS_address			is

		select rowid 	row_id
		from	 garland.cdreladr			a

		where	 a.addr_name	= app.addr_name
		and	 a.addr_type	= app.addr_type
		and	 a.addr_pfx		= app.addr_pfx
		and	 a.addr_sfx		= app.addr_sfx
		and	 a.addr_num		= app.addr_num
		and	 rtrim(a.unit_type) is null
		and	 rtrim(a.unit_num)  is null;

--	============================================================================

begin

	if	do_compile > 0	then
		return;
	end if;

loop

	this_seq	:= this_seq + 01;

	open	read_APP_address;

	fetch	read_APP_address			into APP;
	exit when	read_APP_address%notfound
		or	read_APP_address%notfound is null;

for	find in read_GIS_address		loop

	total_match	:= total_match + 01;

	if	do_update > 0			then
		update	garland.cdreladr
--		set		UMS_KEY = app.rec_key				--	UMS KEY
		set		TAX_KEY = app.rec_key				--	TAX KEY
		where		rowid = find.row_id;	

		total_update := total_update + 01;
	end if;

end loop;	
			
	commit;
	close	read_APP_address;

end loop;

	this_seq := this_seq - 01;

	dbms_output.put_line (' ');	
--	dbms_output.put_line ('total UMS    ' || this_seq);		--	UMS
	dbms_output.put_line ('total TAX    ' || this_seq);		--	TAX
	dbms_output.put_line ('total Match  ' || total_match);
	dbms_output.put_line ('total Update ' || total_update);

end;

--	============================================================================

/*

	select count(count(*))
	from	adrResult_UMS_Location
	where	parcel_id > '00'
	and	verify_code = 55
	group by	addr_name || addr_type || addr_pfx || addr_sfx || addr_num
	having	count(*) > 1;


	select	addr_name || addr_type || addr_pfx || addr_sfx || addr_num
	from		cdreladr
	where		rtrim(unit_type) is null
	and		rtrim(unit_num) is null
	minus
	select	addr_name || addr_type || addr_pfx || addr_sfx || addr_num
	from		adrREsult_UMS_Location;


*/

--	============================================================================


