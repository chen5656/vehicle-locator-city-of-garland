--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================

--	=====================================================================

--	execute	garland.BUILD_ALIAS_NONGAR

--	create or replace procedure garland.BUILD_ALIAS_NONGAR		AS

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

	select 'ALIAS NONGAR  '||to_char(sysdate,'Mon dd hh24:mi') into heading from dual; 
	dbms_output.put_line(heading);
                                                                                                                                                                                           
                                                                                                                                                                                                        
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'ADLETA'                          ,'*'    ,'*' 
	,''  ,'ADLETA'                          ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'ALCAZAR'                         ,'*'    ,'*' 
	,''  ,'ALCAZAR'                         ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'ALHAMBRA'                        ,'*'    ,'*' 
	,''  ,'ALHAMBRA'                        ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'AVENUE W'                        ,'*'    ,'*' 
	,''  ,'AVENUE W'                        ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'BELL'                            ,'*'    ,'*' 
	,''  ,'BELL'                            ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'BROCKWOOD'                       ,'*'    ,'*' 
	,''  ,'BROCKWOOD'                       ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'BROWN'                           ,'*'    ,'*' 
	,''  ,'BROWN'                           ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'CARLY'                           ,'*'    ,'*' 
	,''  ,'CARLY'                           ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'CLUB GLEN'                       ,'*'    ,'*' 
	,''  ,'CLUB GLEN'                       ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'COOPER'                          ,'*'    ,'*' 
	,''  ,'COOPER'                          ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'DEXHAM'                          ,'*'    ,'*' 
	,''  ,'DEXHAM'                          ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'EAST'                            ,'*'    ,'*' 
	,''  ,'EAST'                            ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'FERGUSON'                        ,'*'    ,'*' 
	,''  ,'FERGUSON'                        ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'FOREST GREEN'                    ,'*'    ,'*' 
	,''  ,'FOREST GREEN'                    ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'FREEDOM'                         ,'*'    ,'*' 
	,''  ,'FREEDOM'                         ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'GRAFFITI'                        ,'*'    ,'*' 
	,''  ,'GRAFFITI'                        ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'GREENDALE'                       ,'*'    ,'*' 
	,''  ,'GREENDALE'                       ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'HIGHLAND'                        ,'WY'   ,'*' 
	,''  ,'HIGHLAND'                        ,'WY'   ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'HIGHWAY'                         ,'*'    ,'*' 
	,''  ,'HIGHWAY'                         ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'HOLLOW OAKS'                     ,'*'    ,'*' 
	,''  ,'HOLLOW OAKS'                     ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'HOLLY GLEN'                      ,'*'    ,'*' 
	,''  ,'HOLLY GLEN'                      ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'HUTTON'                          ,'*'    ,'*' 
	,''  ,'HUTTON'                          ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'KNOB OAK'                        ,'*'    ,'*' 
	,''  ,'KNOB OAK'                        ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'LOTTIE WATSON'                   ,'*'    ,'*' 
	,''  ,'LOTTIE WATSON'                   ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'LOUVRE'                          ,'*'    ,'*' 
	,''  ,'LOUVRE'                          ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'LUCY'                            ,'*'    ,'*' 
	,''  ,'LUCY'                            ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'MERRIHAVEN'                      ,'*'    ,'*' 
	,''  ,'MERRIHAVEN'                      ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'MOULIN'                          ,'*'    ,'*' 
	,''  ,'MOULIN'                          ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'MUSE'                            ,'*'    ,'*' 
	,''  ,'MUSE'                            ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'NAME'                            ,'*'    ,'*' 
	,''  ,'NAME'                            ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'PARKLANE'                        ,'*'    ,'*' 
	,''  ,'PARKLANE'                        ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'PARKSHIRE'                       ,'*'    ,'*' 
	,''  ,'PARKSHIRE'                       ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'PINE COVE'                       ,'*'    ,'*' 
	,''  ,'PINE COVE'                       ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'REGAL HAVEN'                     ,'*'    ,'*' 
	,''  ,'REGAL HAVEN'                     ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'SAMINA'                          ,'*'    ,'*' 
	,''  ,'SAMINA'                          ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'SHADY WOOD'                      ,'*'    ,'*' 
	,''  ,'SHADY WOOD'                      ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'SHERMAN'                         ,'*'    ,'*' 
	,''  ,'SHERMAN'                         ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'SILVER MEADOWS'                  ,'*'    ,'*' 
	,''  ,'SILVER MEADOWS'                  ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'STREET B'                        ,'*'    ,'*' 
	,''  ,'STREET B'                        ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'STUART'                          ,'*'    ,'*' 
	,''  ,'STUART'                          ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'TERRACE'                         ,'*'    ,'*' 
	,''  ,'TERRACE'                         ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'TOWNPARK'                        ,'*'    ,'*' 
	,''  ,'TOWNPARK'                        ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'TUDOR'                           ,'*'    ,'*' 
	,''  ,'TUDOR'                           ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'VERNON'                          ,'CT'   ,'*' 
	,''  ,'VERNON'                          ,'CT'   ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'VERSAILLES'                      ,'*'    ,'*' 
	,''  ,'VERSAILLES'                      ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'WHITEWATER'                      ,'*'    ,'*' 
	,''  ,'WHITEWATER'                      ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'WILLOW WAY'                      ,'*'    ,'*' 
	,''  ,'WILLOW WAY'                      ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'WINETTE'                         ,'*'    ,'*' 
	,''  ,'WINETTE'                         ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22$'
	,'*' ,'WOOD PARK'                       ,'*'    ,'*' 
	,''  ,'WOOD PARK'                       ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22/'
	,'*' ,'MEDIAN'                          ,'*'    ,'*' 
	,''  ,'MEDIAN'                          ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22/'
	,'*' ,'MILE POST'                       ,'*'    ,'*' 
	,''  ,'MILE POST'                       ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22/'
	,'*' ,'NSN'                             ,'*'    ,'*' 
	,''  ,'NSN'                             ,''     ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '22/'
	,'N' ,'STAR'                            ,'PK'   ,'*' 
	,'N' ,'STAR'                            ,'PK'   ,''  
	);             
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'AUS TIN'                         ,'*'    ,'*' 
	,''  ,'AUSTIN'                          ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'AVENVE D'                        ,'*'    ,'*' 
	,''  ,'AVENUE D'                        ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'BIG SPRING'                      ,'*'    ,'*' 
	,''  ,'BIG SPRINGS'                     ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'BREANNA WAT'                     ,'*'    ,'*' 
	,''  ,'BREANNA'                         ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'BROADWAY COMM'                   ,'*'    ,'*' 
	,''  ,'BROADWAY COMMONS'                ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'CADDY'                           ,'*'    ,'*' 
	,''  ,'CADDYS'                          ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'CALEGO'                          ,'*'    ,'*' 
	,''  ,'CALLEJO'                         ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 1, 111111, 0, '9', '23'
	,'*' ,'DUKEWOOD'                        ,'*'    ,'*' 
	,''  ,'DUKESWOOD'                       ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'5TH STREET'                      ,'*'    ,'*' 
	,''  ,'FIFTH'                           ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'FIFTH STREET'                    ,'*'    ,'*' 
	,''  ,'FIFTH'                           ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'FORST'                           ,'*'    ,'*' 
	,''  ,'FOREST'                          ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'GARLAND SHP CNTR'                ,'*'    ,'*' 
	,''  ,'GARLAND SHOPPING CTR'            ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'GEORGE BUSH TURNPINE'            ,'*'    ,'*' 
	,''  ,'GEORGE BUSH'                     ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'STATE 190'                       ,'*'    ,'*' 
	,''  ,'GEORGE BUSH'                     ,'HWY'  ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'PRES GEORGE BUSH'                ,'*'    ,'*' 
	,''  ,'GEORGE BUSH'                     ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'GLENWICH'                        ,'*'    ,'*' 
	,''  ,'GLENWICK'                        ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 1, 111111, 0, '9', '23'
	,'*' ,'GRANTHAN'                        ,'*'    ,'*' 
	,''  ,'GRANTHAM'                        ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'30TH E I FWY'                    ,'*'    ,'*' 
	,'E' ,'I30'                             ,'FRWY' ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'I H 30'                          ,'*'    ,'*' 
	,''  ,'I30'                             ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'IH30'                            ,'*'    ,'*' 
	,''  ,'I30'                             ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'I30 RWY'                         ,'*'    ,'*' 
	,''  ,'I30'                             ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'30TH W I FWY'                    ,'*'    ,'*' 
	,'W' ,'I30'                             ,'FRWY' ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'JACK FRANZIN'                    ,'*'    ,'*' 
	,''  ,'JACK FRANZEN'                    ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'JUPTER'                          ,'*'    ,'*' 
	,''  ,'JUPITER'                         ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'TUPITER'                         ,'*'    ,'*' 
	,''  ,'JUPITER'                         ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'KINSGBIRGDE'                     ,'*'    ,'*' 
	,''  ,'KINGSBRIDGE'                     ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 1, 111111, 0, '9', '23'
	,'*' ,'KINGWOOD'                        ,'*'    ,'*' 
	,''  ,'KINGSWOOD'                       ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'HNIGHTSBRIDGE'                   ,'*'    ,'*' 
	,''  ,'KNIGHTSBRIDGE'                   ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 1, 111111, 0, '9', '23'
	,'*' ,'LANE COSTA'                      ,'*'    ,'*' 
	,''  ,'LA COSTA'                        ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 1, 111111, 0, '9', '23'
	,'*' ,'LANE FAWN'                       ,'*'    ,'*' 
	,''  ,'LA FAWN'                         ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 1, 111111, 0, '9', '23'
	,'*' ,'LANE JOLLA'                      ,'*'    ,'*' 
	,''  ,'LA JOLLA'                        ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 1, 111111, 0, '9', '23'
	,'*' ,'LANE PRADA'                      ,'*'    ,'*' 
	,''  ,'LA PRADA'                        ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'LAORADA'                         ,'*'    ,'*' 
	,''  ,'LA PRADA'                        ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 1, 111111, 0, '9', '23'
	,'*' ,'LAKE LAND PARK'                  ,'*'    ,'*' 
	,''  ,'LAKELAND PARK'                   ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'LANE VISTA'                      ,'*'    ,'*' 
	,''  ,'LAVISTA'                         ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'STATE 78'                        ,'*'    ,'*' 
	,''  ,'LAVON'                           ,'HWY'  ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'MARES'                           ,'*'    ,'*' 
	,''  ,'MARS'                            ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'MCCARTNEY'                       ,'*'    ,'*' 
	,''  ,'MC CARTNEY'                      ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'MCCREE'                          ,'*'    ,'*' 
	,''  ,'MC CREE'                         ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'MERIDAN'                         ,'*'    ,'*' 
	,''  ,'MERIDIAN'                        ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'MILKY WAY'                       ,'*'    ,'*' 
	,''  ,'MILKY'                           ,'WY'   ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'MT VERNON'                       ,'*'    ,'*' 
	,''  ,'MOUNT VERNON'                    ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'MEWMAN'                          ,'*'    ,'*' 
	,''  ,'NEWMAN'                          ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 1, 111111, 0, '9', '23'
	,'*' ,'OAKPOIKT'                        ,'*'    ,'*' 
	,''  ,'OAK POINT'                       ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'PUTMAN WAY'                      ,'*'    ,'*' 
	,''  ,'PUTMAN'                          ,'WY'   ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'PUTNAM WAY'                      ,'*'    ,'*' 
	,''  ,'PUTMAN'                          ,'WY'   ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'QUAIL HILL CI'                   ,'*'    ,'*' 
	,''  ,'QUALI HILL'                      ,'CIR'  ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'RETAIL'                          ,'*'    ,'*' 
	,''  ,'RETAIL'                          ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'ROANE'                           ,'*'    ,'*' 
	,''  ,'ROAN'                            ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'ROUTE'                           ,'*'    ,'*' 
	,''  ,'ROUTE'                           ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 1, 111111, 0, '9', '23'
	,'*' ,'SANDESTINE'                      ,'*'    ,'*' 
	,''  ,'SANDESTIN'                       ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'SHADY HOLLOW CTR'                ,'*'    ,'*' 
	,''  ,'SHADY HOLLOW'                    ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'SHEPARD'                         ,'*'    ,'*' 
	,''  ,'SHEPHERD'                        ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'SHEREHERD'                       ,'*'    ,'*' 
	,''  ,'SHEPHERD'                        ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'SHOP'                            ,'*'    ,'*' 
	,''  ,'SHOP'                            ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 1, 111111, 0, '9', '23'
	,'*' ,'SILVERLEAL'                      ,'*'    ,'*' 
	,''  ,'SILVERLEAF'                      ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'STATE 66'                        ,'*'    ,'*' 
	,''  ,'STATE HIGHWAY 66'                ,'HWY'  ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'TRIALRIDGE'                      ,'*'    ,'*' 
	,''  ,'TRAILRIDGE'                      ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 0, 999999, 0, '9', '23'
	,'*' ,'TRINID'                          ,'*'    ,'*' 
	,''  ,'TRINIDAD'                        ,''     ,''  
	);              
	insert into garland.adrAlias_Insert_vw	values ( 1, 111111, 0, '9', '23'
	,'*' ,'WHITEHAVEM'                      ,'*'    ,'*' 
	,''  ,'WHITEHAVEN'                      ,''     ,''  
	);              


	COMMIT;

END;

