
     Drop   table    GARLAND.VERIZON_SBC_INFO              ;
     Create table    GARLAND.VERIZON_SBC_INFO              
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
          ,PARCEL_ID                     NUMBER    (22,0)
          ,ZIP_CODE                      NUMBER    (22,0)
          ,SOURCE                        VARCHAR2  (5)   
      )
      Tablespace  GIS_DATA      NOLOGGING      PCTFREE  10
      ;
