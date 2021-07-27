	set echo	off
	set timing	off;

--	===========================================================================
--	truncate table	garland.plan_table	reuse storage;
--	insert into		garland.plan_table (object_name,object_owner) values ( '' , '' );
--	analyze  table	garland.		compute statistics;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	explain plan set statement_id =	'xxx'		into garland.plan_table	for
--	===========================================================================

	update garland.cdreladr		a
	set	parcel_id  =
(
	select	decode ( mslink,

      9535,   '5201787.000',       
     10311,  '0301088.000',      
     41434,  '0600418.000',      
     45036,  '2000433.000',       
    52066,   '2700146.000',         
     60872,  '1200613.000',        
     60940,  '1200649.000',        
      4383,   '4001606.000',         
      6804,   '1000821.000',         
     12565,  '4100932.000',        
     23567,  '4500535.000',        
     31196,  '2700995.000',       
     36260,  '2301503.000',        
     42355,  '2301536.000',        
     52424,  '4500528.000',        
    27752,   '7000800.000',  

	b.parcel_id	)

	from garland.cdreladr		b
	where b.mslink = a.mslink
)

	where	mslink	in
(
      9535, 
     10311,
     41434,
     45036,
    52066, 
     60872,
     60940,
      4383, 
      6804, 
     12565,
     23567,
     31196,
     36260,
     42355,
     52424,
    27752 
);
       
--	===========================================================================

--	select * from garland.explain_plan;
--	select * from garland.explain_remote;

--	select * from garland.explain_indexed;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_constraint;
--	select * from garland.explain_column;

--	select * from garland.explains_indexed;
--	select * from garland.explains_table;
--	select * from garland.explains_index;
--	select * from garland.explains_constraint;
--	select * from garland.explains_column;

--	select * from garland.explain_analyze;
--	select * from garland.explains_analyze;

	rollback;
	commit;
	alter rollback segment rb1 offline;

--	===========================================================================

