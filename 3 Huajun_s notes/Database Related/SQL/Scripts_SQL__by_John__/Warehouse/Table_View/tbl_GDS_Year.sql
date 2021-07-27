


  drop   table GARLAND.GDS_YEAR;
  create table GARLAND.GDS_YEAR
(
  ACCOUNT                           VARCHAR2(10)
 ,YEAR                              NUMBER  (4)
 ,ENTITY					VARCHAR2(4)
 ,TAX_FLAG					VARCHAR2(1)
 ,NET_TAXABLE_VALUE			NUMBER (10)
 ,ACCT_TYPE                         VARCHAR2(1)
 ,BASE_TAX					NUMBER (12,2)
) tablespace GIS_DATA  nologging
  ;


	create index GARLAND.GDS_YEAR_ACCOUNT
		on	 GARLAND.GDS_YEAR(ACCOUNT)
	tablespace gis_index
	nologging;

