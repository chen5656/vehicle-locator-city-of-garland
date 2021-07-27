

OWNER                TABLE_NAME                     SEQ COLUMN_NAME                    DATA_TYPE  LENGTH PRECIS SCALE
-------------------- ------------------------------ --- ------------------------------ ---------- ------ ------ ------
GIS                  PARCEL_POINT                     1 OBJECTID                       NUMBER         22             0
GIS                  PARCEL_POINT                     2 PARCELID                       NUMBER         22     10      0
GIS                  PARCEL_POINT                     3 COUNCIL_ID                     VARCHAR2        1
GIS                  PARCEL_POINT                     4 ZIP_CODE                       VARCHAR2        5
GIS                  PARCEL_POINT                     5 CODE_NUISANCE                  VARCHAR2        2
GIS                  PARCEL_POINT                     6 CODE_RENTAL                    NUMBER         22      4      0
GIS                  PARCEL_POINT                     7 CDBG                           NUMBER         22      4      0
GIS                  PARCEL_POINT                     8 POLICE_BEAT                    NUMBER         22     10      0
GIS                  PARCEL_POINT                     9 POLICE_DIST                    VARCHAR2        2
GIS                  PARCEL_POINT                    10 FIRE_DIST                      NUMBER         22      4      0
GIS                  PARCEL_POINT                    11 ANIMAL_CONTROL                 VARCHAR2        1
GIS                  PARCEL_POINT                    12 TAX_ACCT                       VARCHAR2       17
GIS                  PARCEL_POINT                    13 SUBDIV_ID                      VARCHAR2        5
GIS                  PARCEL_POINT                    14 ZONING                         VARCHAR2       25
GIS                  PARCEL_POINT                    15 ZONING_SUP                     VARCHAR2       25
GIS                  PARCEL_POINT                    16 LANDUSE                        VARCHAR2       40
GIS                  PARCEL_POINT                    17 PARCEL_ID                      VARCHAR2       11
GIS                  PARCEL_POINT                    18 POLYGON_OBJECTID               NUMBER         22     10      0
GIS                  PARCEL_POINT                    19 REFER_ID                       NUMBER         22     10      0
GIS                  PARCEL_POINT                    20 CREATED                        DATE            7
GIS                  PARCEL_POINT                    21 MODIFIEDLAST                   DATE            7
GIS                  PARCEL_POINT                    22 MODIFIEDBY                     VARCHAR2       20
GIS                  PARCEL_POINT                    23 SHAPE                          NUMBER         22             0



OWNER                TABLE_NAME                     SEQ COLUMN_NAME                    DATA_TYPE  LENGTH PRECIS SCALE
-------------------- ------------------------------ --- ------------------------------ ---------- ------ ------ ------
GARLAND              CODE_INSPECTOR                   1 INSPECT_AREA                   VARCHAR2        2
GARLAND              CODE_INSPECTOR                   2 INSPECTOR                      VARCHAR2       20
GARLAND              CODE_INSPECTOR                   3 INSPECTOR_ID                   VARCHAR2        3
GARLAND              CODE_INSPECTOR                   4 PHONE                          VARCHAR2       15
GARLAND              CODE_INSPECTOR                   5 APT_COUNT                      NUMBER         22




OWNER                TABLE_NAME                     SEQ COLUMN_NAME                    DATA_TYPE  LENGTH PRECIS SCALE
-------------------- ------------------------------ --- ------------------------------ ---------- ------ ------ ------
GARLAND              CODE_DISTRICT                    1 PARCEL_ID                      NUMBER         22      7      0
GARLAND              CODE_DISTRICT                    2 NUISANCE_DISTRICT              NUMBER         22      2      0
GARLAND              CODE_DISTRICT                    3 NUISANCE_INSPECTOR             VARCHAR2       20
GARLAND              CODE_DISTRICT                    4 NUISANCE_PHONE                 VARCHAR2       15
GARLAND              CODE_DISTRICT                    5 RENTAL_DISTRICT                NUMBER         22      2      0
GARLAND              CODE_DISTRICT                    6 RENTAL_INSPECTOR               VARCHAR2       20
GARLAND              CODE_DISTRICT                    7 RENTAL_PHONE                   VARCHAR2       15
GARLAND              CODE_DISTRICT                    8 IS_RENTAL                      NUMBER         22      1      0
GARLAND              CODE_DISTRICT                    9 COUNCIL_ID                     NUMBER         22      1      0
GARLAND              CODE_DISTRICT                   10 POLICE_BEAT                    NUMBER         22      3      0
GARLAND              CODE_DISTRICT                   11 ZIP_CODE                       NUMBER         22      5      0
GARLAND              CODE_DISTRICT                   12 PARCEL_ID_OLD                  VARCHAR2       11


OWNER                TABLE_NAME                     SEQ COLUMN_NAME                    DATA_TYPE  LENGTH PRECIS SCALE
-------------------- ------------------------------ --- ------------------------------ ---------- ------ ------ ------
GARLAND              RENTAL_PROPERTIES                1 OBJECTID                       NUMBER         22     38      0
GARLAND              RENTAL_PROPERTIES                2 ADDR_ID                        NUMBER         22     38      0
GARLAND              RENTAL_PROPERTIES                3 PARCEL_ID                      NUMBER         22     38      0
GARLAND              RENTAL_PROPERTIES                4 ADDRESS                        VARCHAR2       50
GARLAND              RENTAL_PROPERTIES                5 ZIP                            VARCHAR2       10
GARLAND              RENTAL_PROPERTIES                6 RENT_DIST                      NUMBER         22      9      0
GARLAND              RENTAL_PROPERTIES                7 RENT_INSP                      VARCHAR2       20
GARLAND              RENTAL_PROPERTIES                8 OWNER_NAME                     VARCHAR2      100
GARLAND              RENTAL_PROPERTIES                9 OWNER_HOME_PHONE               VARCHAR2       20
GARLAND              RENTAL_PROPERTIES               10 OWNER_WORK_PHONE               VARCHAR2       20
GARLAND              RENTAL_PROPERTIES               11 OWNER_MOBILE_PHONE             VARCHAR2       20
GARLAND              RENTAL_PROPERTIES               12 ACTIVE                         CHAR            2
GARLAND              RENTAL_PROPERTIES               13 INSERTDATE                     DATE            7
GARLAND              RENTAL_PROPERTIES               14 SHAPE                          SDO_GEOMET      1
GARLAND              RENTAL_PROPERTIES               15 X                              NUMBER         22     38      8
GARLAND              RENTAL_PROPERTIES               16 Y                              NUMBER         22     38      8

