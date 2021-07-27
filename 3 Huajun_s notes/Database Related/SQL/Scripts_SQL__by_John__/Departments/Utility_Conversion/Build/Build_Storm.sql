
--	***************************************************
   
select 'UTSTOHWAL' " "  from dual;

	-- truncate table	GARLAND.UTSTOHWAL		REUSE STORAGE;
   
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

   -- -- explain plan  set statement_id = 'UTSTOHWAL' for 
 
insert into GARLAND.UTSTOHWAL
( 
	 mslink  
	,mapid   
--	,ats 
)
select  
	 mslink  
	,mapid   
--	,ats 
from   GARLAND.UTSTOHDWL;

commit;
alter rollback segment rb1   offline;


--	***************************************************
  
select 'UTSTOINLT' " "  from dual;

	-- truncate table	GARLAND.UTSTOINLT		REUSE STORAGE;
    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

   -- -- explain plan  set statement_id = 'UTSTOINL' for 
  
insert into GARLAND.UTSTOINLT
(    
	 mslink  
	,mapid   
	,inlet_id    
	,inlet_code    
	,map_grid    
	,map_quad    
	,inlet_num   
	,inlet_type    
	,inlet_size    
--	,asbuilt_date  
--	,ats 
)
select  
	 mslink  
	,mapid   
	,inlet_id    
	,inlet_code    
	,map_grid    
	,map_quad    
	,inlet_num   
	,inlet_type    
	,inlet_size    
--	,asbuilt_date  
--	,ats 
from   GARLAND.UTSTOINL;

commit;
alter rollback segment rb1   offline;


--	***************************************************
   
select 'UTSTOJUNC' " "  from dual;

	-- truncate table	GARLAND.UTSTOJUNC		REUSE STORAGE;
    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

   -- -- explain plan  set statement_id = 'UTSTOJUNC' for 
  
insert into GARLAND.UTSTOJUNC
(    
	 mslink  
	,mapid   
)
select  
	 mslink  
	,mapid   
from   GARLAND.UTSTOJUN;

commit;
alter rollback segment rb1   offline;

--	***************************************************
   
select 'UTSTOMANH' " "  from dual;

	-- truncate table	GARLAND.UTSTOMANH		REUSE STORAGE;
 
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

   -- -- explain plan  set statement_id = 'UTSTOMANH' for 
 
insert into GARLAND.UTSTOMANH
( 
	 mslink  
	,mapid   
	,manhole_id    
	,map_grid    
	,map_quad    
	,manhole_num   
--	,asbuilt_date  
--	,ats 
)
select  
	 mslink  
	,mapid   
	,manhole_id    
	,map_grid    
	,map_quad    
	,manhole_num   
--	,asbuilt_date  
--	,ats 
from   GARLAND.UTSTOMH;

commit;
alter rollback segment rb1   offline;


--	***************************************************
    
select 'UTSTOCHAN' " "  from dual;

	-- truncate table	GARLAND.UTSTOCHAN		REUSE STORAGE;
    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

   -- -- explain plan  set statement_id = 'UTSTOCHAN' for 
  
insert into GARLAND.UTSTOCHAN
(    
	 mslink  
	,mapid   
	,channel_type  
	,channel_desc  
	,general_comments				--
	,channel_size  
	,channel_length    
--	,quantity    
--	,boxwide 
--	,boxtall 
--	,year_blt    
--	,flag    
	,channel_id    
	,map_grid    
	,map_quad    
	,channel_num   
--	,pipe_length1  
--	,ats 
)
select  
	 mslink  
	,mapid   
	,channel_type  
	,channel_desc  
	,general_desc
	,channel_size  
	,channel_length    
--	,quantity    
--	,boxwide 
--	,boxtall 
--	,year_blt    
--	,flag    
	,channel_id    
	,map_grid    
	,map_quad    
	,channel_num   
--	,pipe_length1  
--	,ats 
from   GARLAND.UTSTOOCH;

commit;
alter rollback segment rb1   offline;


--	***************************************************
   
select 'UTSTOOUTF' " "  from dual;

	-- truncate table	GARLAND.UTSTOOUTF		REUSE STORAGE;
    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

   -- -- explain plan  set statement_id = 'UTSTOOUTF' for 
  
insert into GARLAND.UTSTOOUTF
(    
	 mslink  
	,mapid   
)
select  
	 mslink  
	,mapid   
from   GARLAND.UTSTOOUT;

commit;
alter rollback segment rb1   offline;


--	***************************************************
   
select 'UTSTOPIPE' " "  from dual;

	-- truncate table	GARLAND.UTSTOPIPE		REUSE STORAGE;
    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

   -- -- explain plan  set statement_id = 'UTSTOPIPE' for 
  
insert into GARLAND.UTSTOPIPE
(    
	 mslink  
	,mapid   
	,pipe_type   
	,general_desc  			-- 
	,general_comments			-- pipe desc
--	,pipe_size   
	,pipe_length   
	,quantity    
	,boxwide 
	,boxtall 
--	,year_blt    
--	,flag    
	,pipe_id 
	,map_grid    
	,map_quad    
	,pipe_num    
--	,pipe_length1  
--	,ats 
)
select  
	 mslink  
	,mapid   
	,pipe_type   
	,general_desc   
	,pipe_desc
--	,pipe_size   
	,pipe_length   
	,quantity    
	,boxwide 
	,boxtall 
--	,year_blt    
--	,flag    
	,pipe_id 
	,map_grid    
	,map_quad    
	,pipe_num    
--	,pipe_length1  
--	,ats 
from   GARLAND.UTSTOPIP;

commit;
alter rollback segment rb1   offline;


--	***************************************************
   
select 'UTSTOPOND' " "  from dual;

	-- truncate table	GARLAND.UTSTOPOND		REUSE STORAGE;
    
alter rollback segment rb1   online;
commit;
set transaction use rollback segment rb1;

   -- -- explain plan  set statement_id = 'UTSTOPOND' for 
  
insert into GARLAND.UTSTOPOND
(    
	 mslink  
	,mapid   
)
select  
	 mslink  
	,mapid   
from   GARLAND.UTSTOPON;

commit;
alter rollback segment rb1   offline;





COMMIT;

