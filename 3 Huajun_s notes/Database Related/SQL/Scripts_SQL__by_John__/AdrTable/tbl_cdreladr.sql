
DESC GARLAND.CDRELADR

Column Name                    Null?    Type
------------------------------ -------- ----
PARCEL_ID                               VARCHAR2(11)
ADDR_ID                                 NUMBER(8)
ADDR_NUM                                NUMBER(6)
ADDR_PFX                                VARCHAR2(2)
ADDR_NAME                               VARCHAR2(20)
ADDR_TYPE                               VARCHAR2(4)
ADDR_SFX                                VARCHAR2(2)
ADDR_BLDG                               VARCHAR2(20)
UNIT_TYPE                               VARCHAR2(20)
UNIT_NUM                                VARCHAR2(20)
ZIP_CODE                                NUMBER(5)
ZIP_PLUS                                NUMBER(4)
ADDR_STATUS                             VARCHAR2(3)
MAP_GRID                                NUMBER(5)
UNIT_AUX                                VARCHAR2(20)
MSLINK                                  NUMBER(6)
MAPID                                   NUMBER(4)
PRIVATE_STR                             VARCHAR2(3)
X_COORD                                 NUMBER(38,8)
Y_COORD                                 NUMBER(38,8)
TAX_KEY                                 NUMBER(8)
UMS_KEY                                 NUMBER(8)
PARCELID                                NUMBER(8)
ADDRESS_LABEL                           VARCHAR2(50)




Owner      Table                                 ** INDEX     COLUMN **                 Type         Null
---------- -------------------- ------------------------- --- ------------------------- ------------ ----
GARLAND    CDRELADR             CDRELADR_ADDRID             1 ADDR_ID                   NUMBER       Y   
GARLAND    CDRELADR             CDRELADR_MSLINK             1 MSLINK                    NUMBER       Y   
GARLAND    CDRELADR             CDRELADR_NAME_NUM           1 ADDR_NAME                 VARCHAR2     Y   
GARLAND    CDRELADR             CDRELADR_NAME_NUM           2 ADDR_NUM                  NUMBER       Y   
GARLAND    CDRELADR             CDRELADR_PARCELID           1 PARCELID                  NUMBER       Y   
GARLAND    CDRELADR             CDRELADR_PARCEL_ID          1 PARCEL_ID                 VARCHAR2     Y   
