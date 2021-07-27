
	select 'alter table JDEACUTIS.' || table_name || ' modify map_grid varchar2(3); '		" "
	from	tabs
	where table_name like 'UTWAT%'
	and	length(table_name) <= 10;




/*
------------------------------------------------------------------------
alter table JDEACUTIS.UTSANARW modify map_grid varchar2(3);                       
alter table JDEACUTIS.UTSANCLN modify map_grid varchar2(3);                       
alter table JDEACUTIS.UTSANFIT modify map_grid varchar2(3);                       
alter table JDEACUTIS.UTSANLAT modify map_grid varchar2(3);                       
alter table JDEACUTIS.UTSANLST modify map_grid varchar2(3);                       
alter table JDEACUTIS.UTSANMH modify map_grid varchar2(3);                        
alter table JDEACUTIS.UTSANPIP modify map_grid varchar2(3);             


                                                                        
------------------------------------------------------------------------
alter table JDEACUTIS.UTSTOHDWL modify map_grid varchar2(3);                      
alter table JDEACUTIS.UTSTOINL modify map_grid varchar2(3);                       
alter table JDEACUTIS.UTSTOJUN modify map_grid varchar2(3);                       
alter table JDEACUTIS.UTSTOMH modify map_grid varchar2(3);                        
alter table JDEACUTIS.UTSTOOCH modify map_grid varchar2(3);                       
alter table JDEACUTIS.UTSTOOJDEACUTIS.UT modify map_grid varchar2(3);                       
alter table JDEACUTIS.UTSTOPIP modify map_grid varchar2(3);                       
alter table JDEACUTIS.UTSTOPON modify map_grid varchar2(3);                       
          

                                                                        
------------------------------------------------------------------------
alter table JDEACUTIS.UTWATFIT modify map_grid varchar2(3);                       
alter table JDEACUTIS.UTWATHYD modify map_grid varchar2(3);                       
alter table JDEACUTIS.UTWATMTR modify map_grid varchar2(3);                       
alter table JDEACUTIS.UTWATPIP modify map_grid varchar2(3);                       
alter table JDEACUTIS.UTWATPLG modify map_grid varchar2(3);                       
alter table JDEACUTIS.UTWATPSTA modify map_grid varchar2(3);                      
alter table JDEACUTIS.UTWATTNK modify map_grid varchar2(3);                       
alter table JDEACUTIS.UTWATVLV modify map_grid varchar2(3);                       

*/