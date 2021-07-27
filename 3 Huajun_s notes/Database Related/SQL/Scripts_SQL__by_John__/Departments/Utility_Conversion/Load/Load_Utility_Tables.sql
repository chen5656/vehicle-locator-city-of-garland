--	=============================================================
--	Execute Generated Bulk Insert/Update Script
--	=============================================================
--	----------------------------------------------------------------------------------

	alter rollback segment rb1	online;
	commit;
	set transaction use rollback segment rb1;
                                                                                                    
----------------------------------------------------------------------------------------------------

	insert /*+ append */  into garland.UTSANCLEN  select * from jdeacutis.UTSANCLEN;                   
	insert /*+ append */  into garland.UTSANLATR  select * from jdeacutis.UTSANLATR;                   
	insert /*+ append */  into garland.UTSANLIFT  select * from jdeacutis.UTSANLIFT;                   
	insert /*+ append */  into garland.UTSANMANH  select * from jdeacutis.UTSANMANH;                   
	insert /*+ append */  into garland.UTSANPIPE  select * from jdeacutis.UTSANPIPE;                   
	insert /*+ append */  into garland.UTSANPLUG  select * from jdeacutis.UTSANPLUG;                   

	insert /*+ append */  into garland.UTSTOCHAN  select * from jdeacutis.UTSTOCHAN;                   
	insert /*+ append */  into garland.UTSTOHWAL  select * from jdeacutis.UTSTOHWAL;                   
	insert /*+ append */  into garland.UTSTOINLT  select * from jdeacutis.UTSTOINLT;                   
	insert /*+ append */  into garland.UTSTOJUNC  select * from jdeacutis.UTSTOJUNC;                   
	insert /*+ append */  into garland.UTSTOMANH  select * from jdeacutis.UTSTOMANH;                   
	insert /*+ append */  into garland.UTSTOOUTF  select * from jdeacutis.UTSTOOUTF;                   
	insert /*+ append */  into garland.UTSTOPIPE  select * from jdeacutis.UTSTOPIPE;                   
	insert /*+ append */  into garland.UTSTOPOND  select * from jdeacutis.UTSTOPOND;                   

	insert /*+ append */  into garland.UTWATFITT  select * from jdeacutis.UTWATFITT;                   
	insert /*+ append */  into garland.UTWATHYDR  select * from jdeacutis.UTWATHYDR;                   
	insert /*+ append */  into garland.UTWATMETR  select * from jdeacutis.UTWATMETR;                   
	insert /*+ append */  into garland.UTWATPIPE  select * from jdeacutis.UTWATPIPE;                   
	insert /*+ append */  into garland.UTWATPUMP  select * from jdeacutis.UTWATPUMP;                   
	insert /*+ append */  into garland.UTWATTANK  select * from jdeacutis.UTWATTANK;                   
	insert /*+ append */  into garland.UTWATVALV  select * from jdeacutis.UTWATVALV;                   

--	----------------------------------------------------------------------------------

--	rollback;
	commit;
	alter rollback segment rb1	offline;

--	=============================================================


