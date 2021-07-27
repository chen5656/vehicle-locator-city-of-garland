----------------------------------------------------------------------------------------------------------

	create or replace view		garland.temp_view  

		(		new_table,  old_table,  new_object,  old_object,   start_seq,  id_prefix,  id_suffix	)
	as	select	item01,     item02,     item03,      item04,  item05,     item06,     item07

		from		 garland.GIS_Objects;

----------------------------------------------------------------------------------------------------------
		
	truncate table	garland.GIS_Objects	reuse storage;

----------------------------------------------------------------------------------------------------------
    
	insert into garland.GIS_Objects  (item01, item02, item03, item04, item05, item06, item07)  values 
	( 'UTSANFITT','UTSANFIT','PLUG','FITTING','0','SS','JC');	
    
    
	insert into garland.GIS_Objects  (item01, item02, item03, item04, item05, item06, item07)  values 
	( 'UTSANLATR','UTSANLAT','LATERAL','LATERAL','0','SS','LA');
    
	insert into garland.GIS_Objects  (item01, item02, item03, item04, item05, item06, item07)  values 
	( 'UTSANLIFT','UTSANLST','LIFTSTA','LIFTSTA','0','SS','LS');
    
	insert into garland.GIS_Objects  (item01, item02, item03, item04, item05, item06, item07)  values 
	( 'UTSANMANH','UTSANMH','MANHOLE','MANHOLE','0','SS','MH');
  
	insert into garland.GIS_Objects  (item01, item02, item03, item04, item05, item06, item07)  values 
	( 'UTSANPIPE','UTSANPIP','PIPE','PIPE','0','SS','PI');

-----------------------------------------------------------------------------------------------------------------------------------------------
    
	insert into garland.GIS_Objects  (item01, item02, item03, item04, item05, item06, item07)  values 
	( 'UTSTOHWAL','UTSTOHDWL','HEADWALL','','0','ST','HW');		-- ****
  
	insert into garland.GIS_Objects  (item01, item02, item03, item04, item05, item06, item07)  values 
	( 'UTSTOINLT','UTSTOINL','INLET','INLET','0','ST','IN');
    
	insert into garland.GIS_Objects  (item01, item02, item03, item04, item05, item06, item07)  values 
	( 'UTSTOJUNC','UTSTOJUN','','JUNC','0','ST','JC');			-- ****
    
	insert into garland.GIS_Objects  (item01, item02, item03, item04, item05, item06, item07)  values 
	( 'UTSTOMANH','UTSTOMH','MANHOLE','','0','ST','MH');
  
	insert into garland.GIS_Objects  (item01, item02, item03, item04, item05, item06, item07)  values 
	( 'UTSTOCHAN','UTSTOOCH','CHANNEL','','0','ST','IC');		-- ????
    
	insert into garland.GIS_Objects  (item01, item02, item03, item04, item05, item06, item07)  values 
	( 'UTSTOOUTF','UTSTOOUT','OUTFALL','','0','ST','OF');			-- ****
    
	insert into garland.GIS_Objects  (item01, item02, item03, item04, item05, item06, item07)  values 
	( 'UTSTOPIPE','UTSTOPIP','PIPE','PIPE','0','ST','PI');
    
	insert into garland.GIS_Objects  (item01, item02, item03, item04, item05, item06, item07)  values 
	( 'UTSTOPOND','UTSTOPON','POND','','0','ST','PO');		
    
-----------------------------------------------------------------------------------------------------------------------------------------------
    
	insert into garland.GIS_Objects  (item01, item02, item03, item04, item05, item06, item07)  values 
	( 'UTWATFITT','UTWATFIT','FITTING','','0','WT','JC');
    
	insert into garland.GIS_Objects  (item01, item02, item03, item04, item05, item06, item07)  values 
	( 'UTWATHYDR','UTWATHYD','HYDRANT','HYDRANT','0','WT','FH');
    
	insert into garland.GIS_Objects  (item01, item02, item03, item04, item05, item06, item07)  values 
	( 'UTWATMETR','UTWATMTR','METER','','0','WT','MT');		-- ****
    
	insert into garland.GIS_Objects  (item01, item02, item03, item04, item05, item06, item07)  values 
	( 'UTWATPIPE','UTWATPIP','PIPE','PIPE','0','WT','PI');
    
	insert into garland.GIS_Objects  (item01, item02, item03, item04, item05, item06, item07)  values 
	( 'UTWATPUMP','UTWATPSTA','PUMPSTA','PUMPSTA','0','WT','PS');
  
	insert into garland.GIS_Objects  (item01, item02, item03, item04, item05, item06, item07)  values 
	( 'UTWATTANK','UTWATTNK','TANK','TANK','0','WT','GS');		-- ????
    
	insert into garland.GIS_Objects  (item01, item02, item03, item04, item05, item06, item07)  values 
	( 'UTWATVALV','UTWATVLV','VALVE','VALVE','0','WT','VA');
    
----------------------------------------------------------------------------------------------------------

	commit;
   
----------------------------------------------------------------------------------------------------------


