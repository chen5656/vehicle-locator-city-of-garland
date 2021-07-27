--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	400;
set pagesize	9999;
-- alter session	set nls_date_format = 'yyyymmdd hh24:mi:ss';  
--	=====================================================================

      Drop   table    gis.A_PARCEL_POINT;
	Create table    gis.A_PARCEL_POINT
     (
           OBJECTID                      NUMBER    (10,0)
          ,PARCELID                      NUMBER    (10,0)
          ,COUNCIL_ID                    VARCHAR2  (01)
          ,ZIP_CODE                      VARCHAR2  (05)
          ,CODE_NUISANCE                 VARCHAR2  (02)
          ,CODE_RENTAL                   NUMBER    (04,0)
          ,CDBG                          NUMBER    (04,0)
          ,POLICE_BEAT                   NUMBER    (10,0)
          ,POLICE_DIST                   VARCHAR2  (02)
          ,FIRE_DIST                     NUMBER    (04,0)
          ,ANIMAL_CONTROL                VARCHAR2  (01)
          ,TAX_ACCT                      VARCHAR2  (17)
          ,SUBDIV_ID                     VARCHAR2  (05)
          ,ZONING                        VARCHAR2  (25)
          ,ZONING_SUP                    VARCHAR2  (25)
          ,LANDUSE                       VARCHAR2  (40)
          ,PARCEL_ID                     VARCHAR2  (11)
          ,POLYGON_OBJECTID              NUMBER    (10,0)
          ,REFER_ID                      NUMBER    (10,0)
          ,CREATED                       DATE
          ,MODIFIEDLAST                  DATE
          ,MODIFIEDBY                    VARCHAR2  (20)
          ,SHAPE                         NUMBER    (10,0)
      )
      Tablespace  SDE_DATA      NOLOGGING      PCTFREE  10
      ;
