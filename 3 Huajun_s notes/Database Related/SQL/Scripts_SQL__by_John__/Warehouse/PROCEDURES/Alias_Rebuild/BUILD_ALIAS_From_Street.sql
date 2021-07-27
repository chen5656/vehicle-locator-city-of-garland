--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================

--	=====================================================================

--	execute	garland.BUILD_ALIAS_FROM_STREET

--	create or replace procedure garland.BUILD_ALIAS_FROM_STREET		AS

	DECLARE

--	=====================================================================

	compile_only	integer	:= 01;

	total_processed	integer	:= 0;
	title			varchar2(100);
	heading		varchar2(100);
	script		varchar2(2000);

BEGIN
	if	compile_only > 0		then
		return;
	end if;

	select 'ALIAS FROM STREET   '||to_char(sysdate,'Mon dd hh24:mi') into heading from dual; 
	dbms_output.put_line(heading);

--	=========================================================================================   
--	generate adrAlias from adrStreet
--	=========================================================================================   

	script := 'truncate table garland.adrAlias reuse storage';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

--	=========================================================================================   
--	truncate table	plan_table		reuse storage;
--	explain plan	set statement_id = 'test'		for
--	=========================================================================================   

--	select 'AAA' " " from dual;

	insert into	garland.adrAlias
(
			alias_pfx,
			alias_name,
			alias_type,
			alias_sfx,
			alias_lo,
			alias_hi,
			addr_min,
			addr_pfx,
			addr_name,
			addr_type,
			addr_sfx,
			alias_weight,		-- jul 2003
			alias_match,		-- nov 2003
			alias_how,
			alias_reduced,
			alias_compact,
			alias_compress
)

	select	alias_pfx,
			alias_name,
			alias_type,
			alias_sfx,
			0,
			999999,
			0,
			max(addr_pfx),
			max(addr_name),
			max(addr_type),
			max(addr_sfx),
			max(alias_weight)					alias_weight,
			0							alias_match,		-- nov 2003
			max(alias_how)					alias_how,
			max(garland.adr_compress_name (alias_name, '1')),
			max(garland.adr_compress_name (alias_name, '4')),
			max(garland.adr_compress_name (alias_name, '6'))
	from

--	=========================================================================================

(
	select	''		alias_pfx,
			''		alias_name,
			''		alias_type,
			''		alias_sfx,
			''		addr_pfx,
			''		addr_name,
			''		addr_type,
			''		addr_sfx,
			0		alias_weight,		-- july 2003
			''		alias_how
	from		dual
	where		dummy = 'bogus'

--	=========================================================================================   
--	VALID STREET NAMES

	union all
	select distinct
		'*',										
		s.addr_name,
		'*',										
		'*',										

		'',				
		s.addr_name,			
		'',			
		'',				
		008,		
		'asis'

	from	garland.adrStreets	s

--	=========================================================================================   
--	PUSH STREET TYPE OUT OF NAME
--	Example:	"Milky Wy"	

	union all
	select 	
		'*',										
		s.addr_name ||' '|| i.possible,					
		' ',							--  apr 2004
		'*',										

		'',				
		s.addr_name,			
		s.addr_type,			
		'',				
		007,
		'tpush'			

	from	garland.adrStreets	s,
		garland.adrItem	i

	where	s.addr_type	= i.standard
	and	i.class	= 'T'
	and	i.possible in (i.name)				-- nov 2004
--	and	i.possible in (i.standard, i.name)
	and	length (s.addr_name ||' '|| i.possible) <= 20

--	=========================================================================================   
--	PUSH PREFIX OUT OF NAME
--	Example:	"E VISTA"	

	union all
	select 	
		' ',							-- apr 2004
		i.possible ||' '|| s.addr_name,
		'*',
		'*',
		s.addr_pfx,
		s.addr_name,
		'',
		'',
		007,
		'ppush'

	from	garland.adrStreets	s,
		garland.adrItem	i

	where	s.addr_pfx  = i.standard
	and	i.class	= 'D'
	and	i.possible in (i.name)				-- nov 2004
	and	length (i.possible || ' '|| s.addr_name) <= 20 

--	=========================================================================================   
--	PUSH SUFFIX OUT OF NAME
--	Example:	"COUNTRY CLUB E"	

	union all
	select 	
		'*',
		s.addr_name ||' '|| i.possible, 
		'*',
		' ',							-- apr 2004
		'',
		s.addr_name,
		'',
		s.addr_sfx,
		007,
		'spush'

	from	garland.adrStreets	s,
		garland.adrItem	i

	where	s.addr_sfx  = i.standard
	and	i.class	= 'D'
	and	i.possible in (i.name)				-- nov 2004
	and	length (s.addr_name ||' '|| i.possible) <= 20 


--	=========================================================================================   
--	PULL STREET TYPE INTO NAME
--	Example:	"Miller Park"

	union all
	select	
		'*',
		rtrim (replace (s.addr_name, i.name)), 
		i.standard,									
		'*',
		'',
		s.addr_name,
		' ',							--	new
		'',
		007,
		'tpull'

	from	garland.adrStreets		s,
		garland.adrItem		i

	where i.class = 'T'
	and	s.addr_name like '%' || i.name
	and	replace (s.addr_name, i.name) > ' '


--	=========================================================================================   
--	PULL PREFIX INTO NAME
--	Example:	"North Shore"

	union all
	select 	
		decode (
			rtrim (substr (addr_name, 01, endpoint)),
			'NORTH',	'N',
			'SOUTH',	'S',
			'EAST',	'E',
			'WEST',	'W',
			'NORTHEAST','NE',
			'NORTHWEST','NW',
			'SOUTHEAST','SE',
			'SOUTHWEST','SW',
			' '			),

		ltrim(substr (addr_name, endpoint + 01)),
		'*',
		'*',
		' ',						
		addr_name,
		'',
		'',
		007,
		'ppull'

	from
	(
		select	05						endpoint,
				addr_name
		from		garland.adrStreets		s,
				garland.adrEnding			e
		where		addr_pfx  < 'A' 
		and 	(	addr_name like 'NORTH%'
		or		addr_name like 'SOUTH%'	)
		and		addr_name like '%' || e.name 
		and		length (addr_name) <= length(e.name) + 06

		union
		select	04						endpoint,
				addr_name
		from		garland.adrStreets			s,
				garland.adrEnding			e
		where		addr_pfx  < 'A' 
		and	(	addr_name like 'EAST%'
		or		addr_name like 'WEST%'		)
		and		addr_name like '%' || e.name 
		and		length (addr_name) <= length(e.name) + 05
	)									prefix

	union all
	select 	
		decode (
			 addr_name,
			'NORTH',	'N',
			'SOUTH',	'S',
			'EAST',	'E',
			'WEST',	'W',
			'NORTHEAST','NE',
			'NORTHWEST','NW',
			'SOUTHEAST','SE',
			'SOUTHWEST','SW',
			' '	
			),
		' ',
		addr_type,
		'*',

		' ',
		addr_name,
		addr_type,
		'',
		007,
		'ppull'

	from	garland.adrStreets
	where	addr_name in ( 	'NORTH',	 'SOUTH',	  'EAST',	   'WEST', 
					'NORTHEAST', 'NORTHWEST', 'SOUTHEAST', 'SOUTHWEST' )

--	=========================================================================================   
--	PULL SUFFIX INTO NAME
--	Example:	"Key West"

	union all
	select 	

		'*',
		nvl (rtrim(substr (addr_name, 01, startpoint - 01)),' '),
		'*',
		decode (
			ltrim (substr (addr_name, startpoint)),
			'NORTH',	'N',
			'SOUTH',	'S',
			'EAST',	'E',
			'WEST',	'W',
			' '	
			),
		'',
		addr_name,
		'',
		' ',					
		007,
		'spull'

	from
	(
		select	length(addr_name) - 04			startpoint,
				addr_name
		from		garland.adrStreets			s
		where		addr_pfx  < 'A' 
		and 	(	addr_name like '%NORTH'
		or		addr_name like '%SOUTH'	)

		union
		select	length(addr_name) - 03			startpoint,
				addr_name
		from		garland.adrStreets			s
		where		addr_pfx  < 'A' 
		and	(	addr_name like '%EAST'
		or		addr_name like '%WEST'		)
	)									suffix

--	=========================================================================================   
--	NAME IS A STREET TYPE
--	Example:	Parkway

	union	 all
	select 	
		'*',
		' ',
		i.standard, 
		'*',
		'',
		s.addr_name,
		' ',							
		'',
		007,
		'pull'

	from	garland.adrStreets		s,
		garland.adrItem			i				

	where	s.addr_name  = i.name
	and	i.class = 'T'

--	=========================================================================================   
--	A PREFIX and NAME ARE RUN TOGETHER
--	A PREFIX APPEARS AS A SUFFIX
--	A SUFFIX APPEARS AS A PREFIX
--	Example:	"SPlano"
--	Example:	"Avenue D E"
--	Example:	"E Walnut Cir"

	union all
	select	
		'*',
		s.addr_pfx || s.addr_name,
		'*',
		'*',
		s.addr_pfx,
		s.addr_name,
		'',
		'',
		003,
		'pcut'

	from	garland.adrStreets	s
	where	s.addr_pfx > '0'


	union all
	select 	
		'*',
		addr_name,					
		'*',
		addr_pfx,
		addr_pfx,
		addr_name,
		'',
		' ',
		004,
		'pflip'

	from	garland.adrStreets	s
	where	addr_pfx > '0'
	and not exists
(
	select 'x'
	from	garland.adrStreets		
	where	addr_name	= s.addr_name
	and	addr_sfx	= s.addr_pfx
)
	

	union all
	select 	
		addr_sfx,
		addr_name,					
		'*',
		'*',
		' ',
		addr_name,
		'',
		addr_sfx,
		004,
		'sflip'

	from	garland.adrStreets	s
	where	addr_sfx > '0'
	and not exists
(
	select 'x'
	from	garland.adrStreets		
	where	addr_name	= s.addr_name
	and	addr_pfx	= s.addr_sfx
)
	
--	=========================================================================================   
--	A PARTIAL NAME IS UNIQUE TO ADRSTREET
--	Example:  "Bridgeport"   is the unique name containing "Bridge"  

	union all
	select
		'*',
		short, 
		'*',
		'*',
		'',
		addr_name,
		'',
		'',
		002,
		'more'

		from
	(
		select	addr_name,
				rtrim (substr (addr_name, 01, instr (addr_name, addr_ending) - 01 ))	short
		from		garland.adrStreets
		where		addr_ending > '0'
	)															sh

		where		length(short) >= 3

		and not exists
	(
		select	'x'
		from		garland.adrStreets
		where		addr_name = short
		or		addr_name like short ||' %'
	)
		and not exists
	(
		select	short
		from		garland.adrStreets
		where		addr_name like short || '%'
		group by	short
		having	count(*) > 1
	)

--	=========================================================================================   
--	A WORD IS UNIQUE TO MULTIPLE WORD STREET
--	Example:  "Brandon Park"   is the unique name containing "Brandon"  

	union all
	select
		'*',
		short, 
		'*',
		'*',
		'',
		addr_name,
		'',
		'',
		002,
		'more'

		from
	(
		select	addr_name,
				rtrim(addr_begin)				short
		from		garland.adrStreets
		where		addr_name like '% %'
	)									sh

		where		length(short) >= 3

		and	1 =
	(
		select	count(distinct addr_name)
		from		garland.adrStreets
		where		addr_name like short || ' %'
	)

		and not exists
	(
		select	'x'
		from		garland.adrStreets
		where		addr_name like short ||'%'
		group by	short
		having	count(*) > 1
	)


--	=========================================================================================   
--	UNIQUE NAME ENDING THAT IS UNLIKE ANY OTHER NAME
--	Example:  "High Plateau"   is the unique name containing "Plateau"  

	union
	select 	
		'*',
		s.addr_ending,					
		'*',
		'*',
		'',
		s.addr_name,
		'',
		'',
		002,
		'more'

	from garland.adrStreets		s
	where	addr_ending in
(
	select addr_ending
	from	garland.adrStreets		ss
	where not exists
(
	select 'x'
	from	garland.adrStreets		sss
	where	addr_name like '%' || ss.addr_ending || '%'
	and	addr_name <> ss.addr_name
)
	group by addr_ending
	having count(*) = 1
)


--	=========================================================================================   
--	PARTIAL NAME CORRESPONDS TO MANY STREET NAMES
--	example: "Naaman"  is found in "Naaman Forest" and "Naaman School".  Leave it unchanged ($)

	union all
	select 
		'*',
		short, 
		'*',
		'*',
		'',
		short,
		'',
		'',
		007,
		'part'

		from
	(
		select	nvl (rtrim (replace (addr_name, addr_ending)),' ')	short,
				addr_name
		from		garland.adrStreets
		where		length(addr_ending) > 1 
	)												sh

		where		length(short) >= 5

		and	1 <
	(
		select	count(distinct addr_name)
		from		garland.adrStreets
		where		addr_name like short || '%'
	)


		and not exists
	(
		select	addr_name
		from		garland.adrStreets
		where		addr_name = short
	)


	union all
	select 		
		'*',
		short, 
		'*',
		'*',
		'',
		short,
		'',
		'',
		007,
		'part'

		from
	(
		select	nvl (rtrim (substr (addr_name, 01, instr (addr_name, ' '))),' ')	short,
				addr_name
		from		garland.adrStreets
		where		instr (addr_name, ' ') > 0
	)												sh

		where		length(short) >= 5

		and	1 <
	(
		select	count(distinct addr_name)
		from		garland.adrStreets
		where		addr_name like short || ' %'
	)


		and not exists
	(
		select	addr_name
		from		garland.adrStreets
		where		addr_name = short
	)

--	===================================================================================
)

	where		alias_name not like '%?%'				--	new

	group by	alias_pfx,
			alias_name,
			alias_type,
			alias_sfx

	having count (distinct addr_pfx || addr_name || addr_type || addr_sfx) = 1 

--	=========================================================================================   

	order by	11,2,3,1,4;

	COMMIT;

--	=========================================================================================   
--	=========================================================================================   
--	=========================================================================================   

--	select 'BBB' " " from dual;

--	=========================================================================================   
--	NAME CONTAINS BOTH PREFIX AND TYPE				
--	NAME CONTAINS BOTH TYPE AND SUFFIX	
--	Examples:	West Way	Park East

	insert into garland.adrAlias

	select 	
		a.alias_pfx,
		' ',
		i.standard, 
		'*',
		0,999999,0,
		' ',
		a.addr_name,
		' ',					
		'',
		'pull',
		' ', ' ', ' '
		,007
		,0
		,0						-- dec 2004

	from	garland.adrAlias_vw		a,
		garland.adrItem			i				

	where	a.alias_how  = 'ppull'
	and	a.alias_name = i.name
	and	i.class = 'T'
	
	union
	select 	
		'*',
		' ',					
		i.standard, 
		a.alias_sfx,
		0,999999,0,
		'',
		a.addr_name,
		' ',
		' ',
		'pull',
		' ', ' ', ' '
		,007
		,0
		,0						-- dec 2004

	from	garland.adrAlias_vw		a,
		garland.adrItem			i				

	where	a.alias_how  = 'spull'
	and	a.alias_name = i.name
	and	i.class = 'T'

	order by	11,2,3,1,4;

	COMMIT;					


--	select 'CCC' " " from dual;

--	=========================================================================================   
--	STREET NAME IS POSSESSIVE, BUT 'S' IS PARSED AS SUFFIX
--	Example:	Caddy	S		Shannon S
--	TEMPORARY UNTIL PARSE ROUTINE IS IMPROVED

	insert into garland.adrAlias

	select
		'*',
		rtrim(addr_name,'S'),
		'*',
		'S',
		0,999999,0,
		'',
		addr_name,
		'',
		' ',
		'pulls',
		' ', ' ', ' '
		,004
		,0
		,0						-- dec 2004

	from	garland.adrStreets	
	where addr_name like '%S'
	and	addr_name not like '%SS'
	and	translate(addr_name, 'AEIU', 'OOOO') not like '%OS'

--	=========================================================================================   
--	STREET CONTAINS INVALID MIX OF VALID PREFIX and TYPE
--	Examples:	S Fifth Cir		N Country Club Pkwy

	union

	select distinct
		pp.addr_pfx,
		s.addr_name,
		tt.addr_type,
		'*',
		0,999999,0,
		pp.addr_pfx,
		s.addr_name,
		tt.addr_type,
		'',
		'mixed',
		' ', ' ', ' '
		,007
		,0
		,0						-- dec 2004

	from		garland.adrStreets	s,
(
	select	addr_name, addr_pfx
	from		garland.adrStreets
	where		addr_name	in
(
	select	addr_name
	from		garland.adrStreets
	group by	addr_name
	having	count (distinct addr_pfx) > 1
))							pp,

(
	select	addr_name, addr_type
	from		garland.adrStreets
	where		addr_name	in
(
	select	addr_name
	from		garland.adrStreets
	group by	addr_name
	having	count(distinct addr_type) > 1
))							tt

	where		s.addr_name	= pp.addr_name
	and		s.addr_name	= tt.addr_name
	and		pp.addr_pfx  > ' '
	and		tt.addr_type > ' '
	and not exists
(
	select 'x'
	from		garland.adrStreets
	where		addr_type	= tt.addr_type
	and		addr_pfx	= pp.addr_pfx
)

	order by	11,2,3,1,4;

	COMMIT;

--	select 'DDD' " " from dual;


--	=========================================================================================   
--	STREET NAME IS PLURAL	
--	Example:	King Rd => Kings Rd

	insert into garland.adrAlias

	select 	
		'*',
		a.addr_name,					
		b.addr_type,
		'*',
		0,999999,0,
		'',
		b.addr_name,
		b.addr_type,
		'',
		'plur',
		' ', ' ', ' '
		,003
		,0
		,0							-- dec 2004	

	from 	garland.adrStreets		a,
		garland.adrStreets		b
	where	a.addr_name = rtrim(b.addr_name, 'S')
	and	b.addr_name like '%S'

--	=========================================================================================   
	;
	COMMIT;

--	select 'FFF' " " from dual;

--	=========================================================================================   
--	SUBSTITUTE ALTERNATIVE PREFIX
--	SUBSTITUTE ALTERNATIVE TYPE
--	Example:	N Shiloh Rd		NO Shiloh Rd
--			N Fifth  Cir	N  Fifth  CR

	insert into garland.adrAlias

	select 	
		i.possible,
		a.alias_name,
		a.alias_type, 
		a.alias_sfx,
		a.alias_lo,
		a.alias_hi,
		a.addr_min,
		a.addr_pfx,
		a.addr_name,
		a.addr_type,					
		a.addr_sfx,
		a.alias_how || ';',
		a.alias_reduced,
		a.alias_compact,
		a.alias_compress,
		a.alias_weight
		,0		
		,0							-- dec 2004	

	from	garland.adrAlias		a,
		garland.adrItem		i				

	where i.class = 'D'
	and 	a.alias_pfx  = i.standard
	and	a.alias_pfx <> i.possible
	and	i.name	<> i.possible

	union all

	select 	
		a.alias_pfx,
		a.alias_name,
		i.possible,
		a.alias_sfx,
		a.alias_lo,
		a.alias_hi,
		a.addr_min,
		a.addr_pfx,
		a.addr_name,
		a.addr_type,					
		a.addr_sfx,
		a.alias_how || ';',
		a.alias_reduced,
		a.alias_compact,
		a.alias_compress,
		a.alias_weight
		,0
		,0							-- dec 2004	

	from	garland.adrAlias		a,
		garland.adrItem		i				

	where i.class = 'T'
	and 	a.alias_type  = i.standard
	and	a.alias_type <> i.possible
	and	i.name	 <> i.possible;

	COMMIT;

--	=========================================================================================   

--	select 'XXX' " " from dual;

--	=========================================================================================   
--	PARTIAL STREET NAME + STREET TYPE determines FULL STREET NAME

	insert into	garland.adrAlias
(
			alias_pfx,
			alias_name,
			alias_type,
			alias_sfx,
			alias_lo,
			alias_hi,
			addr_min,
			addr_pfx,
			addr_name,
			addr_type,
			addr_sfx,

			alias_weight,		
			alias_match,		
			alias_how,
			alias_reduced,
			alias_compact,
			alias_compress
)

	select	alias_pfx,
			alias_name,
			alias_type,
			alias_sfx,
			0,
			999999,
			0,
			addr_pfx,
			addr_name,
			addr_type,
			addr_sfx,

			alias_weight,
			0							alias_match,
			alias_how,
			garland.adr_compress_name (alias_name, '2'),
			garland.adr_compress_name (alias_name, '4'),
			garland.adr_compress_name (alias_name, '6')
	from
(
	select	''		alias_pfx,
			''		alias_name,
			''		alias_type,
			''		alias_sfx,
			''		addr_pfx,
			''		addr_name,
			''		addr_type,
			''		addr_sfx,
			0		alias_weight,
			''		alias_how
	from		dual
	where		dummy = 'bogus'

--	=========================================================================================   
--	PARTIAL STREET NAME + STREET PREFIX determines FULL STREET NAME

	union
	select
		'*',										
		rtrim(addr_begin),					
		addr_type,										
		'*',										
		'',				
		addr_name,			
		'',			
		'',				
		002,
		'mores'			
	from
(
	select
		 max(addr_pfx)		addr_pfx,
		 max(addr_name)		addr_name,
		 max(addr_type)		addr_type,
		 max(addr_sfx)		addr_sfx,
		 rtrim(addr_begin)	addr_begin 

	from  garland.adrStreets		s
	where	addr_type   > '0'
	and	addr_ending > '0'

	and exists
(
	select 'x'
	from	garland.adrAlias			
	where	alias_how = 'asis'
	and	alias_reduced = s.addr_reduced
)	

	and not exists
(
	select 'x'
	from	garland.adrAlias
	where	alias_how = 'asis'
	and	alias_reduced = s.addr_reduced
)	

	and not exists
(
	select 'x'
	from	 garland.adrAlias
	where	 alias_name = rtrim(s.addr_begin)
	and	 alias_how in ( 'asis' )
)

	and not exists
(
	select 'x'
	from	 garland.adrAlias			a
	where	a.alias_name	= rtrim(s.addr_begin)	
	and	a.alias_type	= s.addr_type	
)
	group by	rtrim(addr_begin), addr_type
	having	count(distinct addr_name) = 1
)

--	=========================================================================================   
--	PARTIAL STREET NAME + STREET TYPE + STREET PREFIX determines FULL STREET NAME

	union
	select
		'*',										
		rtrim(addr_begin),					
		addr_type,										
		'*',										
		'',				
		addr_name,			
		'',			
		'',				
		002,
		'mores'

	from
(
	select
		 max(addr_pfx)		addr_pfx,
		 max(addr_name)		addr_name,
		 max(addr_type)		addr_type,
		 max(addr_sfx)		addr_sfx,
		 rtrim(addr_begin)	addr_begin 

	from  garland.adrStreets		s
	where	addr_type   > '0'
	and	addr_ending > '0'

	and not exists
(
	select 'x'
	from	garland.adrAlias
	where	alias_how = 'more'
	and	alias_name = rtrim(s.addr_begin)					
)	

	and not exists				--  dec 2003
(
	select 'x'
	from	garland.adrStreets		ss
	where	rtrim(s.addr_begin) = ss.addr_reduced
	and	s.addr_name		 <> ss.addr_name
)

	and not exists	
(
	select 'x'
	from	 garland.adrAlias
	where	 alias_name = rtrim(s.addr_begin)
	and	 alias_how in ( 'asis' )
)

	and not exists
(
	select 'x'
	from	 garland.adrAlias			a
	where	a.alias_name	= rtrim(s.addr_begin)	
	and	a.alias_type	= s.addr_type	
)

	and not exists
(
	select 'x'
	from	 garland.adrAlias			a
	where	a.alias_name	= rtrim(s.addr_begin)	
	and	a.alias_pfx		= s.addr_pfx	
)

	group by	rtrim(addr_begin), addr_type
	having	count(distinct addr_name) = 1
)

--	=========================================================================================   

	union
	select
		addr_pfx,										
		rtrim(addr_begin),					
		addr_type,										
		'*',										
		'',				
		addr_name,			
		'',			
		'',				
		002,
		'mores'			
	from
(
	select
		 max(addr_pfx)		addr_pfx,
		 max(addr_name)		addr_name,
		 max(addr_type)		addr_type,
		 max(addr_sfx)		addr_sfx,
		 rtrim(addr_begin)	addr_begin 
	from  garland.adrStreets			s
	where	addr_ending > '0'
	and	addr_pfx   > '0'
	and	addr_type  > '0'

	and not exists
(
	select 'x'
	from	 garland.adrAlias
	where	 alias_name = rtrim(s.addr_begin)
	and	 alias_how in ( 'asis' )
)

	and not exists
(
	select 'x'
	from	 garland.adrAlias			a
	where	a.alias_name	= rtrim(s.addr_begin)	
	and	a.alias_pfx	 	= s.addr_pfx	
	and	a.alias_type	= s.addr_type	
)
	group by	rtrim(addr_begin), addr_pfx, addr_type
	having	count(distinct addr_name) = 1
)
);

	total_processed := sql%rowcount;
	dbms_output.put_line ( 'Insert total = ' || total_processed);

	COMMIT;

--	=========================================================================================   
	script := 'analyze table garland.ADRALIAS compute statistics';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);
--	=========================================================================================   

END;

