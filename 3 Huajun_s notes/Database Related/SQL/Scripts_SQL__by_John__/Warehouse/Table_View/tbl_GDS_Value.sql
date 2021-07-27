

Drop   table GARLAND.GDS_VALUE;
Create table GARLAND.GDS_VALUE
(
  ACCOUNT                           VARCHAR2(10)
 ,YEAR                              NUMBER  (4)
 ,ENTITY					VARCHAR2(4)
 ,VALUE_CODE				VARCHAR2(2)
 ,VALUE_AMOUNT				NUMBER (12,2)
) tablespace GIS_DATA  nologging
  ;


