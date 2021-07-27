/*
	set echo off;
--	=========================================================================
--	Create CDRELPAR table
--	Create indexes on CDRELPAR

--	Move x,y coordinates from cdrelpar to cdreladr
--	Remove all unused columns from cdrelpar
--	=========================================================================

--	----------------
--	JOB FLOW SUMMARY
--	----------------

--	export & backup		cdrelpar

--	define x,y columns	in cdreladr
--	copy cdrelpar x,y		to cdreladr x,y

--	define cdrelpar view	on cdrelpar backup

--	drop				old cdrelpar
--	CREATE			new CDRELPAR

--	copy cdrelpar view 	to new cdrelpar
	
--	CREATE INDEXES		on new cdrelpar

--	=========================================================================
--	BACKUP CDRELPAR

--	Export	CDRELPAR

	@c:\deacutis\scripts\ora_dba\gis_backups.sql;
 
--	===========================================================================
	truncate table	garland.plan_table	reuse storage;

	explain plan set statement_id = 'coord'	into garland.plan_table	for
--	===========================================================================

update	garland.cdreladr			a
		set	( 	x_coord,	y_coord	)	=
(
		select	arcview_x,	arcview_y
		from		garland.cdrelpar	p
		where		p.parcel_id = a.parcel_id

		and	(	p.parcel_id, p.mslink	)	in
(
		select	parcel_id, min (mslink)
		from		garland.cdrelpar
		group by	parcel_id
)

);

--	===========================================================================
	commit;
--	alter rollback segment rb1 offline;

	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
	select * from garland.explain_analyze;

--	=========================================================================
--	DEFINE CDRELPAR VIEW

--	select view_name from user_views;

	create or replace view	temp_view	as
	select
 MSLINK                  
,MAPID                   
,PARCEL_ID               
,TAX_ACCT                
,SUBDIV_ID               
,COUNCIL_ID              
,POLICE_BEAT             
,ZIP_CODE                
,CODE_INSPECT_AREA       
,FIRE_DISTRICT           
	from	cdrelpar_copy;

--	=========================================================================
--	CREATE NEW CDRELPAR

--	drop table	cdrelpar;		--	C A U T I O N 	<<<<<==============

create table   GARLAND.CDRELPAR
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,PARCEL_ID                     VARCHAR2 (11) not null
,TAX_ACCT                      VARCHAR2 (17)
,SUBDIV_ID                     VARCHAR2 (5)
,COUNCIL_ID                    VARCHAR2 (1)
,POLICE_BEAT                   NUMBER   (3)
,ZIP_CODE                      VARCHAR2 (5)
,CODE_INSPECT_AREA             VARCHAR2 (2)
,FIRE_DISTRICT                 VARCHAR2 (1)
)

nologging
tablespace	gis_data
storage   (initial 6m next 1m pctincrease 0);

--	=========================================================================
--	LOAD NEW CDRELPAR

	truncate table	cdrelpar	reuse storage;

--	alter rollback segment rb1	online;
--	commit;
--	set transaction use rollback segment rb1;

	insert --+  append
	into		CDRELPAR
	select	all *
	from		TEMP_VIEW;

	commit;
--	alter rollback segment rb1	offline;

--	=========================================================================
--	CREATE CDRELPAR INDEXES

create index   GARLAND.CDRELPAR_MSLINK
       on      GARLAND.CDRELPAR
(
 MSLINK
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 4M next 1M   pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

--	=========================================================================

	drop index   GARLAND.CDRELPAR_MSLINK;

	alter table	garland.cdrelpar

	add		constraint	cdrelpar_unq_mslink

			unique	(mslink)

	using index
		tablespace	gisindx
		storage	( initial 100k  next 100k  pctincrease 0);

--	=========================================================================

	drop index	cdrelpar_pid;

	alter table	garland.cdrelpar
	add		constraint	cdrelpar_pkey
			primary	key	(parcel_id)

	using index
		tablespace	gisindx
		storage		( initial 100k  next 100k  pctincrease 0);

--	=========================================================================

	drop index	cdrelpar_pid_new;

	create index garland.cdrelpar_pid_new
		on	 garland.cdrelpar(parcel_id_new)
	nologging;

--	=========================================================================
	set echo on;


*/
