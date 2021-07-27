	set echo off;

--   Drop   table    garland.GDS_VALUE;
     Create table    garland.GDS_VALUE
     (
          ACCOUNT                   VARCHAR2  (10),
          YEAR                      VARCHAR2  (04)
      )
      Tablespace  GIS_DATA      NOLOGGING      PCTFREE  10
      ;
                                                            

	create index garland.GDS_VALUE_ACCOUNT
		on	 garland.GDS_VALUE(ACCOUNT)
      Tablespace  GIS_INDEX      NOLOGGING      PCTFREE  5;