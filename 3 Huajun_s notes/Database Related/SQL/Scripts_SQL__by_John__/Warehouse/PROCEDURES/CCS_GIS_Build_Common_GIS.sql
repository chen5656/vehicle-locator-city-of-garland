--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	==========================================================================================
--	Build COMMON_GIS from Address, Road, both node Blocks, and both node Intersections
--	A Road segment has a range and intersection at each of its endpoints (nodes.
--	==========================================================================================

--	execute	garland.CCS_GIS_Build_Common_GIS

	create or replace procedure garland.CCS_GIS_Build_Common_GIS	AS

--	DECLARE

--	=====================================================================

	compile_only	integer	:= 0;
	do_insert		integer	:= 01;
	do_print		integer	:= 0;

	read_limit		integer	:= 111111111;
	loops			integer	:= 10;
	loops_set		integer	:= 10;

	this_block		integer	:= 0;
	that_block		integer	:= 0;
	differ		integer	:= 0;

	total_insert	integer	:= 0;
	total_addr		integer	:= 0;
	total_road		integer	:= 0;
	total_blok1		integer	:= 0;
	total_blok2		integer	:= 0;
	total_xstr1		integer	:= 0;
	total_xstr2		integer	:= 0;
	absent_road		integer	:= 0;
	absent_block	integer	:= 0;

	title			varchar2(100);
	heading		varchar2(100);

	ADDR			gis.Address%rowtype;
	ROAD			gis.Road%rowtype;
	BLOK1			garland.Block%rowtype;
	BLOK2			garland.Block%rowtype;
	XSTR1			garland.Intersection%rowtype;
	XSTR2			garland.Intersection%rowtype;

cursor  Read_ADDRESS	is

	select ADR.*
	from	gis.Address		ADR
	where streetnum not between 9000 and 9999
	AND ROWNUM < read_limit
	order by streetname, streettype, streetprefix, streetsuffix, streetnum;

cursor  Read_ROAD		is

	select RD.*
	from	 gis.ROAD		RD

	where	addr.streetname	= rd.streetname
	and	addr.streettype	= rd.streettype
	and	addr.streetprefix	= rd.streetprefix
	and	addr.streetsuffix	= rd.streetsuffix
	and	addr.streetnum	between rd.rangelo and rd.rangehi

	and	rd.streetclass	in ('LOCAL', 'PRIMARY')
	and	rd.rangehi 		<> 9999
	and	addr.streetnum	  not between 9000 and 9999
	and	rtrim(addr.unit)	   is null
	and	rtrim(addr.building) is null
	order by rd.streetname, rd.streettype, rd.streetprefix, rd.streetsuffix, rd.rangelo;

cursor  Read_LO_BLOCK		is

	select BLK.*
	from	garland.BLOCK	BLK

	where	road.streetname		= blk.addr_name
	and	road.streettype		= blk.addr_type
	and	road.streetprefix		= blk.addr_pfx
	and	road.streetsuffix		= blk.addr_sfx
	and	trunc(road.rangelo,-2)	= blk.addr_block;

cursor  Read_INTERSECTION	is

	select XST.*
	from	garland.INTERSECTION	XST

	where	xst.intersect_id 	like 'BB%'
	and	xst.addr1_name   	= road.streetname
	and	xst.addr1_type   	= road.streettype
	and	xst.addr1_pfx    	= road.streetprefix
	and	xst.addr1_sfx    	= road.streetsuffix
	and	xst.addr1_block  	= This_Block
	order by xst.addr2_name, xst.addr2_type, xst.addr2_pfx, xst.addr2_sfx, xst.addr2_block;

--	=================================================================================
--	'addr',adr.streetnum,adr.streetname,'road',rd.rangelo,rd.rangehi,rd.streetname,
--	'xstr1',xst.addr2_block,xst.addr2_name,'xstr2',y.addr2_block,y.addr2_name
--	===========================================================================

BEGIN
	if	compile_only > 0		then
		return;
	end if;

	if	do_insert > 0		then
		execute immediate ('Truncate table garland.Common_GIS reuse storage');		
	end if;

--	===========================================================================
	title := 'BUILD COMMON GIS ';  dbms_output.put_line(title);
--	===========================================================================

for	READ in Read_Address		loop

	ADDR := READ;
	total_addr := total_addr + 01;

	ROAD := null;
	open	Read_ROAD;
	fetch Read_ROAD	into ROAD;
	if	Read_ROAD%found		then 
		total_road := total_road + 01;
	end if;
	close	Read_ROAD;

	if	ROAD.roadid is null		then 
		absent_road := absent_road + 01;
--		dbms_output.put_line ('-----');
--		dbms_output.put_line ('*** No ROAD exists for ADDRESS: '||addr.streetnum||' '||addr.streetname);
	else

		BLOK1 := null;
		open	Read_LO_BLOCK;
		fetch Read_LO_BLOCK	into BLOK1;
		if	Read_LO_BLOCK%found	then 
			total_blok1 := total_blok1 + 01;
		end if;
		close	Read_LO_BLOCK;


	if	BLOK1.block_id is null		then 
		absent_block := absent_block + 01;
--		dbms_output.put_line ('-----');
--		dbms_output.put_line ('*** No BLOCK exists for ROAD: '||road.rangelo||'-'||road.rangehi||' '||road.streetname);
	end if;

		XSTR1 := null;
		this_block := trunc(road.rangelo,-2);
		open	Read_INTERSECTION;
		fetch Read_INTERSECTION	into XSTR1;
		if	Read_Intersection%found		then 
			total_xstr1 := total_xstr1 + 01;
		end if;
		close	Read_INTERSECTION;

--	----------------------------------------------------------------------------

		loops  := loops_set;
		differ := 0;

		that_block := trunc(road.rangehi,-2);
		if	this_block <> that_block	then
			this_block := that_block;
		end if;

		XSTR2 := null;
		open	Read_INTERSECTION;
		fetch Read_INTERSECTION		into XSTR2;

		while	Read_Intersection%found		Loop

			if	xstr2.addr2_name||'.'||xstr2.addr2_type <> xstr1.addr2_name||'.'||xstr1.addr2_type	then
				differ := 1;
				exit;
			end if;

			fetch Read_INTERSECTION	into XSTR2;

			loops := loops - 01;
			if	loops < 0		then
--				dbms_output.put_line ('*** ERROR *** XSTR2 is Looping');
				exit;
			end if;

		end loop;

		if	differ = 1		then
			total_xstr2 := total_xstr2 + 01;
		else
			XSTR2		:= null;
		end if;

		close	Read_INTERSECTION;

	end if;

--	===========================================================================

	if	do_print > 0		then
		dbms_output.put_line ('-----');
		dbms_output.put_line (addr.streetnum   ||' '||addr.streetlabel);
		dbms_output.put_line (road.rangelo     ||'-'||road.rangehi   ||' '||road.streetlabel );
		dbms_output.put_line (xstr1.addr2_block||' '||xstr1.addr2_pfx||' '||xstr1.addr2_name||' '||xstr1.addr2_sfx);
		dbms_output.put_line (xstr2.addr2_block||' '||xstr2.addr2_pfx||' '||xstr2.addr2_name||' '||xstr2.addr2_sfx);
		do_print := do_print - 01;
	end if;

	if	do_insert > 0		then
		Insert into garland.Common_GIS
		(
			 addr_num
			,addr_pfx
			,addr_name
			,addr_type
			,addr_sfx
			,addr_bldg
			,addr_unit
			,address_id
			,parcel_id
			,block_id
			,road_id
			,street_id
			,intersect_id1
			,intersect_id2
			,parent_id
			,intersection1
			,intersection2
--			,address_type
		)
		Values
		(
			 addr.streetnum
			,addr.streetprefix
			,addr.streetname
			,addr.streettype
			,addr.streetsuffix
			,null,null
			,addr.addressid
			,addr.parcelid
			,blok1.block_id
			,road.roadid
			,road.streetid
			,xstr1.intersect_id
			,xstr2.intersect_id
			,null
			,ltrim(rtrim(XSTR1.addr2_pfx ||' '|| XSTR1.addr2_name ||' '|| XSTR1.addr2_type ||' '|| XSTR1.addr2_sfx))
			,ltrim(rtrim(XSTR2.addr2_pfx ||' '|| XSTR2.addr2_name ||' '|| XSTR2.addr2_type ||' '|| XSTR2.addr2_sfx))
--			,addr.addresstype
		);

		total_insert := total_insert + 01;
	end if;

end loop;

	COMMIT;

	dbms_output.put_line ('-----');
	dbms_output.put_line ('Total Address =    ' || total_addr);
	dbms_output.put_line ('Total Insert  =    ' || total_insert);
	dbms_output.put_line ('Total Road  =      ' || total_road);
	dbms_output.put_line ('Total Block =      ' || total_blok1);
	dbms_output.put_line ('Total Intersect1 = ' || total_xstr1);
	dbms_output.put_line ('Total Intersect2 = ' || total_xstr2);
	dbms_output.put_line ('Absent Road  =     ' || absent_road);
	dbms_output.put_line ('Absent Block =     ' || absent_block);

end;

--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan set	statement_id = 'x'	into jdeacutis.plan_table for
--	=====================================================================
--	=====================================================================
--	select * from jdeacutis.explain_Plan;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================

/*
--	****** check for addresses in multiple road ranges
--	select adr.addressid, adr.streetnum, adr.streetname, rd.rangelo, rd.rangehi, rd.roadid, rd.streetclass
--	select adr.addressid, count(*) counter, min(rd.roadid), max(rd.roadid)
 	from	gis.road    R,
		gis.address A 
	where adr.streetname	= rd.streetname
	and adr.streettype		= rd.streettype
	and adr.streetprefix	= rd.streetprefix
	and adr.streetsuffix	= rd.streetsuffix
	and adr.streetnum between rd.rangelo and rd.rangehi   
	and rd.rangehi <> 9999    
	and rd.streetclass in ('LOCAL', 'PRIMARY')
-- 	AND ADDRESSID in  ( 20802, 20816, 7953, 60700, 20800 )
	AND ADDRESSID in  ( 10981, 69433, 34853, 10982 )
	group by adr.addressid
	having count(*) > 1
	;

     
   select 'ROAD' " ", R.* from gis.ROAD R   where streetname = 
'WOLVERTON'
   order by rangelo;


   select 'XSTR' " ", X.* from garland.INTERSECTION X   where addr1_name = 
'WOLVERTON'
   and intersect_id like 'BB%';

*/
--	=====================================================================

