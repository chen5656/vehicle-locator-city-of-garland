--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
--	===========================================================================================
--	D_View_Intersect
--	===========================================================================================
	select 'INTERSECT VIEW  ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi') " " from dual;


	create or replace view	garland.Temp_View		as

	select
		s1.addr_name		s1_addr_name,
		s1.addr_type		s1_addr_type,
		s1.addr_pfx			s1_addr_pfx,
		s1.addr_sfx			s1_addr_sfx,
		s1.addr_blok		s1_addr_block,

		s2.addr_name		s2_addr_name,
		s2.addr_type		s2_addr_type,
		s2.addr_pfx			s2_addr_pfx,
		s2.addr_sfx			s2_addr_sfx,
		s2.addr_blok		s2_addr_block,

		s1.hub_node			hub_node

	from	garland.Temp_View3	S1,
		garland.Temp_View3	S2

	where	s1.hub_node   = s2.hub_node
	and (	s1.addr_name <> s2.addr_name
	or	s1.addr_type <> s2.addr_type )

--	and	s1.road_id	 <> s2.road_id
	;


--	select * from garland.Temp_View	where rownum < 11;

