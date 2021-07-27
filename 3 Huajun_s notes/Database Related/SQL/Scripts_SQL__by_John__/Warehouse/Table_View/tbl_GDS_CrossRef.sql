	set echo	off;
--	===========================================================================

--	drop   table	garland.GDS_CrossRef;

	create table	garland.GDS_CrossRef
(
	GDS_Acct		varchar2(10),
	COG_Acct		varchar2(10),
	DCAD_Acct		varchar2(20)
)
	tablespace		gis_data
	storage		(initial 1m  next 1m  pctincrease 0)
	nologging;

--	===========================================================================

	create index	garland.GDS_CrossRef_Acct
		on		garland.GDS_CrossRef(GDS_Acct)

	tablespace	gis_indx
	nologging;

--	===========================================================================
