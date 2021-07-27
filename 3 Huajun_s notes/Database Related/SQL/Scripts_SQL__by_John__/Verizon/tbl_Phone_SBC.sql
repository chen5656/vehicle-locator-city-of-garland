	set echo off;


--   Drop   table    GARLAND.PHONE_SBC
     Create table    GARLAND.PHONE_SBC
     (                                                                         
           PHONE                         VARCHAR2  (10)
          ,STREETNUM                     VARCHAR2  (10)
          ,STREETPREFIX                  VARCHAR2  (2) 
          ,STREETNAME                    VARCHAR2  (20)
          ,STREETTYPE                    VARCHAR2  (4) 
          ,STREETSUFFIX                  VARCHAR2  (2) 
          ,UNITNUM                       VARCHAR2  (20)
          ,CITY                          VARCHAR2  (10)
          ,STATE                         VARCHAR2  (2) 
          ,CUSTOMER                      VARCHAR2  (40)
          ,MAIN                          VARCHAR2  (10)
          ,PARCEL_ID                     NUMBER    (07)
          ,ZIP_CODE                      NUMBER    (05)
      )
      Tablespace  GIS_DATA      NOLOGGING      PCTFREE  10
      ;
--	=========================================================================

	create index	garland.Phone_SBC_Phone
		on		garland.Phone_SBC(Phone)
	tablespace		gis_index
	nologging;

--	=========================================================================

	create index	garland.Phone_SBC_Parcel
		on		garland.Phone_SBC(Parcel_ID)
	tablespace		gis_index
	nologging;

--	=========================================================================
