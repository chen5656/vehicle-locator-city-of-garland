
SQLWKS> 	desc ADDRESS_UNIT;                  
Column Name                    Null?    Type
------------------------------ -------- ----
ADDR_NUM                       NOT NULL NUMBER
ADDR_PFX                       NOT NULL VARCHAR2(2)
ADDR_NAME                      NOT NULL VARCHAR2(20)
ADDR_TYPE                      NOT NULL VARCHAR2(4)
ADDR_SFX                       NOT NULL VARCHAR2(2)
ADDR_BLDG1                     NOT NULL VARCHAR2(10)
ADDR_UNIT1                     NOT NULL VARCHAR2(10)
ADDR_BLDG2                     NOT NULL VARCHAR2(10)
ADDR_UNIT2                     NOT NULL VARCHAR2(10)
X_COORD                                 NUMBER
Y_COORD                                 NUMBER
PARCEL_ID                               VARCHAR2(11)
SQLWKS> 	desc ADDRVRFY;                      
Column Name                    Null?    Type
------------------------------ -------- ----
ADDRESS_NAME                   NOT NULL VARCHAR2(40)
ADDRESS_TYPE                            VARCHAR2(4)
ADDRESS_PREFIX                          VARCHAR2(2)
ADDRESS_NUMBER                 NOT NULL NUMBER(8)
ADDRESS_SUFFIX                          VARCHAR2(2)
ADDRESS_SUPPL#                          VARCHAR2(6)
ADDRESS_SULLP_TYPE                      VARCHAR2(6)
ZIP_CODE                                VARCHAR2(5)
TEN_CODE                                VARCHAR2(4)
COUNCIL_DISTRICT                        VARCHAR2(1)
POLICE_BEAT                             VARCHAR2(3)
OWNER_NAME                              VARCHAR2(34)
OWNER_MAILING_ADDR                      VARCHAR2(34)
OWNER_CITY_ST_ZIP                       VARCHAR2(26)
COG_TAX_ID                     NOT NULL VARCHAR2(13)
LOT                                     VARCHAR2(3)
BLOCK                                   VARCHAR2(3)
LEGAL_DESCRIPTION                       VARCHAR2(118)
OCCUPANT_NAME                           VARCHAR2(25)
OCCUPANT_SEX                            VARCHAR2(1)
OCCUPANT_DL#                            VARCHAR2(13)
OCCUPANT_SSN                            VARCHAR2(11)
OCCUPANT_DOB                   NOT NULL DATE
CITY_SWITCH                             VARCHAR2(1)
SEQUENCE                       NOT NULL NUMBER(8)
INSPECTOR                               VARCHAR2(3)
SQLWKS> 	desc ADRALIAS;                      
Column Name                    Null?    Type
------------------------------ -------- ----
ALIAS_PFX                      NOT NULL VARCHAR2(10)
ALIAS_NAME                     NOT NULL VARCHAR2(30)
ALIAS_TYPE                     NOT NULL VARCHAR2(10)
ALIAS_SFX                      NOT NULL VARCHAR2(10)
ALIAS_LO                       NOT NULL NUMBER
ALIAS_HI                                NUMBER
ADDR_MIN                                NUMBER
ADDR_PFX                                VARCHAR2(2)
ADDR_NAME                               VARCHAR2(30)
ADDR_TYPE                               VARCHAR2(4)
ADDR_SFX                                VARCHAR2(2)
ALIAS_HOW                               VARCHAR2(8)
ALIAS_REDUCED                           VARCHAR2(30)
ALIAS_COMPACT                           VARCHAR2(30)
ALIAS_COMPRESS                          VARCHAR2(30)
SQLWKS> 	desc ADRALIEN;                      
Column Name                    Null?    Type
------------------------------ -------- ----
ALIAS_PFX                      NOT NULL VARCHAR2(2)
ALIAS_NAME                     NOT NULL VARCHAR2(40)
ALIAS_TYPE                     NOT NULL VARCHAR2(4)
ALIAS_SFX                      NOT NULL VARCHAR2(2)
ALIAS_LO                       NOT NULL NUMBER
ALIAS_HI                                NUMBER
ADDR_MIN                                NUMBER
ADDR_PFX                                VARCHAR2(2)
ADDR_NAME                               VARCHAR2(20)
ADDR_TYPE                               VARCHAR2(4)
ADDR_SFX                                VARCHAR2(2)
ALIAS_HOW                               VARCHAR2(5)
SQLWKS> 	desc ADRALTER;                      
Column Name                    Null?    Type
------------------------------ -------- ----
FLAG1                                   VARCHAR2(5)
PFX1                                    VARCHAR2(10)
NAME1                                   VARCHAR2(40)
TYPE1                                   VARCHAR2(10)
SFX1                                    VARCHAR2(10)
FLAG2                                   VARCHAR2(5)
PFX2                                    VARCHAR2(10)
NAME2                                   VARCHAR2(40)
TYPE2                                   VARCHAR2(10)
SFX2                                    VARCHAR2(10)
FLAG3                                   VARCHAR2(5)
PFX3                                    VARCHAR2(10)
NAME3                                   VARCHAR2(40)
TYPE3                                   VARCHAR2(10)
SFX3                                    VARCHAR2(10)
LO_RANGE                                VARCHAR2(6)
HI_RANGE                                VARCHAR2(6)
NOTES                                   VARCHAR2(40)
SQLWKS> 	desc ADRENDING;                     
Column Name                    Null?    Type
------------------------------ -------- ----
NAME                                    VARCHAR2(10)
NAME_TAIL                               VARCHAR2(3)
SQLWKS> 	desc ADRGAP;                        
Column Name                    Null?    Type
------------------------------ -------- ----
ADDR_NUM                                NUMBER(6)
ADDR_PFX                                VARCHAR2(2)
ADDR_NAME                               VARCHAR2(20)
ADDR_TYPE                               VARCHAR2(4)
ADDR_SFX                                VARCHAR2(2)
SQLWKS> 	desc ADRITEM;                       
Column Name                    Null?    Type
------------------------------ -------- ----
CLASS                                   VARCHAR2(1)
POSSIBLE                                VARCHAR2(10)
STANDARD                                VARCHAR2(5)
NAME                                    VARCHAR2(20)
SQLWKS> 	desc ADRNAME;                       
Column Name                    Null?    Type
------------------------------ -------- ----
ADDR_NAME                      NOT NULL VARCHAR2(20)
ADDR_COMPRESS                           VARCHAR2(20)
ADDR_COMPACT                            VARCHAR2(20)
ADDR_REDUCED                            VARCHAR2(20)
ADDR_ENDING                             VARCHAR2(20)
ADDR_SOUNDEX                            VARCHAR2(4)
ADDR_PERMUTE                            NUMBER
DATE_CREATED                            DATE
SQLWKS> 	desc ADRPERMUTE;                    
Column Name                    Null?    Type
------------------------------ -------- ----
ADDR_NUM                                NUMBER(6)
ADDR_PFX                                VARCHAR2(2)
ADDR_NAME                               VARCHAR2(20)
ADDR_TYPE                               VARCHAR2(4)
ADDR_SFX                                VARCHAR2(2)
ADDR_PERMUTE                            NUMBER
SQLWKS> 	desc ADRRESULT_CODEADDR;            
Column Name                    Null?    Type
------------------------------ -------- ----
ADDR_NUM                                NUMBER
ADDR_PFX                                VARCHAR2(10)
ADDR_NAME                               VARCHAR2(40)
ADDR_TYPE                               VARCHAR2(4)
ADDR_SFX                                VARCHAR2(10)
ADDR_CODE                               VARCHAR2(10)
ADDR_UNIT                               VARCHAR2(10)
VERIFY_CODE                             NUMBER(2)
DO_PARSE                                VARCHAR2(6)
DO_ALIAS                                VARCHAR2(10)
DO_NAME                                 VARCHAR2(1)
DO_QUAL                                 VARCHAR2(30)
PARCEL_ID                               VARCHAR2(12)
SEGMENT_ID                              NUMBER
OLD_PFX                                 VARCHAR2(2)
OLD_NAME                                VARCHAR2(40)
OLD_TYPE                                VARCHAR2(4)
OLD_SFX                                 VARCHAR2(2)
OLD_UNIT                                VARCHAR2(5)
REC_KEY                                 VARCHAR2(256)
REC_SEQ                                 NUMBER
REC_ROWID                               ROWID
OLD_CODE                                VARCHAR2(5)
APP_PFX                                 VARCHAR2(10)
APP_NAME                                VARCHAR2(80)
APP_TYPE                                VARCHAR2(10)
APP_SFX                                 VARCHAR2(10)
APP_CODE                                VARCHAR2(10)
APP_UNIT                                VARCHAR2(10)
REGION_ID                               VARCHAR2(5)
SQLWKS> 	desc ADRRESULT_EXTRACT;             
Column Name                    Null?    Type
------------------------------ -------- ----
ADDR_NUM                                VARCHAR2(20)
ADDR_PFX                                VARCHAR2(80)
ADDR_NAME                               VARCHAR2(80)
ADDR_TYPE                               VARCHAR2(80)
ADDR_SFX                                VARCHAR2(80)
ADDR_CODE1                              VARCHAR2(80)
ADDR_UNIT1                              VARCHAR2(80)
ADDR_CODE2                              VARCHAR2(80)
ADDR_UNIT2                              VARCHAR2(80)
VERIFY_CODE                             VARCHAR2(2)
DO_PARSE                                VARCHAR2(30)
DO_ALIAS                                VARCHAR2(5)
DO_NAME                                 VARCHAR2(1)
DO_QUAL                                 VARCHAR2(20)
REC_SEQ                                 NUMBER
REC_ROWID                               ROWID
REC_KEY                                 VARCHAR2(20)
PARCEL_ID                               VARCHAR2(12)
SEGMENT_ID                              VARCHAR2(5)
FORM_PFX                                VARCHAR2(80)
FORM_NAME                               VARCHAR2(80)
FORM_TYPE                               VARCHAR2(80)
FORM_SFX                                VARCHAR2(80)
FORM_CODE1                              VARCHAR2(6)
FORM_UNIT1                              VARCHAR2(80)
FORM_CODE2                              VARCHAR2(6)
FORM_UNIT2                              VARCHAR2(80)
APPL_PFX                                VARCHAR2(80)
APPL_NAME                               VARCHAR2(80)
APPL_TYPE                               VARCHAR2(80)
APPL_SFX                                VARCHAR2(80)
APPL_CODE1                              VARCHAR2(10)
APPL_UNIT1                              VARCHAR2(80)
APPL_CODE2                              VARCHAR2(10)
APPL_UNIT2                              VARCHAR2(80)
APPL_NUM                                VARCHAR2(20)
SQLWKS> 	desc ADRRESULT_INPUT;               
Column Name                    Null?    Type
------------------------------ -------- ----
ADDR_NUM                                VARCHAR2(20)
ADDR_PFX                                VARCHAR2(80)
ADDR_NAME                               VARCHAR2(80)
ADDR_TYPE                               VARCHAR2(80)
ADDR_SFX                                VARCHAR2(80)
ADDR_CODE1                              VARCHAR2(80)
ADDR_UNIT1                              VARCHAR2(80)
ADDR_CODE2                              VARCHAR2(80)
ADDR_UNIT2                              VARCHAR2(80)
VERIFY_CODE                             VARCHAR2(2)
DO_PARSE                                VARCHAR2(30)
DO_ALIAS                                VARCHAR2(5)
DO_NAME                                 VARCHAR2(1)
DO_QUAL                                 VARCHAR2(20)
REC_SEQ                                 NUMBER
REC_ROWID                               ROWID
REC_KEY                                 VARCHAR2(20)
PARCEL_ID                               VARCHAR2(12)
SEGMENT_ID                              VARCHAR2(5)
FORM_PFX                                VARCHAR2(80)
FORM_NAME                               VARCHAR2(80)
FORM_TYPE                               VARCHAR2(80)
FORM_SFX                                VARCHAR2(80)
FORM_CODE1                              VARCHAR2(80)
FORM_UNIT1                              VARCHAR2(80)
FORM_CODE2                              VARCHAR2(80)
FORM_UNIT2                              VARCHAR2(80)
APPL_PFX                                VARCHAR2(80)
APPL_NAME                               VARCHAR2(80)
APPL_TYPE                               VARCHAR2(80)
APPL_SFX                                VARCHAR2(80)
APPL_CODE1                              VARCHAR2(80)
APPL_UNIT1                              VARCHAR2(80)
APPL_CODE2                              VARCHAR2(80)
APPL_UNIT2                              VARCHAR2(80)
APPL_NUM                                VARCHAR2(20)
SQLWKS> 	desc ADRRESULT_UMS_LOCATION;        
Column Name                    Null?    Type
------------------------------ -------- ----
ADDR_NUM                                VARCHAR2(20)
ADDR_PFX                                VARCHAR2(10)
ADDR_NAME                               VARCHAR2(40)
ADDR_TYPE                               VARCHAR2(10)
ADDR_SFX                                VARCHAR2(10)
ADDR_CODE1                              VARCHAR2(10)
ADDR_UNIT1                              VARCHAR2(20)
ADDR_CODE2                              VARCHAR2(10)
ADDR_UNIT2                              VARCHAR2(20)
VERIFY_CODE                             VARCHAR2(2)
DO_PARSE                                VARCHAR2(30)
DO_ALIAS                                VARCHAR2(5)
DO_NAME                                 VARCHAR2(1)
DO_QUAL                                 VARCHAR2(20)
REC_SEQ                                 NUMBER
REC_ROWID                               ROWID
REC_KEY                                 VARCHAR2(20)
PARCEL_ID                               VARCHAR2(12)
SEGMENT_ID                              VARCHAR2(5)
FORM_PFX                                VARCHAR2(2)
FORM_NAME                               VARCHAR2(30)
FORM_TYPE                               VARCHAR2(4)
FORM_SFX                                VARCHAR2(2)
FORM_CODE1                              VARCHAR2(6)
FORM_UNIT1                              VARCHAR2(20)
FORM_CODE2                              VARCHAR2(6)
FORM_UNIT2                              VARCHAR2(20)
APPL_PFX                                VARCHAR2(10)
APPL_NAME                               VARCHAR2(80)
APPL_TYPE                               VARCHAR2(10)
APPL_SFX                                VARCHAR2(10)
APPL_CODE1                              VARCHAR2(10)
APPL_UNIT1                              VARCHAR2(20)
APPL_CODE2                              VARCHAR2(10)
APPL_UNIT2                              VARCHAR2(20)
APPL_NUM                                VARCHAR2(20)
SQLWKS> 	desc ADRRESULT_WATER;               
Column Name                    Null?    Type
------------------------------ -------- ----
ADDR_NUM                                VARCHAR2(20)
ADDR_PFX                                VARCHAR2(80)
ADDR_NAME                               VARCHAR2(80)
ADDR_TYPE                               VARCHAR2(80)
ADDR_SFX                                VARCHAR2(80)
ADDR_CODE1                              VARCHAR2(80)
ADDR_UNIT1                              VARCHAR2(80)
ADDR_CODE2                              VARCHAR2(80)
ADDR_UNIT2                              VARCHAR2(80)
VERIFY_CODE                             VARCHAR2(2)
DO_PARSE                                VARCHAR2(30)
DO_ALIAS                                VARCHAR2(5)
DO_NAME                                 VARCHAR2(1)
DO_QUAL                                 VARCHAR2(20)
REC_SEQ                                 NUMBER
REC_ROWID                               ROWID
REC_KEY                                 VARCHAR2(20)
PARCEL_ID                               VARCHAR2(12)
SEGMENT_ID                              VARCHAR2(5)
FORM_PFX                                VARCHAR2(80)
FORM_NAME                               VARCHAR2(80)
FORM_TYPE                               VARCHAR2(80)
FORM_SFX                                VARCHAR2(80)
FORM_CODE1                              VARCHAR2(80)
FORM_UNIT1                              VARCHAR2(80)
FORM_CODE2                              VARCHAR2(80)
FORM_UNIT2                              VARCHAR2(80)
APPL_PFX                                VARCHAR2(80)
APPL_NAME                               VARCHAR2(80)
APPL_TYPE                               VARCHAR2(80)
APPL_SFX                                VARCHAR2(80)
APPL_CODE1                              VARCHAR2(80)
APPL_UNIT1                              VARCHAR2(80)
APPL_CODE2                              VARCHAR2(80)
APPL_UNIT2                              VARCHAR2(80)
APPL_NUM                                VARCHAR2(20)
SQLWKS> 	desc ADRSTREET;                     
Column Name                    Null?    Type
------------------------------ -------- ----
ADDR_PFX                       NOT NULL VARCHAR2(2)
ADDR_NAME                      NOT NULL VARCHAR2(30)
ADDR_TYPE                      NOT NULL VARCHAR2(4)
ADDR_SFX                       NOT NULL VARCHAR2(2)
STREET_ID                               NUMBER(8)
ADDR_COMPRESS                           VARCHAR2(30)
ADDR_COMPACT                            VARCHAR2(30)
ADDR_REDUCED                            VARCHAR2(30)
ADDR_BEGIN                              VARCHAR2(30)
ADDR_ENDING                             VARCHAR2(30)
ADDR_SOUNDEX                            VARCHAR2(20)
ADDR_PERMUTE                            NUMBER
SQLWKS> 	desc ADRSTREETS;                    
Column Name                    Null?    Type
------------------------------ -------- ----
ADDR_PFX                       NOT NULL VARCHAR2(2)
ADDR_NAME                      NOT NULL VARCHAR2(30)
ADDR_TYPE                      NOT NULL VARCHAR2(4)
ADDR_SFX                       NOT NULL VARCHAR2(2)
STREET_ID                               NUMBER(8)
ADDR_COMPRESS                           VARCHAR2(30)
ADDR_COMPACT                            VARCHAR2(30)
ADDR_REDUCED                            VARCHAR2(30)
ADDR_BEGIN                              VARCHAR2(30)
ADDR_ENDING                             VARCHAR2(30)
ADDR_SOUNDEX                            VARCHAR2(20)
ADDR_PERMUTE                            NUMBER
SQLWKS> 	desc ADRSTREET_SNAP;                
Column Name                    Null?    Type
------------------------------ -------- ----
ADDR_PFX                       NOT NULL VARCHAR2(2)
ADDR_NAME                      NOT NULL VARCHAR2(30)
ADDR_TYPE                      NOT NULL VARCHAR2(4)
ADDR_SFX                       NOT NULL VARCHAR2(2)
STREET_ID                               NUMBER(8)
ADDR_COMPRESS                           VARCHAR2(30)
ADDR_COMPACT                            VARCHAR2(30)
ADDR_REDUCED                            VARCHAR2(30)
ADDR_BEGIN                              VARCHAR2(30)
ADDR_ENDING                             VARCHAR2(30)
ADDR_SOUNDEX                            VARCHAR2(20)
ADDR_PERMUTE                            NUMBER
SQLWKS> 	desc ANIMAL_CONTROL_LOG;            
Column Name                    Null?    Type
------------------------------ -------- ----
REC_KEY                                 NUMBER
ADDR_NUM                                NUMBER
ADDR_PFX                                VARCHAR2(2)
ADDR_NAME                               VARCHAR2(80)
ADDR_TYPE                               VARCHAR2(4)
ADDR_SFX                                VARCHAR2(2)
ADDR_UNIT                               VARCHAR2(10)
PARCEL_ID                               VARCHAR2(11)
SQLWKS> 	desc ATTRIBUTE_CATALOG;             
Column Name                    Null?    Type
------------------------------ -------- ----
TABLENAME                      NOT NULL VARCHAR2(18)
COLUMNNAME                     NOT NULL VARCHAR2(18)
DISPLAYFORMAT                           VARCHAR2(16)
IS_REQUIRED                             NUMBER(5)
IS_UNIQUE                               NUMBER(5)
DEFAULTUNIT                             VARCHAR2(15)
DEFAULTVALUE                            VARCHAR2(240)
COLUMNDOMAIN                            NUMBER(10)
SQLWKS> 	desc BDJURBEAT;                     
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
BEAT_NUM                                NUMBER(5)
SECTOR_NUM                              NUMBER(5)
DIST_NUM                                NUMBER(5)
BEAT_AREA                               FLOAT(21)
SQLWKS> 	desc BDJURCODEDIST;                 
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
DIST_CODE                               VARCHAR2(2)
SQLWKS> 	desc BDJURDST;                      
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
DISTRICT_ID                             NUMBER(5)
SQLWKS> 	desc BDJURPOLDIST;                  
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
DIST_NUM                                NUMBER(5)
SECTOR_NUM                              NUMBER(5)
DIST_AREA                               FLOAT(21)
SQLWKS> 	desc BDJURSECTOR;                   
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
SECTOR_NUM                              NUMBER(5)
SECTOR_AREA                             FLOAT(21)
SQLWKS> 	desc BLOCK;                         
Column Name                    Null?    Type
------------------------------ -------- ----
ADDR_PFX                       NOT NULL VARCHAR2(2)
ADDR_NAME                      NOT NULL VARCHAR2(30)
ADDR_TYPE                      NOT NULL VARCHAR2(4)
ADDR_SFX                       NOT NULL VARCHAR2(2)
ADDR_BLOCK                     NOT NULL NUMBER
BLOCK_ID                                NUMBER
START_LO                                NUMBER
STOP_LO                                 NUMBER
COUNTER                                 NUMBER
SQLWKS> 	desc BLOCK_SIDE;                    
Column Name                    Null?    Type
------------------------------ -------- ----
ADDR_PFX                       NOT NULL VARCHAR2(2)
ADDR_NAME                      NOT NULL VARCHAR2(30)
ADDR_TYPE                      NOT NULL VARCHAR2(4)
ADDR_SFX                       NOT NULL VARCHAR2(2)
ADDR_BLOCK                     NOT NULL NUMBER
ADDR_PARITY                    NOT NULL NUMBER
BLOCK_ID                                NUMBER
ZIP_CODE                                VARCHAR2(5)
SUBDIV_ID                               VARCHAR2(5)
COUNCIL_ID                              VARCHAR2(1)
CODE_INSPECT_AREA                       VARCHAR2(2)
FIRE_DISTRICT                           VARCHAR2(1)
POLICE_BEAT                             NUMBER(3)
POLICE_DISTRICT                         VARCHAR2(3)
SQLWKS> 	desc BUILDING;                      
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
BLDG_NAME                               VARCHAR2(30)
BLDG_TYPE                               VARCHAR2(12)
ADDRESS                                 VARCHAR2(30)
SQLWKS> 	desc CATEGORY;                      
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
CNAME                                   VARCHAR2(32)
INDEXNAME                               VARCHAR2(64)
INDEXLEVEL                              NUMBER(5)
INDEXTYPE                               VARCHAR2(8)
CNAME_TSSDS                             VARCHAR2(32)
SQLWKS> 	desc CDBG;                          
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
ID                                      NUMBER(5)
SQLWKS> 	desc CDBGPAR;                       
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
PARCEL_ID                               VARCHAR2(12)
AREA_SIZE                               NUMBER
AREA_U_D                                VARCHAR2(16)
PERIMETER                               NUMBER
PERIM_U_D                               VARCHAR2(16)
X_COORD                                 NUMBER
Y_COORD                                 NUMBER
SQLWKS> 	desc CDBG_INSPECTION;               
Column Name                    Null?    Type
------------------------------ -------- ----
TAX_ID                                  VARCHAR2(15)
NO_OF_CASES                             NUMBER(10)
SQLWKS> 	desc CDRELADR;                      
Column Name                    Null?    Type
------------------------------ -------- ----
PARCEL_ID                      NOT NULL VARCHAR2(20)
ADDR_ID                                 NUMBER(10)
ADDR_NUM                                NUMBER(10)
ADDR_PFX                                VARCHAR2(2)
ADDR_NAME                               VARCHAR2(20)
ADDR_TYPE                               VARCHAR2(4)
ADDR_SFX                                VARCHAR2(2)
ADDR_BLDG                               VARCHAR2(20)
UNIT_TYPE                               VARCHAR2(20)
UNIT_NUM                                VARCHAR2(20)
ZIP_CODE                                NUMBER(10)
ZIP_PLUS                                NUMBER(5)
ADDR_STATUS                             VARCHAR2(3)
MAP_GRID                                NUMBER(5)
UNIT_AUX                                VARCHAR2(20)
MSLINK                                  NUMBER(10)
MAPID                                   NUMBER(10)
PRIVATE_STR                             VARCHAR2(3)
X_COORD                                 NUMBER
Y_COORD                                 NUMBER
SQLWKS> 	desc CDRELADR_AUDIT;                
Column Name                    Null?    Type
------------------------------ -------- ----
PERSON                                  VARCHAR2(8)
ACTION                                  VARCHAR2(1)
TIMESTAMP                               DATE
PARCEL_BEF                              VARCHAR2(12)
PARCEL_AFT                              VARCHAR2(12)
NUM_BEF                                 NUMBER
NUM_AFT                                 NUMBER
PFX_BEF                                 VARCHAR2(2)
PFX_AFT                                 VARCHAR2(2)
NAME_BEF                                VARCHAR2(20)
NAME_AFT                                VARCHAR2(20)
TYPE_BEF                                VARCHAR2(4)
TYPE_AFT                                VARCHAR2(4)
SFX_BEF                                 VARCHAR2(2)
SFX_AFT                                 VARCHAR2(2)
SQLWKS> 	desc CDRELPAR;                      
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
PARCEL_ID                      NOT NULL VARCHAR2(11)
TAX_ACCT                                VARCHAR2(17)
SUBDIV_ID                               VARCHAR2(5)
COUNCIL_ID                              VARCHAR2(1)
POLICE_BEAT                             NUMBER(3)
ZIP_CODE                                VARCHAR2(5)
CODE_INSPECT_AREA                       VARCHAR2(2)
FIRE_DISTRICT                           VARCHAR2(1)
ANIMAL_CONTROL                          VARCHAR2(1)
POLICE_DISTRICT                         VARCHAR2(2)
SQLWKS> 	desc CDRELPAR_AUDIT;                
Column Name                    Null?    Type
------------------------------ -------- ----
PERSON                                  VARCHAR2(8)
ACTION                                  VARCHAR2(1)
TIMESTAMP                               DATE
MSLINK_BEF                              NUMBER
MSLINK_AFT                              NUMBER
PARCEL_BEF                              VARCHAR2(12)
PARCEL_AFT                              VARCHAR2(12)
SQLWKS> 	desc CDRELSUBDV;                    
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER
MAPID                                   NUMBER
SUBDIV_ID                               NUMBER
FINAL_PLAT                              VARCHAR2(40)
REPLAT                                  VARCHAR2(40)
BLOCK                                   NUMBER
LOT_LO                                  NUMBER
LOT_HI                                  NUMBER
RESIDENT_LOTS                           NUMBER
COMMON_LOTS                             NUMBER
VOLUME                                  NUMBER
PAGE_NO                                 NUMBER
AREA_SQFT                               NUMBER
AREA_ACRE                               NUMBER
FILING_DATE                             VARCHAR2(10)
LOGIN_DATE                              VARCHAR2(7)
PARCEL1                                 NUMBER
PARCEL2                                 NUMBER
PARCEL3                                 NUMBER
PARCEL4                                 NUMBER
GRID1                                   VARCHAR2(3)
GRID2                                   VARCHAR2(3)
GRID3                                   VARCHAR2(3)
GRID4                                   VARCHAR2(3)
SQLWKS> 	desc CHAINED_ROWS;                  
Column Name                    Null?    Type
------------------------------ -------- ----
OWNER_NAME                              VARCHAR2(30)
TABLE_NAME                              VARCHAR2(30)
CLUSTER_NAME                            VARCHAR2(30)
PARTITION_NAME                          VARCHAR2(30)
HEAD_ROWID                              ROWID
ANALYZE_TIMESTAMP                       DATE
SQLWKS> 	desc CODE_INSPECTOR;                
Column Name                    Null?    Type
------------------------------ -------- ----
INSPECT_AREA                            VARCHAR2(2)
INSPECTOR                               VARCHAR2(20)
INSPECTOR_ID                            VARCHAR2(3)
SQLWKS> 	desc COM_IMPERVIOUS;                
Column Name                    Null?    Type
------------------------------ -------- ----
PARCEL_ID                               VARCHAR2(20)
ACCOUNT                                 NUMBER(10)
ACCT_USE                                NUMBER(10)
ST_NUMBER                               VARCHAR2(14)
ST_PREFIX                               VARCHAR2(8)
ST_NAME                                 VARCHAR2(25)
ST_TYPE                                 VARCHAR2(8)
ZIPCODE                                 VARCHAR2(14)
CUSTOMER                                VARCHAR2(32)
MULTI_ADDR                              VARCHAR2(6)
PARCEL_AREA                             NUMBER(10)
TTL_IMPERVIOUS                          NUMBER(10)
PCT_IMPERVIOUS                          NUMBER(10)
IND_IMPERVIOUS                          NUMBER(10)
START_DATE                              VARCHAR2(12)
FEE                                     NUMBER(10)
MSLINK                                  NUMBER(10)
SQLWKS> 	desc DCAD_TAX_UB;                   
Column Name                    Null?    Type
------------------------------ -------- ----
SUBDIV                                  VARCHAR2(30)
OWNER                                   VARCHAR2(40)
DCAD_ACCT                               VARCHAR2(17)
TAX_ADDR                                VARCHAR2(40)
TAX_CITY                                VARCHAR2(20)
TAX_ST                                  VARCHAR2(2)
TAX_ZIP                                 VARCHAR2(10)
ADDR_NUM                                NUMBER(5)
ADDR_PFX                                VARCHAR2(2)
ADDR_NAME                               VARCHAR2(20)
ADDR_TYPE                               VARCHAR2(4)
ADDR_SFX                                VARCHAR2(2)
PROP_ZIP                                VARCHAR2(10)
BILL_AMT                                NUMBER(8)
BILL_ASSESS                             NUMBER(8)
OCCUPANT                                VARCHAR2(40)
DL                                      VARCHAR2(13)
SSN                                     VARCHAR2(11)
PARCEL_ID                               VARCHAR2(11)
SQLWKS> 	desc DOMAIN_CATALOG;                
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
DOMAINNAME                              VARCHAR2(32)
DOMAINTYPE                     NOT NULL NUMBER(5)
TABLENAME                      NOT NULL VARCHAR2(18)
SQLWKS> 	desc D_ADDR_BASIS;                  
Column Name                    Null?    Type
------------------------------ -------- ----
LDOMAIN                        NOT NULL NUMBER(10)
DOMAINVALUE                             VARCHAR2(20)
DOMAINDESC                              VARCHAR2(32)
SQLWKS> 	desc D_ADDR_PFX_SFX;                
Column Name                    Null?    Type
------------------------------ -------- ----
LDOMAIN                        NOT NULL NUMBER(10)
DOMAINVALUE                             VARCHAR2(8)
DOMAINDESC                              VARCHAR2(32)
SQLWKS> 	desc D_ADDR_STATUS;                 
Column Name                    Null?    Type
------------------------------ -------- ----
LDOMAIN                        NOT NULL NUMBER(10)
DOMAINVALUE                             VARCHAR2(8)
DOMAINDESC                              VARCHAR2(32)
SQLWKS> 	desc D_ADDR_TYPE;                   
Column Name                    Null?    Type
------------------------------ -------- ----
LDOMAIN                        NOT NULL NUMBER(10)
DOMAINVALUE                             VARCHAR2(8)
DOMAINDESC                              VARCHAR2(32)
SQLWKS> 	desc D_ZIPCODE;                     
Column Name                    Null?    Type
------------------------------ -------- ----
LDOMAIN                        NOT NULL NUMBER(10)
DOMAINVALUE                             VARCHAR2(8)
DOMAINDESC                              VARCHAR2(32)
SQLWKS> 	desc ESRI_ADDRESS;                  
Column Name                    Null?    Type
------------------------------ -------- ----
KEY                            NOT NULL NUMBER
MSLINK                                  NUMBER
PARCEL_ID                               VARCHAR2(12)
ADDRESS                                 VARCHAR2(80)
REGION                                  VARCHAR2(20)
SQLWKS> 	desc ESZ_FIRE;                      
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
ESZ_NUMBER                              NUMBER(10)
SQLWKS> 	desc EXCEPTIONS;                    
Column Name                    Null?    Type
------------------------------ -------- ----
ROW_ID                                  ROWID
OWNER                                   VARCHAR2(30)
TABLE_NAME                              VARCHAR2(30)
CONSTRAINT                              VARCHAR2(30)
SQLWKS> 	desc FEATURE;                       
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
FCODE                          NOT NULL VARCHAR2(12)
FNAME                                   VARCHAR2(32)
CATEGORY                                NUMBER(10)
TABLENAME                               VARCHAR2(18)
FTYPE                                   NUMBER(5)
FLEVEL                                  NUMBER(5)
FSTYLE                                  NUMBER(5)
FWEIGHT                                 NUMBER(5)
FCOLOR                                  NUMBER(5)
DIGCMD                                  VARCHAR2(240)
FELEMENT                                NUMBER(5)
FANGLE                                  VARCHAR2(16)
FHEIGHT                                 NUMBER
FWIDTH                                  NUMBER
FLINESPACE                              NUMBER
TEXTUNIT                                VARCHAR2(15)
LINELENGTH                              NUMBER(5)
FFONT                                   NUMBER(5)
FSYMBOL                                 VARCHAR2(1)
FJUSTIFICATION                          VARCHAR2(3)
CELLLIBRARY                             VARCHAR2(64)
FCELLNAME                               VARCHAR2(6)
CELLSCALE                               NUMBER
STREAMDELTA                             NUMBER
STREAMTOLERANCE                         NUMBER
STREAMUNIT                              VARCHAR2(15)
SNAPTYPE                                NUMBER(5)
SNAPTOLERANCE                           NUMBER(5)
NEWDUP                                  NUMBER(5)
FDASTYPE                                NUMBER(5)
COMP_FEATURE_ID                         NUMBER(10)
USE_RANGE                               VARCHAR2(1)
IS_OPTIONAL                             VARCHAR2(1)
IS_REPEATING                            VARCHAR2(1)
MIN_DISPLAYSCALE                        NUMBER(10)
MAX_DISPLAYSCALE                        NUMBER(10)
DISPLAYPRIORITY                         NUMBER(5)
TSSDS_FNAME                             VARCHAR2(32)
GARLAND_INUSE                           VARCHAR2(1)
GARLAND_NEW                             VARCHAR2(1)
GARLAND_DATASOURCE                      VARCHAR2(32)
SQLWKS> 	desc GARLAND_WORK_MASTER;           
Column Name                    Null?    Type
------------------------------ -------- ----
SFG_NUMBER                              NUMBER(5)
COST                                    NUMBER(10)
SFG_NAME                                VARCHAR2(20)
SFG_UNITS                               VARCHAR2(4)
SFG_TIME                                VARCHAR2(40)
CATEGORY                                VARCHAR2(10)
SQLWKS> 	desc GIS_ABSTACT;                   
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
ABSTRACT_NO                             NUMBER(10)
ABSTRACT_NAME                           VARCHAR2(20)
SQLWKS> 	desc GIS_APP_ROWID;                 
Column Name                    Null?    Type
------------------------------ -------- ----
ROW_SEQ                        NOT NULL NUMBER
ROW_ID                                  ROWID
SQLWKS> 	desc GIS_COUNCIL_DIST;              
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
DIST_NUM                                VARCHAR2(2)
SQLWKS> 	desc GIS_FIRE_DIST;                 
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
DISTRICT_NUM                            VARCHAR2(4)
SQLWKS> 	desc GIS_OBJECTS;                   
Column Name                    Null?    Type
------------------------------ -------- ----
ITEM01                                  VARCHAR2(1000)
ITEM02                                  VARCHAR2(2000)
ITEM03                                  VARCHAR2(2000)
ITEM04                                  VARCHAR2(2000)
ITEM05                                  VARCHAR2(2000)
ITEM06                                  VARCHAR2(2000)
ITEM07                                  VARCHAR2(2000)
ITEM08                                  VARCHAR2(2000)
ITEM09                                  VARCHAR2(2000)
ITEM10                                  VARCHAR2(2000)
ITEM11                                  VARCHAR2(2000)
ITEM12                                  VARCHAR2(2000)
ITEM13                                  VARCHAR2(2000)
ITEM14                                  VARCHAR2(2000)
ITEM15                                  VARCHAR2(2000)
ITEM16                                  VARCHAR2(2000)
ITEM17                                  VARCHAR2(2000)
ITEM18                                  VARCHAR2(2000)
ITEM19                                  VARCHAR2(2000)
ITEM20                                  VARCHAR2(2000)
ITEM21                                  VARCHAR2(2000)
ITEM22                                  VARCHAR2(2000)
ITEM23                                  VARCHAR2(2000)
ITEM24                                  VARCHAR2(2000)
ITEM25                                  VARCHAR2(2000)
ITEM26                                  VARCHAR2(2000)
ITEM27                                  VARCHAR2(2000)
ITEM28                                  VARCHAR2(2000)
ITEM29                                  VARCHAR2(2000)
ITEM30                                  VARCHAR2(2000)
ITEM31                                  VARCHAR2(2000)
ITEM32                                  VARCHAR2(2000)
ITEM33                                  VARCHAR2(2000)
ITEM34                                  VARCHAR2(2000)
ITEM35                                  VARCHAR2(2000)
ITEM36                                  VARCHAR2(2000)
ITEM37                                  VARCHAR2(2000)
ITEM38                                  VARCHAR2(2000)
ITEM39                                  VARCHAR2(2000)
ITEM40                                  VARCHAR2(2000)
ITEM41                                  VARCHAR2(2000)
ITEM42                                  VARCHAR2(2000)
ITEM43                                  VARCHAR2(2000)
ITEM44                                  VARCHAR2(2000)
ITEM45                                  VARCHAR2(2000)
ITEM46                                  VARCHAR2(2000)
ITEM47                                  VARCHAR2(2000)
ITEM48                                  VARCHAR2(2000)
ITEM49                                  VARCHAR2(2000)
ITEM50                                  VARCHAR2(2000)
ITEM51                                  VARCHAR2(2000)
ITEM52                                  VARCHAR2(2000)
ITEM53                                  VARCHAR2(2000)
ITEM54                                  VARCHAR2(2000)
ITEM55                                  VARCHAR2(2000)
ITEM56                                  VARCHAR2(2000)
ITEM57                                  VARCHAR2(2000)
ITEM58                                  VARCHAR2(2000)
ITEM59                                  VARCHAR2(2000)
ITEM60                                  VARCHAR2(2000)
ITEM61                                  VARCHAR2(2000)
ITEM62                                  VARCHAR2(2000)
ITEM63                                  VARCHAR2(2000)
ITEM64                                  VARCHAR2(2000)
ITEM65                                  VARCHAR2(2000)
ITEM66                                  VARCHAR2(2000)
ITEM67                                  VARCHAR2(2000)
ITEM68                                  VARCHAR2(2000)
ITEM69                                  VARCHAR2(2000)
ITEM70                                  VARCHAR2(2000)
ITEM71                                  VARCHAR2(2000)
ITEM72                                  VARCHAR2(2000)
ITEM73                                  VARCHAR2(2000)
ITEM74                                  VARCHAR2(2000)
ITEM75                                  VARCHAR2(2000)
ITEM76                                  VARCHAR2(2000)
ITEM77                                  VARCHAR2(2000)
ITEM78                                  VARCHAR2(2000)
ITEM79                                  VARCHAR2(2000)
ITEM80                                  VARCHAR2(2000)
SQLWKS> 	desc GIS_TEMP1;                     
Column Name                    Null?    Type
------------------------------ -------- ----
ITEM01                                  VARCHAR2(1000)
ITEM02                                  VARCHAR2(2000)
ITEM03                                  VARCHAR2(2000)
ITEM04                                  VARCHAR2(2000)
ITEM05                                  VARCHAR2(2000)
ITEM06                                  VARCHAR2(2000)
ITEM07                                  VARCHAR2(2000)
ITEM08                                  VARCHAR2(2000)
ITEM09                                  VARCHAR2(2000)
ITEM10                                  VARCHAR2(2000)
ITEM11                                  VARCHAR2(2000)
ITEM12                                  VARCHAR2(2000)
ITEM13                                  VARCHAR2(2000)
ITEM14                                  VARCHAR2(2000)
ITEM15                                  VARCHAR2(2000)
ITEM16                                  VARCHAR2(2000)
ITEM17                                  VARCHAR2(2000)
ITEM18                                  VARCHAR2(2000)
ITEM19                                  VARCHAR2(2000)
ITEM20                                  VARCHAR2(2000)
ITEM21                                  VARCHAR2(2000)
ITEM22                                  VARCHAR2(2000)
ITEM23                                  VARCHAR2(2000)
ITEM24                                  VARCHAR2(2000)
ITEM25                                  VARCHAR2(2000)
ITEM26                                  VARCHAR2(2000)
ITEM27                                  VARCHAR2(2000)
ITEM28                                  VARCHAR2(2000)
ITEM29                                  VARCHAR2(2000)
ITEM30                                  VARCHAR2(2000)
ITEM31                                  VARCHAR2(2000)
ITEM32                                  VARCHAR2(2000)
ITEM33                                  VARCHAR2(2000)
ITEM34                                  VARCHAR2(2000)
ITEM35                                  VARCHAR2(2000)
ITEM36                                  VARCHAR2(2000)
ITEM37                                  VARCHAR2(2000)
ITEM38                                  VARCHAR2(2000)
ITEM39                                  VARCHAR2(2000)
ITEM40                                  VARCHAR2(2000)
ITEM41                                  VARCHAR2(2000)
ITEM42                                  VARCHAR2(2000)
ITEM43                                  VARCHAR2(2000)
ITEM44                                  VARCHAR2(2000)
ITEM45                                  VARCHAR2(2000)
ITEM46                                  VARCHAR2(2000)
ITEM47                                  VARCHAR2(2000)
ITEM48                                  VARCHAR2(2000)
ITEM49                                  VARCHAR2(2000)
ITEM50                                  VARCHAR2(2000)
ITEM51                                  VARCHAR2(2000)
ITEM52                                  VARCHAR2(2000)
ITEM53                                  VARCHAR2(2000)
ITEM54                                  VARCHAR2(2000)
ITEM55                                  VARCHAR2(2000)
ITEM56                                  VARCHAR2(2000)
ITEM57                                  VARCHAR2(2000)
ITEM58                                  VARCHAR2(2000)
ITEM59                                  VARCHAR2(2000)
ITEM60                                  VARCHAR2(2000)
ITEM61                                  VARCHAR2(2000)
ITEM62                                  VARCHAR2(2000)
ITEM63                                  VARCHAR2(2000)
ITEM64                                  VARCHAR2(2000)
ITEM65                                  VARCHAR2(2000)
ITEM66                                  VARCHAR2(2000)
ITEM67                                  VARCHAR2(2000)
ITEM68                                  VARCHAR2(2000)
ITEM69                                  VARCHAR2(2000)
ITEM70                                  VARCHAR2(2000)
ITEM71                                  VARCHAR2(2000)
ITEM72                                  VARCHAR2(2000)
ITEM73                                  VARCHAR2(2000)
ITEM74                                  VARCHAR2(2000)
ITEM75                                  VARCHAR2(2000)
ITEM76                                  VARCHAR2(2000)
ITEM77                                  VARCHAR2(2000)
ITEM78                                  VARCHAR2(2000)
ITEM79                                  VARCHAR2(2000)
ITEM80                                  VARCHAR2(2000)
SQLWKS> 	desc GIS_TEMP2;                     
Column Name                    Null?    Type
------------------------------ -------- ----
ITEM01                                  VARCHAR2(1000)
ITEM02                                  VARCHAR2(2000)
ITEM03                                  VARCHAR2(2000)
ITEM04                                  VARCHAR2(2000)
ITEM05                                  VARCHAR2(2000)
ITEM06                                  VARCHAR2(2000)
ITEM07                                  VARCHAR2(2000)
ITEM08                                  VARCHAR2(2000)
ITEM09                                  VARCHAR2(2000)
ITEM10                                  VARCHAR2(2000)
ITEM11                                  VARCHAR2(2000)
ITEM12                                  VARCHAR2(2000)
ITEM13                                  VARCHAR2(2000)
ITEM14                                  VARCHAR2(2000)
ITEM15                                  VARCHAR2(2000)
ITEM16                                  VARCHAR2(2000)
ITEM17                                  VARCHAR2(2000)
ITEM18                                  VARCHAR2(2000)
ITEM19                                  VARCHAR2(2000)
ITEM20                                  VARCHAR2(2000)
ITEM21                                  VARCHAR2(2000)
ITEM22                                  VARCHAR2(2000)
ITEM23                                  VARCHAR2(2000)
ITEM24                                  VARCHAR2(2000)
ITEM25                                  VARCHAR2(2000)
ITEM26                                  VARCHAR2(2000)
ITEM27                                  VARCHAR2(2000)
ITEM28                                  VARCHAR2(2000)
ITEM29                                  VARCHAR2(2000)
ITEM30                                  VARCHAR2(2000)
ITEM31                                  VARCHAR2(2000)
ITEM32                                  VARCHAR2(2000)
ITEM33                                  VARCHAR2(2000)
ITEM34                                  VARCHAR2(2000)
ITEM35                                  VARCHAR2(2000)
ITEM36                                  VARCHAR2(2000)
ITEM37                                  VARCHAR2(2000)
ITEM38                                  VARCHAR2(2000)
ITEM39                                  VARCHAR2(2000)
ITEM40                                  VARCHAR2(2000)
ITEM41                                  VARCHAR2(2000)
ITEM42                                  VARCHAR2(2000)
ITEM43                                  VARCHAR2(2000)
ITEM44                                  VARCHAR2(2000)
ITEM45                                  VARCHAR2(2000)
ITEM46                                  VARCHAR2(2000)
ITEM47                                  VARCHAR2(2000)
ITEM48                                  VARCHAR2(2000)
ITEM49                                  VARCHAR2(2000)
ITEM50                                  VARCHAR2(2000)
ITEM51                                  VARCHAR2(2000)
ITEM52                                  VARCHAR2(2000)
ITEM53                                  VARCHAR2(2000)
ITEM54                                  VARCHAR2(2000)
ITEM55                                  VARCHAR2(2000)
ITEM56                                  VARCHAR2(2000)
ITEM57                                  VARCHAR2(2000)
ITEM58                                  VARCHAR2(2000)
ITEM59                                  VARCHAR2(2000)
ITEM60                                  VARCHAR2(2000)
ITEM61                                  VARCHAR2(2000)
ITEM62                                  VARCHAR2(2000)
ITEM63                                  VARCHAR2(2000)
ITEM64                                  VARCHAR2(2000)
ITEM65                                  VARCHAR2(2000)
ITEM66                                  VARCHAR2(2000)
ITEM67                                  VARCHAR2(2000)
ITEM68                                  VARCHAR2(2000)
ITEM69                                  VARCHAR2(2000)
ITEM70                                  VARCHAR2(2000)
ITEM71                                  VARCHAR2(2000)
ITEM72                                  VARCHAR2(2000)
ITEM73                                  VARCHAR2(2000)
ITEM74                                  VARCHAR2(2000)
ITEM75                                  VARCHAR2(2000)
ITEM76                                  VARCHAR2(2000)
ITEM77                                  VARCHAR2(2000)
ITEM78                                  VARCHAR2(2000)
ITEM79                                  VARCHAR2(2000)
ITEM80                                  VARCHAR2(2000)
SQLWKS> 	desc GIS_TEMP3;                     
Column Name                    Null?    Type
------------------------------ -------- ----
ITEM01                                  VARCHAR2(1000)
ITEM02                                  VARCHAR2(2000)
ITEM03                                  VARCHAR2(2000)
ITEM04                                  VARCHAR2(2000)
ITEM05                                  VARCHAR2(2000)
ITEM06                                  VARCHAR2(2000)
ITEM07                                  VARCHAR2(2000)
ITEM08                                  VARCHAR2(2000)
ITEM09                                  VARCHAR2(2000)
ITEM10                                  VARCHAR2(2000)
ITEM11                                  VARCHAR2(2000)
ITEM12                                  VARCHAR2(2000)
ITEM13                                  VARCHAR2(2000)
ITEM14                                  VARCHAR2(2000)
ITEM15                                  VARCHAR2(2000)
ITEM16                                  VARCHAR2(2000)
ITEM17                                  VARCHAR2(2000)
ITEM18                                  VARCHAR2(2000)
ITEM19                                  VARCHAR2(2000)
ITEM20                                  VARCHAR2(2000)
ITEM21                                  VARCHAR2(2000)
ITEM22                                  VARCHAR2(2000)
ITEM23                                  VARCHAR2(2000)
ITEM24                                  VARCHAR2(2000)
ITEM25                                  VARCHAR2(2000)
ITEM26                                  VARCHAR2(2000)
ITEM27                                  VARCHAR2(2000)
ITEM28                                  VARCHAR2(2000)
ITEM29                                  VARCHAR2(2000)
ITEM30                                  VARCHAR2(2000)
ITEM31                                  VARCHAR2(2000)
ITEM32                                  VARCHAR2(2000)
ITEM33                                  VARCHAR2(2000)
ITEM34                                  VARCHAR2(2000)
ITEM35                                  VARCHAR2(2000)
ITEM36                                  VARCHAR2(2000)
ITEM37                                  VARCHAR2(2000)
ITEM38                                  VARCHAR2(2000)
ITEM39                                  VARCHAR2(2000)
ITEM40                                  VARCHAR2(2000)
ITEM41                                  VARCHAR2(2000)
ITEM42                                  VARCHAR2(2000)
ITEM43                                  VARCHAR2(2000)
ITEM44                                  VARCHAR2(2000)
ITEM45                                  VARCHAR2(2000)
ITEM46                                  VARCHAR2(2000)
ITEM47                                  VARCHAR2(2000)
ITEM48                                  VARCHAR2(2000)
ITEM49                                  VARCHAR2(2000)
ITEM50                                  VARCHAR2(2000)
ITEM51                                  VARCHAR2(2000)
ITEM52                                  VARCHAR2(2000)
ITEM53                                  VARCHAR2(2000)
ITEM54                                  VARCHAR2(2000)
ITEM55                                  VARCHAR2(2000)
ITEM56                                  VARCHAR2(2000)
ITEM57                                  VARCHAR2(2000)
ITEM58                                  VARCHAR2(2000)
ITEM59                                  VARCHAR2(2000)
ITEM60                                  VARCHAR2(2000)
ITEM61                                  VARCHAR2(2000)
ITEM62                                  VARCHAR2(2000)
ITEM63                                  VARCHAR2(2000)
ITEM64                                  VARCHAR2(2000)
ITEM65                                  VARCHAR2(2000)
ITEM66                                  VARCHAR2(2000)
ITEM67                                  VARCHAR2(2000)
ITEM68                                  VARCHAR2(2000)
ITEM69                                  VARCHAR2(2000)
ITEM70                                  VARCHAR2(2000)
ITEM71                                  VARCHAR2(2000)
ITEM72                                  VARCHAR2(2000)
ITEM73                                  VARCHAR2(2000)
ITEM74                                  VARCHAR2(2000)
ITEM75                                  VARCHAR2(2000)
ITEM76                                  VARCHAR2(2000)
ITEM77                                  VARCHAR2(2000)
ITEM78                                  VARCHAR2(2000)
ITEM79                                  VARCHAR2(2000)
ITEM80                                  VARCHAR2(2000)
SQLWKS> 	desc GIS_TEMP4;                     
Column Name                    Null?    Type
------------------------------ -------- ----
ITEM01                                  VARCHAR2(1000)
ITEM02                                  VARCHAR2(2000)
ITEM03                                  VARCHAR2(2000)
ITEM04                                  VARCHAR2(2000)
ITEM05                                  VARCHAR2(2000)
ITEM06                                  VARCHAR2(2000)
ITEM07                                  VARCHAR2(2000)
ITEM08                                  VARCHAR2(2000)
ITEM09                                  VARCHAR2(2000)
ITEM10                                  VARCHAR2(2000)
ITEM11                                  VARCHAR2(2000)
ITEM12                                  VARCHAR2(2000)
ITEM13                                  VARCHAR2(2000)
ITEM14                                  VARCHAR2(2000)
ITEM15                                  VARCHAR2(2000)
ITEM16                                  VARCHAR2(2000)
ITEM17                                  VARCHAR2(2000)
ITEM18                                  VARCHAR2(2000)
ITEM19                                  VARCHAR2(2000)
ITEM20                                  VARCHAR2(2000)
ITEM21                                  VARCHAR2(2000)
ITEM22                                  VARCHAR2(2000)
ITEM23                                  VARCHAR2(2000)
ITEM24                                  VARCHAR2(2000)
ITEM25                                  VARCHAR2(2000)
ITEM26                                  VARCHAR2(2000)
ITEM27                                  VARCHAR2(2000)
ITEM28                                  VARCHAR2(2000)
ITEM29                                  VARCHAR2(2000)
ITEM30                                  VARCHAR2(2000)
ITEM31                                  VARCHAR2(2000)
ITEM32                                  VARCHAR2(2000)
ITEM33                                  VARCHAR2(2000)
ITEM34                                  VARCHAR2(2000)
ITEM35                                  VARCHAR2(2000)
ITEM36                                  VARCHAR2(2000)
ITEM37                                  VARCHAR2(2000)
ITEM38                                  VARCHAR2(2000)
ITEM39                                  VARCHAR2(2000)
ITEM40                                  VARCHAR2(2000)
ITEM41                                  VARCHAR2(2000)
ITEM42                                  VARCHAR2(2000)
ITEM43                                  VARCHAR2(2000)
ITEM44                                  VARCHAR2(2000)
ITEM45                                  VARCHAR2(2000)
ITEM46                                  VARCHAR2(2000)
ITEM47                                  VARCHAR2(2000)
ITEM48                                  VARCHAR2(2000)
ITEM49                                  VARCHAR2(2000)
ITEM50                                  VARCHAR2(2000)
ITEM51                                  VARCHAR2(2000)
ITEM52                                  VARCHAR2(2000)
ITEM53                                  VARCHAR2(2000)
ITEM54                                  VARCHAR2(2000)
ITEM55                                  VARCHAR2(2000)
ITEM56                                  VARCHAR2(2000)
ITEM57                                  VARCHAR2(2000)
ITEM58                                  VARCHAR2(2000)
ITEM59                                  VARCHAR2(2000)
ITEM60                                  VARCHAR2(2000)
ITEM61                                  VARCHAR2(2000)
ITEM62                                  VARCHAR2(2000)
ITEM63                                  VARCHAR2(2000)
ITEM64                                  VARCHAR2(2000)
ITEM65                                  VARCHAR2(2000)
ITEM66                                  VARCHAR2(2000)
ITEM67                                  VARCHAR2(2000)
ITEM68                                  VARCHAR2(2000)
ITEM69                                  VARCHAR2(2000)
ITEM70                                  VARCHAR2(2000)
ITEM71                                  VARCHAR2(2000)
ITEM72                                  VARCHAR2(2000)
ITEM73                                  VARCHAR2(2000)
ITEM74                                  VARCHAR2(2000)
ITEM75                                  VARCHAR2(2000)
ITEM76                                  VARCHAR2(2000)
ITEM77                                  VARCHAR2(2000)
ITEM78                                  VARCHAR2(2000)
ITEM79                                  VARCHAR2(2000)
ITEM80                                  VARCHAR2(2000)
SQLWKS> 	desc GIS_VERIFY_ADDR;               
Column Name                    Null?    Type
------------------------------ -------- ----
ADDR_NUM                                VARCHAR2(20)
ADDR_PFX                                VARCHAR2(80)
ADDR_NAME                               VARCHAR2(80)
ADDR_TYPE                               VARCHAR2(80)
ADDR_SFX                                VARCHAR2(80)
ADDR_CODE1                              VARCHAR2(80)
ADDR_UNIT1                              VARCHAR2(80)
ADDR_CODE2                              VARCHAR2(80)
ADDR_UNIT2                              VARCHAR2(80)
VERIFY_CODE                             VARCHAR2(2)
DO_PARSE                                VARCHAR2(30)
DO_ALIAS                                VARCHAR2(5)
DO_NAME                                 VARCHAR2(1)
DO_QUAL                                 VARCHAR2(20)
REC_SEQ                                 NUMBER
REC_ROWID                               ROWID
REC_KEY                                 VARCHAR2(20)
PARCEL_ID                               VARCHAR2(12)
SEGMENT_ID                              VARCHAR2(5)
FORM_PFX                                VARCHAR2(80)
FORM_NAME                               VARCHAR2(80)
FORM_TYPE                               VARCHAR2(80)
FORM_SFX                                VARCHAR2(80)
FORM_CODE1                              VARCHAR2(80)
FORM_UNIT1                              VARCHAR2(80)
FORM_CODE2                              VARCHAR2(80)
FORM_UNIT2                              VARCHAR2(80)
APPL_PFX                                VARCHAR2(80)
APPL_NAME                               VARCHAR2(80)
APPL_TYPE                               VARCHAR2(80)
APPL_SFX                                VARCHAR2(80)
APPL_CODE1                              VARCHAR2(80)
APPL_UNIT1                              VARCHAR2(80)
APPL_CODE2                              VARCHAR2(80)
APPL_UNIT2                              VARCHAR2(80)
APPL_NUM                                VARCHAR2(20)
SQLWKS> 	desc GIS_ZIP_CODE;                  
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
ZIP_CODE                                VARCHAR2(5)
SQLWKS> 	desc GPLSRVA;                       
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
OWNER                                   VARCHAR2(10)
PARCEL_ID                               NUMBER(10)
SQLWKS> 	desc IDX;                           
Column Name                    Null?    Type
------------------------------ -------- ----
TABLE_NAME                     NOT NULL VARCHAR2(30)
TABLESPACE_NAME                NOT NULL VARCHAR2(30)
INDEX_NAME                     NOT NULL VARCHAR2(30)
SQLWKS> 	desc INSPECTION_MASTER;             
Column Name                    Null?    Type
------------------------------ -------- ----
CLASS_NAME                     NOT NULL VARCHAR2(10)
CLASS_MIN                               NUMBER(3)
CLASS_MAX                               NUMBER(3)
CLASS_DIVISOR                           NUMBER(1)
SQLWKS> 	desc INSP_ARCH;                     
Column Name                    Null?    Type
------------------------------ -------- ----
CATEGORY                                VARCHAR2(1)
BRANCH                                  NUMBER(4)
SECTION                                 NUMBER(4)
SEGMENT                                 NUMBER(4)
LENG                                    NUMBER(5)
LANES                                   NUMBER(2,1)
SURF_TYPE                               VARCHAR2(3)
REAR_ENTRY                              VARCHAR2(1)
CDBG                                    VARCHAR2(1)
CONST_DATE                              DATE
LAST_INSPECT_DATE                       DATE
NEXT_INSPECT_DATE                       DATE
PCI                                     NUMBER(5,2)
CLASS                                   VARCHAR2(10)
CRACK_SEAL                              VARCHAR2(1)
DISTRESSES                              NUMBER(4)
POT_HOLE_REQ                            VARCHAR2(1)
COUN_DIST                               NUMBER(2)
THOR_TYPE                               VARCHAR2(2)
ADDR_NUM                                NUMBER(6)
ADDR_PFX                                VARCHAR2(2)
ADDR_NAME                               VARCHAR2(40)
ADDR_TYPE                               VARCHAR2(4)
ADDR_SFX                                VARCHAR2(2)
FROM_ADDR_NUM                           NUMBER(6)
FROM_ADDR_PFX                           VARCHAR2(2)
FROM_ADDR_NAME                          VARCHAR2(40)
FROM_ADDR_TYPE                          VARCHAR2(4)
FROM_ADDR_SFX                           VARCHAR2(2)
TO_ADDR_NUM                             NUMBER(6)
TO_ADDR_PFX                             VARCHAR2(2)
TO_ADDR_NAME                            VARCHAR2(40)
TO_ADDR_TYPE                            VARCHAR2(4)
TO_ADDR_SFX                             VARCHAR2(2)
REMARKS                                 VARCHAR2(40)
TIME_STAMP                              DATE
THOR_TYPE_NEW                           VARCHAR2(2)
MISSING_SDWK                            VARCHAR2(1)
SQLWKS> 	desc INTERSECTION;                  
Column Name                    Null?    Type
------------------------------ -------- ----
ADDR1_BLOCK                             NUMBER
ADDR1_PFX                               VARCHAR2(2)
ADDR1_NAME                              VARCHAR2(20)
ADDR1_TYPE                              VARCHAR2(4)
ADDR1_SFX                               VARCHAR2(2)
ADDR2_BLOCK                             NUMBER
ADDR2_PFX                               VARCHAR2(2)
ADDR2_NAME                              VARCHAR2(20)
ADDR2_TYPE                              VARCHAR2(4)
ADDR2_SFX                               VARCHAR2(2)
CORNER_COMPASS                          VARCHAR2(2)
TWIN_COMPASS                            VARCHAR2(2)
NODE_ID                                 VARCHAR2(20)
INTERSECT_ID                            VARCHAR2(20)
TAX_ACCT                                VARCHAR2(17)
SUBDIV_ID                               VARCHAR2(5)
COUNCIL_ID                              VARCHAR2(1)
ZIP_CODE                                VARCHAR2(5)
CODE_INSPECT_AREA                       VARCHAR2(2)
FIRE_DISTRICT                           VARCHAR2(1)
POLICE_BEAT                             NUMBER(3)
POLICE_DISTRICT                         VARCHAR2(3)
ANIMAL_CONTROL                          VARCHAR2(1)
SQLWKS> 	desc JOIN_CATALOG;                  
Column Name                    Null?    Type
------------------------------ -------- ----
JOINID                         NOT NULL NUMBER(10)
TABLE1                         NOT NULL VARCHAR2(18)
TABLE2                         NOT NULL VARCHAR2(18)
RELATIONSHIP                   NOT NULL VARCHAR2(240)
SQLWKS> 	desc LABEL;                         
Column Name                    Null?    Type
------------------------------ -------- ----
LABEL                          NOT NULL NUMBER(10)
CONTENTSTMT                             VARCHAR2(240)
X_OFFSET                                NUMBER
Y_OFFSET                                NUMBER
SQLWKS> 	desc LIBRARY_PATRON;                
Column Name                    Null?    Type
------------------------------ -------- ----
PATRON_KEY                              VARCHAR2(6)
ADDR_NUM                                NUMBER
ADDR_PFX                                VARCHAR2(2)
ADDR_NAME                               VARCHAR2(40)
ADDR_TYPE                               VARCHAR2(4)
ADDR_SFX                                VARCHAR2(2)
ADDR_CODE                               VARCHAR2(4)
ADDR_UNIT                               VARCHAR2(6)
VERIFY_CODE                             VARCHAR2(1)
CENSUS_BLOK                             VARCHAR2(6)
PARCEL_ID                               VARCHAR2(11)
SEGMENT_ID                              VARCHAR2(4)
DATE_ADD                                DATE
DATE_MODIFY                             DATE
DATE_SCRUB                              DATE
CITY                                    VARCHAR2(10)
ZIP                                     VARCHAR2(5)
PATRON_ID                               VARCHAR2(5)
SQLWKS> 	desc LIST_DOMAIN;                   
Column Name                    Null?    Type
------------------------------ -------- ----
LDOMAIN                        NOT NULL NUMBER(10)
DOMAINVALUE                    NOT NULL VARCHAR2(8)
DOMAINDESC                              VARCHAR2(32)
SQLWKS> 	desc MAPBOOK2;                      
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
GRID_ID                                 VARCHAR2(3)
ST_NAME                                 VARCHAR2(40)
SQLWKS> 	desc MAPCOADDRESS;                  
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
GRID_ID                                 VARCHAR2(3)
ADDR_PFX                                VARCHAR2(2)
ADDR_NAME                               VARCHAR2(20)
ADDR_SFX                                VARCHAR2(2)
ADDR_TYPE                               VARCHAR2(4)
ODDLO                                   NUMBER(10)
ODDHI                                   NUMBER(10)
EVENLO                                  NUMBER(10)
EVENHI                                  NUMBER(10)
MID_NO                                  NUMBER(10)
SQLWKS> 	desc MAPCOGRID;                     
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
GRDBK_GRID_ID                           VARCHAR2(3)
TRVEH_ST_NAME                           VARCHAR2(40)
SQLWKS> 	desc MAPCOPAGE;                     
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
GRID_ID                                 VARCHAR2(3)
PAGE_NO                                 NUMBER(5)
GRID_LETTER                             VARCHAR2(1)
SQLWKS> 	desc MAPS;                          
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPNAME                                 VARCHAR2(64)
CATEGORY                                NUMBER(10)
XHIGH                                   NUMBER(10)
YHIGH                                   NUMBER(10)
XLOW                                    NUMBER(10)
YLOW                                    NUMBER(10)
SQLWKS> 	desc MLOG$_TST_JOHN;                
Column Name                    Null?    Type
------------------------------ -------- ----
M_ROW$$                                 VARCHAR2(18)
SNAPTIME$$                              DATE
DMLTYPE$$                               VARCHAR2(1)
OLD_NEW$$                               VARCHAR2(1)
CHANGE_VECTOR$$                         RAW(255)
SQLWKS> 	desc MSCATALOG;                     
Column Name                    Null?    Type
------------------------------ -------- ----
TABLENAME                      NOT NULL VARCHAR2(32)
ENTITYNUM                      NOT NULL NUMBER(10)
NEXTOCC                                 NUMBER(10)
SCREENFORM                              VARCHAR2(64)
REPORTTABLE                             VARCHAR2(64)
SQLREVIEW                               VARCHAR2(240)
FENCEFILTER                             VARCHAR2(240)
DASTABLE                                VARCHAR2(32)
TABLETYPE                               NUMBER(10)
SQLWKS> 	desc MSFORMS;                       
Column Name                    Null?    Type
------------------------------ -------- ----
ENTITY                                  NUMBER(10)
MSLINK                                  NUMBER(10)
SQLWKS> 	desc NEW_GIS_VERIFY_ADDR;           
Column Name                    Null?    Type
------------------------------ -------- ----
ADDR_NUM                                VARCHAR2(20)
ADDR_PFX                                VARCHAR2(80)
ADDR_NAME                               VARCHAR2(80)
ADDR_TYPE                               VARCHAR2(80)
ADDR_SFX                                VARCHAR2(80)
ADDR_CODE1                              VARCHAR2(80)
ADDR_UNIT1                              VARCHAR2(80)
ADDR_CODE2                              VARCHAR2(80)
ADDR_UNIT2                              VARCHAR2(80)
VERIFY_CODE                             VARCHAR2(2)
DO_PARSE                                VARCHAR2(30)
DO_ALIAS                                VARCHAR2(5)
DO_NAME                                 VARCHAR2(1)
DO_QUAL                                 VARCHAR2(20)
REC_SEQ                                 NUMBER
REC_ROWID                               ROWID
REC_KEY                                 VARCHAR2(20)
PARCEL_ID                               VARCHAR2(12)
SEGMENT_ID                              VARCHAR2(5)
FORM_PFX                                VARCHAR2(80)
FORM_NAME                               VARCHAR2(80)
FORM_TYPE                               VARCHAR2(80)
FORM_SFX                                VARCHAR2(80)
FORM_CODE1                              VARCHAR2(80)
FORM_UNIT1                              VARCHAR2(80)
FORM_CODE2                              VARCHAR2(80)
FORM_UNIT2                              VARCHAR2(80)
APPL_PFX                                VARCHAR2(80)
APPL_NAME                               VARCHAR2(80)
APPL_TYPE                               VARCHAR2(80)
APPL_SFX                                VARCHAR2(80)
APPL_CODE1                              VARCHAR2(80)
APPL_UNIT1                              VARCHAR2(80)
APPL_CODE2                              VARCHAR2(80)
APPL_UNIT2                              VARCHAR2(80)
APPL_NUM                                VARCHAR2(20)
SQLWKS> 	desc NSA_CODEADDR_1ST;              
Column Name                    Null?    Type
------------------------------ -------- ----
ADDR_NUM                                NUMBER(6)
ADDR_PFX                                VARCHAR2(2)
ADDR_NAME                               VARCHAR2(40)
ADDR_TYPE                               VARCHAR2(4)
ADDR_SFX                                VARCHAR2(2)
ADDR_CODE                               VARCHAR2(10)
ADDR_UNIT                               VARCHAR2(10)
VERIFY_CODE                             NUMBER(2)
PARCEL_ID                               VARCHAR2(11)
SEGMENT_ID                              NUMBER(5)
COUNCIL_DISTRICT                        VARCHAR2(1)
SUBDIV_ID                               VARCHAR2(5)
INSPECT_AREA                            VARCHAR2(2)
ADDR_ID                                 VARCHAR2(374)
SQLWKS> 	desc NSA_CODE_CITATION;             
Column Name                    Null?    Type
------------------------------ -------- ----
CASE_NUMBER                    NOT NULL NUMBER
CITATION_NUMBER                NOT NULL NUMBER
CITATION_ISSUE_DATE                     DATE
CITATION_COMPLY_DATE                    DATE
SQLWKS> 	desc NSA_CODE_COMPLAINT;            
Column Name                    Null?    Type
------------------------------ -------- ----
CASE_NUMBER                    NOT NULL NUMBER
SQLWKS> 	desc NSA_CODE_INSPECT;              
Column Name                    Null?    Type
------------------------------ -------- ----
CASE_NUMBER                             NUMBER(10)
INSPECTION_DATE                         DATE
CASE_CLOSED_DATE                        DATE
ADDR_NUM                                NUMBER(6)
ADDR_PFX                                VARCHAR2(2)
ADDR_NAME                               VARCHAR2(40)
ADDR_TYPE                               VARCHAR2(4)
ADDR_SFX                                VARCHAR2(2)
UNIT_CODE                               VARCHAR2(6)
UNIT_NUM                                VARCHAR2(6)
ZIP_CODE                                VARCHAR2(5)
ISSUE_DATE                              DATE
COMPLY_DATE                             DATE
ACTION                                  NUMBER(2)
FOLLOW_UP_ACTION                        NUMBER(2)
STATUS                                  VARCHAR2(1)
CODE_ID                                 VARCHAR2(5)
VIOLATION_ID                            VARCHAR2(10)
VIOLATION                               VARCHAR2(30)
INSPECTOR                               VARCHAR2(25)
LEGAL1                                  VARCHAR2(35)
LEGAL2                                  VARCHAR2(35)
INSPECT_AREA                            VARCHAR2(2)
COUNCIL_ID                              VARCHAR2(1)
SUBDIV_ID                               VARCHAR2(5)
NSA_ID                                  VARCHAR2(5)
PARCEL_ID                               VARCHAR2(11)
SEGMENT_ID                              NUMBER(6)
VERIFY_CODE                             NUMBER(2)
INSTIGATOR                              VARCHAR2(1)
SQLWKS> 	desc NSA_CODE_INSPECT_1999;         
Column Name                    Null?    Type
------------------------------ -------- ----
CASE_NUMBER                             NUMBER(10)
INSPECTION_DATE                         DATE
CASE_CLOSED_DATE                        DATE
ADDR_NUM                                NUMBER(6)
ADDR_PFX                                VARCHAR2(2)
ADDR_NAME                               VARCHAR2(40)
ADDR_TYPE                               VARCHAR2(4)
ADDR_SFX                                VARCHAR2(2)
UNIT_CODE                               VARCHAR2(6)
UNIT_NUM                                VARCHAR2(6)
ZIP_CODE                                VARCHAR2(5)
ISSUE_DATE                              DATE
COMPLY_DATE                             DATE
FOLLOW_UP_ACTION                        NUMBER(2)
ACTION                                  NUMBER(2)
STATUS                                  VARCHAR2(1)
CODE_ID                                 VARCHAR2(5)
VIOLATION_ID                            VARCHAR2(10)
VIOLATION                               VARCHAR2(30)
LEGAL1                                  VARCHAR2(40)
LEGAL2                                  VARCHAR2(40)
SUBDIV_ID                               VARCHAR2(5)
NSA_ID                                  VARCHAR2(5)
PARCEL_ID                               VARCHAR2(11)
SEGMENT_ID                              NUMBER(8)
VERIFY_CODE                             NUMBER(4)
COUNCIL_DISTRICT                        VARCHAR2(1)
INSPECT_AREA                            VARCHAR2(2)
INSPECTOR                               VARCHAR2(25)
INSTIGATOR                              VARCHAR2(1)
SQLWKS> 	desc NSA_CODE_INSPECT_2000;         
Column Name                    Null?    Type
------------------------------ -------- ----
CASE_NUMBER                             NUMBER(10)
INSPECTION_DATE                         DATE
CASE_CLOSED_DATE                        DATE
ADDR_NUM                                NUMBER(6)
ADDR_PFX                                VARCHAR2(2)
ADDR_NAME                               VARCHAR2(40)
ADDR_TYPE                               VARCHAR2(4)
ADDR_SFX                                VARCHAR2(2)
UNIT_CODE                               VARCHAR2(6)
UNIT_NUM                                VARCHAR2(6)
ZIP_CODE                                VARCHAR2(5)
ISSUE_DATE                              DATE
COMPLY_DATE                             DATE
ACTION                                  NUMBER(2)
FOLLOW_UP_ACTION                        NUMBER(2)
STATUS                                  VARCHAR2(1)
CODE_ID                                 VARCHAR2(5)
VIOLATION_ID                            VARCHAR2(10)
VIOLATION                               VARCHAR2(30)
INSPECTOR                               VARCHAR2(25)
LEGAL1                                  VARCHAR2(35)
LEGAL2                                  VARCHAR2(35)
INSPECT_AREA                            VARCHAR2(2)
COUNCIL_ID                              VARCHAR2(1)
SUBDIV_ID                               VARCHAR2(5)
NSA_ID                                  VARCHAR2(5)
PARCEL_ID                               VARCHAR2(11)
SEGMENT_ID                              NUMBER(6)
VERIFY_CODE                             NUMBER(2)
INSTIGATOR                              VARCHAR2(1)
SQLWKS> 	desc NSA_CODE_RENTAL;               
Column Name                    Null?    Type
------------------------------ -------- ----
PARCEL_ID                               VARCHAR2(12)
ADDR_NUM                                NUMBER
ADDR_PFX                                VARCHAR2(2)
ADDR_NAME                               VARCHAR2(80)
ADDR_TYPE                               VARCHAR2(4)
ADDR_SFX                                VARCHAR2(2)
ADDRESS                                 VARCHAR2(80)
CERTIFY_NUM                             NUMBER
CERTIFY_DATE                            VARCHAR2(20)
OCCUPY_DATE                             VARCHAR2(20)
OCCUPY_COUNT                            NUMBER
SELF_INSPECT_DATE                       VARCHAR2(20)
OWNER_ADDRESS                           VARCHAR2(80)
OWNER_NAME                              VARCHAR2(80)
LICENSE_NUM                             VARCHAR2(20)
ISSUE_ST                                VARCHAR2(20)
ADDR_UNIT                               VARCHAR2(5)
SEGMENT_ID                              NUMBER
VERIFY_CODE                             NUMBER
SQLWKS> 	desc NSA_CODE_VIOLATION;            
Column Name                    Null?    Type
------------------------------ -------- ----
CASE_NUMBER                             NUMBER
ADDR_NUM                                NUMBER
ADDR_PFX                                VARCHAR2(2)
ADDR_NAME                               VARCHAR2(40)
ADDR_TYPE                               VARCHAR2(4)
ADDR_SFX                                VARCHAR2(2)
ADDR_CODE                               VARCHAR2(3)
ADDR_UNIT                               VARCHAR2(5)
INSPECT_DATE                            DATE
ISSUE_DATE                              DATE
COMPLY_DATE                             DATE
VIOLATION                               VARCHAR2(30)
ACTION                                  NUMBER
STATUS                                  VARCHAR2(1)
COUNCIL_ID                              VARCHAR2(1)
SUBDIV_ID                               VARCHAR2(5)
INSPECT_AREA                            VARCHAR2(2)
LEGAL1                                  VARCHAR2(35)
LEGAL2                                  VARCHAR2(35)
PARCEL_ID                               VARCHAR2(11)
SEGMENT_ID                              NUMBER
VERIFY_CODE                             NUMBER
RENTAL_REGISTRATION                     NUMBER
SQLWKS> 	desc NSA_CRIME;                     
Column Name                    Null?    Type
------------------------------ -------- ----
LWMAINID                                NUMBER
DATE_OCCU                               DATE
PARCEL_ID                               VARCHAR2(12)
SEGMENT_ID                              NUMBER
VERIFY_ID                               NUMBER
UCR_CODE                                VARCHAR2(4)
UCR_GROUP                               VARCHAR2(4)
UCR_DESC                                VARCHAR2(60)
POLICE_BEAT                             VARCHAR2(3)
LEGAL1                                  VARCHAR2(60)
LEGAL2                                  VARCHAR2(60)
ADDR_NUM                                NUMBER
ADDR_PFX                                VARCHAR2(2)
ADDR_NAME                               VARCHAR2(40)
ADDR_TYPE                               VARCHAR2(4)
ADDR_SFX                                VARCHAR2(2)
ADDR_UNIT                               VARCHAR2(5)
XSTR_PFX                                VARCHAR2(2)
XSTR_NAME                               VARCHAR2(40)
XSTR_TYPE                               VARCHAR2(4)
XSTR_SFX                                VARCHAR2(2)
DATE_REPT                               DATE
SQLWKS> 	desc NSA_DCAD_RES;                  
Column Name                    Null?    Type
------------------------------ -------- ----
SUBDIV_ID                               VARCHAR2(5)
NSA_ID                                  VARCHAR2(5)
PARCEL_ID                               VARCHAR2(11)
PARCEL_                                 NUMBER(11)
ACCT                                    VARCHAR2(17)
NBHD                                    VARCHAR2(6)
OLD_RGN                                 NUMBER(2)
NBHD_CODE                               VARCHAR2(3)
PROP_CLASS                              NUMBER(4)
BLDG_CLASS                              NUMBER(4)
SUB_CLASS1                              VARCHAR2(1)
SUB_CLASS2                              VARCHAR2(1)
DEED_X_DT                               DATE
DEED_CG_DT                              DATE
DEED_CHGCD                              VARCHAR2(1)
STR_CTY_CD                              VARCHAR2(2)
LGL1_DESC                               VARCHAR2(33)
LGL2_DESC                               VARCHAR2(33)
LGL3_DESC                               VARCHAR2(33)
LGL4_DESC                               VARCHAR2(33)
LGL5_DESC                               VARCHAR2(33)
JNL_ENTRY                               NUMBER(4)
MAPSCO_CDS                              VARCHAR2(5)
CNTY                                    VARCHAR2(2)
CITY                                    VARCHAR2(2)
HOSP                                    VARCHAR2(2)
COLG                                    VARCHAR2(2)
ISD                                     VARCHAR2(2)
TAX_REP                                 VARCHAR2(3)
MKT_VALUE                               NUMBER(11)
IMPV_VALUE                              NUMBER(9)
APPSR_DATE                              DATE
LNDAREA1FL                              VARCHAR2(1)
LAND_AREA1                              NUMBER(8)
FRONTAGE1                               NUMBER(8)
LAND_DPTH1                              NUMBER(8)
LAND1PRCFL                              VARCHAR2(1)
LAND1____                               NUMBER(11)
ALPS_ADJ_1                              NUMBER(9)
LIVING_AR                               NUMBER(8)
LIVNG_UNIT                              NUMBER(2)
YEAR_BUILT                              NUMBER(5)
BLDG_PRICE                              NUMBER(9)
BLDG_DEPRE                              NUMBER(4)
FRAME_WORK                              VARCHAR2(2)
FOUNDATION                              VARCHAR2(2)
BASEMENT                                VARCHAR2(2)
EXT_WALL_1                              VARCHAR2(2)
EXT_WALL_2                              VARCHAR2(2)
ROOF_TYPE                               VARCHAR2(2)
ROOF_COMP                               VARCHAR2(2)
FULL_BATHS                              NUMBER(4)
HALF_BATHS                              NUMBER(4)
NUM_OF_KIT                              NUMBER(2)
AC_TYPE                                 VARCHAR2(2)
HEAT                                    VARCHAR2(2)
SV_QTR_AGE                              NUMBER(4)
FIREPLACE                               NUMBER(4)
POOL_PRICE                              NUMBER(6)
NB_CST_FAC                              NUMBER(4)
EF_AG_NCRN                              NUMBER(4)
RENDITION                               VARCHAR2(2)
RENDRD_AMT                              NUMBER(11)
PV_CNTRB__                              NUMBER(9)
APROCH_FIN                              VARCHAR2(1)
LAST_OPER                               VARCHAR2(3)
LST_UPD_DT                              DATE
ARB_FLAG                                VARCHAR2(1)
CRNT_PMTCD                              VARCHAR2(1)
CRNT_PMTDT                              DATE
CRNT_PMTVL                              NUMBER(9)
CRNT_APSR                               VARCHAR2(3)
PREV_PMTCD                              VARCHAR2(1)
PREV_PMTDT                              DATE
PREV_PMTVL                              NUMBER(9)
PREV_APSR                               VARCHAR2(3)
PRV2_PMTCD                              VARCHAR2(1)
PRV2_PMTDT                              DATE
PRV2_PMTVL                              NUMBER(9)
PRV2_APSR                               VARCHAR2(3)
CRNT_SALPR                              NUMBER(9)
CRNT_SALDT                              DATE
PREV_SALPR                              NUMBER(9)
PREV_SALDT                              DATE
ALPS_AJ_1                               NUMBER(3)
ALPS_SPTB                               VARCHAR2(3)
GARAGE_PRT                              VARCHAR2(1)
GARGE1_AR                               NUMBER(6)
GARGE1_DEP                              NUMBER(4)
GARGE1_PRF                              VARCHAR2(1)
GARGE1_PRC                              NUMBER(6)
GARGE1_LOC                              VARCHAR2(2)
GARGE1_MTL                              VARCHAR2(2)
GARGE1_FLR                              VARCHAR2(2)
GARGE_PRT2                              VARCHAR2(1)
GARGE2_AR                               NUMBER(6)
GARGE2_DPR                              NUMBER(4)
GARGE2_PRF                              VARCHAR2(1)
GARGE2_PRC                              NUMBER(6)
GARGE2_LOC                              VARCHAR2(2)
GARGE2_MTL                              VARCHAR2(2)
GARGE2_FLR                              VARCHAR2(2)
AC_BLD1_DS                              VARCHAR2(25)
AC_BLD1_MN                              NUMBER(6)
AC_BLD1_UP                              NUMBER(6)
AC_BLD1_FP                              NUMBER(6)
AC_BLD1_PC                              NUMBER(6)
AC_BLD1_DP                              NUMBER(4)
ACCES2_BLD                              VARCHAR2(1)
AC_BLD2_DS                              VARCHAR2(25)
CUR_SL_TYP                              VARCHAR2(1)
DISABL_EX1                              VARCHAR2(1)
HMSTD_EX_1                              VARCHAR2(1)
OVR_65_EX1                              VARCHAR2(1)
WATER_CD                                VARCHAR2(2)
WASTE_CD                                VARCHAR2(2)
APR_CLKNAM                              VARCHAR2(17)
DCAD_EMPLY                              VARCHAR2(1)
CONTRB_VAL                              NUMBER(11)
AG_INDCATR                              VARCHAR2(1)
CNTY_SPLIT                              NUMBER(3)
CITY_SPLIT                              NUMBER(3)
ISD_SPLIT                               NUMBER(3)
HOSP_SPLIT                              NUMBER(3)
COLL_SPLIT                              NUMBER(3)
SPEC_SPLIT                              NUMBER(3)
TAXP_ADDR1                              VARCHAR2(25)
TAXP_ADDR2                              VARCHAR2(25)
TAXP_ADDR3                              VARCHAR2(25)
TAXP_CITY                               VARCHAR2(23)
TAXP_STATE                              VARCHAR2(2)
TAXP_ZIPCD                              VARCHAR2(9)
TXCEL_AMT1                              NUMBER(10)
TXCEL_DTE1                              NUMBER(9)
CAP_HMSTD1                              NUMBER(10)
DEFER_CAP1                              NUMBER(10)
REVAL_YEAR                              NUMBER(5)
PV_RVAL_YR                              NUMBER(5)
CITY_ACCT_                              VARCHAR2(25)
CNTY_ACCT_                              VARCHAR2(17)
GIS_ACCT_                               VARCHAR2(17)
STREET_NAM                              VARCHAR2(23)
STREET_TYP                              VARCHAR2(4)
STREET_DIR                              VARCHAR2(2)
STREET_NUM                              NUMBER(20)
STREET_SFX                              VARCHAR2(50)
VERIFY_ID                               NUMBER(4)
SQLWKS> 	desc NSA_TAX_ALIAS;                 
Column Name                    Null?    Type
------------------------------ -------- ----
DCAD_ACCT                               VARCHAR2(17)
ADDR_NUM                                NUMBER(5)
ADDR_PFX                                VARCHAR2(2)
ADDR_NAME                               VARCHAR2(20)
ADDR_TYPE                               VARCHAR2(4)
ADDR_SFX                                VARCHAR2(2)
PARCEL_ID                               VARCHAR2(11)
VERIFY_ID                               NUMBER(3)
SQLWKS> 	desc NSA_TAX_CITY;                  
Column Name                    Null?    Type
------------------------------ -------- ----
DCAD_ACCT                               VARCHAR2(17)
OWNER_NAME1                             VARCHAR2(40)
OWNER_NAME2                             VARCHAR2(40)
PARCEL_ID                               VARCHAR2(11)
ADDR_NUM                                NUMBER(5)
ADDR_PFX                                VARCHAR2(2)
ADDR_NAME                               VARCHAR2(20)
ADDR_TYPE                               VARCHAR2(4)
ADDR_SFX                                VARCHAR2(2)
UNIT_TYPE                               VARCHAR2(5)
UNIT_NUM                                VARCHAR2(5)
LEGAL_DESC                              VARCHAR2(600)
LEGAL_BLOCK                             VARCHAR2(3)
LEGAL_LOT                               VARCHAR2(3)
MAIL_ADDR                               VARCHAR2(40)
MAIL_CITY                               VARCHAR2(40)
MAIL_STATE                              VARCHAR2(2)
MAIL_ZIP                                VARCHAR2(10)
ASSESS_AMT                              NUMBER(9,2)
TAX_AMT                                 NUMBER(9,2)
PAID_AMT                                NUMBER(9,2)
PAYMENT_DATE                            DATE
MORTGAGE                                VARCHAR2(3)
LENDER                                  VARCHAR2(5)
AGENT                                   VARCHAR2(3)
VERIFY_ID                               NUMBER(3)
SUBDIV_ID                               VARCHAR2(5)
SQLWKS> 	desc NSA_TAX_SUMMARY;               
Column Name                    Null?    Type
------------------------------ -------- ----
SUBDIV_ID                               VARCHAR2(5)
TTL_HOMES                               NUMBER
AVG_YEAR_BUILT                          NUMBER
AVG_MARKEY_VALUE                        NUMBER
TTL_SQ_FOOTAGE                          NUMBER
AVG_SQ_FOOTAGE                          NUMBER
AVG_VALUE_PER_SQFT                      NUMBER
PCT_SINGLE_FAM_RENTAL                   NUMBER
TTL_HOMES_SOLD                          NUMBER
TURNOVER_RATE                           NUMBER
TTL_APPRAISE_VALUE                      NUMBER
AVG_APPRAISE_VALUE                      NUMBER
AVG_APPRAISE_PER_SQFT                   NUMBER
AVG_TAXES_PER_HOME                      NUMBER
SQLWKS> 	desc N_PAVE_MAST;                   
Column Name                    Null?    Type
------------------------------ -------- ----
CATEGORY                       NOT NULL VARCHAR2(1)
BRANCH                         NOT NULL NUMBER(4)
SECTION_NO                     NOT NULL NUMBER(4)
SEGMENT                                 NUMBER(4)
LENG                                    NUMBER(5)
LANES                                   NUMBER(2,1)
SURF_TYPE                               VARCHAR2(3)
REAR_ENTRY                              VARCHAR2(1)
CDBG                                    VARCHAR2(1)
CONST_DATE                              DATE
LAST_INSPECT_DATE                       DATE
NEXT_INSPECT_DATE                       DATE
PCI                                     NUMBER(5,2)
CLASS                                   VARCHAR2(10)
CRACK_SEAL                              VARCHAR2(1)
DISTRESSES                              NUMBER(4)
POT_HOLE_REQ                            VARCHAR2(1)
COUN_DIST                               NUMBER(2)
THOR_TYPE                               VARCHAR2(2)
ADDR_NUM                                NUMBER(6)
ADDR_PFX                                VARCHAR2(2)
ADDR_NAME                               VARCHAR2(40)
ADDR_TYPE                               VARCHAR2(4)
ADDR_SFX                                VARCHAR2(2)
FROM_ADDR_NUM                           NUMBER(6)
FROM_ADDR_PFX                           VARCHAR2(2)
FROM_ADDR_NAME                          VARCHAR2(40)
FROM_ADDR_TYPE                          VARCHAR2(4)
FROM_ADDR_SFX                           VARCHAR2(2)
TO_ADDR_NUM                             NUMBER(6)
TO_ADDR_PFX                             VARCHAR2(2)
TO_ADDR_NAME                            VARCHAR2(40)
TO_ADDR_TYPE                            VARCHAR2(4)
TO_ADDR_SFX                             VARCHAR2(2)
REMARKS                                 VARCHAR2(40)
SQLWKS> 	desc PARK;                          
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
AREA_NAME                               VARCHAR2(30)
AREA_TYPE                               VARCHAR2(20)
ADDRESS                                 VARCHAR2(30)
SQLWKS> 	desc PAVEMENT_MASTER;               
Column Name                    Null?    Type
------------------------------ -------- ----
CATEGORY                       NOT NULL VARCHAR2(1)
BRANCH                         NOT NULL NUMBER(38)
SECTION                        NOT NULL NUMBER(38)
MSLINK                                  NUMBER(38)
LEN                                     NUMBER(5)
LANES                                   NUMBER(3,1)
SURFACE                                 VARCHAR2(6)
REAR_ENTRY                              VARCHAR2(1)
COUNCIL_DISTRICT                        NUMBER(2)
CONST_DATE                              DATE
ADDR_NUM                                NUMBER(6)
ADDR_PFX                                VARCHAR2(2)
ADDR_NAME                               VARCHAR2(20)
ADDR_TYPE                               VARCHAR2(4)
ADDR_SFX                                VARCHAR2(3)
FROM_ADDR_NUM                           NUMBER(6)
FROM_ADDR_PFX                           VARCHAR2(2)
FROM_ADDR_NAME                          VARCHAR2(20)
FROM_ADDR_TYPE                          VARCHAR2(4)
FROM_ADDR_SFX                           VARCHAR2(3)
TO_ADDR_NUM                             NUMBER(6)
TO_ADDR_PFX                             VARCHAR2(2)
TO_ADDR_NAME                            VARCHAR2(20)
TO_ADDR_TYPE                            VARCHAR2(4)
TO_ADDR_SFX                             VARCHAR2(3)
CLASS                                   VARCHAR2(10)
CRACK_SEAL                              VARCHAR2(1)
DISTRESSES                              NUMBER(38)
LAST_INSPECTION_DATE                    DATE
NEXT_INSPECTION_DATE                    DATE
PCI                                     NUMBER(38)
CDBG                                    VARCHAR2(1)
THOR_TYPE                               VARCHAR2(1)
SEGMENT                                 NUMBER(38)
POT_HOLE_REQUEST                        VARCHAR2(1)
INSPECT_STATUS                          VARCHAR2(1)
REMARKS                                 VARCHAR2(40)
SQLWKS> 	desc PAVE_CUST;                     
Column Name                    Null?    Type
------------------------------ -------- ----
PROJ_YEAR                      NOT NULL NUMBER(4)
PROJ_SEQ                       NOT NULL NUMBER(4)
NAME_LAST                               VARCHAR2(20)
NAME_FIRST                              VARCHAR2(20)
NAME_MI                                 VARCHAR2(2)
SALUTATION                              VARCHAR2(5)
ADDR_NUM                                NUMBER(6)
ADDR_PFX                                VARCHAR2(2)
ADDR_NAME                               VARCHAR2(20)
ADDR_TYPE                               VARCHAR2(4)
ADDR_SFX                                VARCHAR2(2)
UNIT_TYPE                               VARCHAR2(10)
UNIT_NUM                                VARCHAR2(20)
CITY                                    VARCHAR2(12)
STATE                                   VARCHAR2(2)
ZIP_CODE                                NUMBER(5)
ZIP_PLUS                                NUMBER(4)
PHONE1                                  VARCHAR2(7)
AREA_CODE1                              VARCHAR2(3)
PHONE2                                  VARCHAR2(7)
AREA_CODE2                              VARCHAR2(3)
PHONE1_ID                               VARCHAR2(10)
PHONE2_ID                               VARCHAR2(10)
SQLWKS> 	desc PAVE_CUST_ARCH;                
Column Name                    Null?    Type
------------------------------ -------- ----
PROJ_YEAR                               NUMBER(4)
PROJ_SEQ                                NUMBER(4)
NAME_LAST                               VARCHAR2(20)
NAME_FIRST                              VARCHAR2(20)
NAME_MI                                 VARCHAR2(2)
SALUTATION                              VARCHAR2(5)
ADDR_NUM                                NUMBER(6)
ADDR_PFX                                VARCHAR2(2)
ADDR_NAME                               VARCHAR2(20)
ADDR_TYPE                               VARCHAR2(4)
ADDR_SFX                                VARCHAR2(2)
UNIT_TYPE                               VARCHAR2(10)
UNIT_NUM                                VARCHAR2(20)
CITY                                    VARCHAR2(12)
STATE                                   VARCHAR2(2)
ZIP_CODE                                NUMBER(5)
ZIP_PLUS                                NUMBER(4)
PHONE1                                  VARCHAR2(7)
AREA_CODE1                              VARCHAR2(3)
PHONE2                                  VARCHAR2(7)
AREA_CODE2                              VARCHAR2(3)
PHONE1_ID                               VARCHAR2(10)
PHONE2_ID                               VARCHAR2(10)
SQLWKS> 	desc PAVE_MAST;                     
Column Name                    Null?    Type
------------------------------ -------- ----
CATEGORY                       NOT NULL VARCHAR2(1)
BRANCH                         NOT NULL NUMBER(4)
SECTION                        NOT NULL NUMBER(4)
SEGMENT                                 NUMBER(4)
LENG                                    NUMBER(5)
LANES                                   NUMBER(2,1)
SURF_TYPE                               VARCHAR2(3)
REAR_ENTRY                              VARCHAR2(1)
CDBG                                    VARCHAR2(1)
CONST_DATE                              DATE
LAST_INSPECT_DATE                       DATE
NEXT_INSPECT_DATE                       DATE
PCI                                     NUMBER(5,2)
CLASS                                   VARCHAR2(10)
CRACK_SEAL                              VARCHAR2(1)
DISTRESSES                              NUMBER(4)
POT_HOLE_REQ                            VARCHAR2(1)
COUN_DIST                               NUMBER(2)
THOR_TYPE                               VARCHAR2(2)
ADDR_NUM                                NUMBER(6)
ADDR_PFX                                VARCHAR2(2)
ADDR_NAME                               VARCHAR2(40)
ADDR_TYPE                               VARCHAR2(4)
ADDR_SFX                                VARCHAR2(2)
FROM_ADDR_NUM                           NUMBER(6)
FROM_ADDR_PFX                           VARCHAR2(2)
FROM_ADDR_NAME                          VARCHAR2(40)
FROM_ADDR_TYPE                          VARCHAR2(4)
FROM_ADDR_SFX                           VARCHAR2(2)
TO_ADDR_NUM                             NUMBER(6)
TO_ADDR_PFX                             VARCHAR2(2)
TO_ADDR_NAME                            VARCHAR2(40)
TO_ADDR_TYPE                            VARCHAR2(4)
TO_ADDR_SFX                             VARCHAR2(2)
REMARKS                                 VARCHAR2(40)
MISSING_SDWK                            VARCHAR2(1)
THOR_TYPE_NEW                           VARCHAR2(2)
CPI_YN                                  VARCHAR2(1)
SQLWKS> 	desc PAVE_MAST_TEST;                
Column Name                    Null?    Type
------------------------------ -------- ----
CATEGORY                       NOT NULL VARCHAR2(1)
BRANCH                         NOT NULL NUMBER(4)
SECTION                        NOT NULL NUMBER(4)
SEGMENT                                 NUMBER(4)
LENG                                    NUMBER(5)
LANES                                   NUMBER(2,1)
SURF_TYPE                               VARCHAR2(3)
REAR_ENTRY                              VARCHAR2(1)
CDBG                                    VARCHAR2(1)
CONST_DATE                              DATE
LAST_INSPECT_DATE                       DATE
NEXT_INSPECT_DATE                       DATE
PCI                                     NUMBER(5,2)
CLASS                                   VARCHAR2(10)
CRACK_SEAL                              VARCHAR2(1)
DISTRESSES                              NUMBER(4)
POT_HOLE_REQ                            VARCHAR2(1)
COUN_DIST                               NUMBER(2)
THOR_TYPE                               VARCHAR2(2)
ADDR_NUM                                NUMBER(6)
ADDR_PFX                                VARCHAR2(2)
ADDR_NAME                               VARCHAR2(40)
ADDR_TYPE                               VARCHAR2(4)
ADDR_SFX                                VARCHAR2(2)
FROM_ADDR_NUM                           NUMBER(6)
FROM_ADDR_PFX                           VARCHAR2(2)
FROM_ADDR_NAME                          VARCHAR2(40)
FROM_ADDR_TYPE                          VARCHAR2(4)
FROM_ADDR_SFX                           VARCHAR2(2)
TO_ADDR_NUM                             NUMBER(6)
TO_ADDR_PFX                             VARCHAR2(2)
TO_ADDR_NAME                            VARCHAR2(40)
TO_ADDR_TYPE                            VARCHAR2(4)
TO_ADDR_SFX                             VARCHAR2(2)
REMARKS                                 VARCHAR2(40)
MISSING_SDWK                            VARCHAR2(1)
THOR_TYPE_NEW                           VARCHAR2(2)
SQLWKS> 	desc PAVE_PROJ;                     
Column Name                    Null?    Type
------------------------------ -------- ----
PROJ_YEAR                      NOT NULL NUMBER(4)
PROJ_SEQ                       NOT NULL NUMBER(4)
CATEGORY                                VARCHAR2(1)
BRANCH                                  NUMBER(4)
SECTION                                 NUMBER(4)
SEGMENT                                 NUMBER(4)
STATUS                                  VARCHAR2(8)
RCVD_BY                                 VARCHAR2(10)
REQ_DATE                                DATE
TIMESTAMP                               DATE
COUN_DIST                               NUMBER(2)
ADDR_NUM                                NUMBER(6)
ADDR_PFX                                VARCHAR2(2)
ADDR_NAME                               VARCHAR2(20)
ADDR_TYPE                               VARCHAR2(4)
ADDR_SFX                                VARCHAR2(2)
XST1_NUM                                NUMBER(6)
XST1_PFX                                VARCHAR2(2)
XST1_NAME                               VARCHAR2(20)
XST1_TYPE                               VARCHAR2(4)
XST1_SFX                                VARCHAR2(2)
XST2_NUM                                NUMBER(6)
XST2_PFX                                VARCHAR2(2)
XST2_NAME                               VARCHAR2(20)
XST2_TYPE                               VARCHAR2(4)
XST2_SFX                                VARCHAR2(2)
PLACE_NAME                              VARCHAR2(80)
REMARKS                                 VARCHAR2(70)
SFG_NUMBER                              NUMBER(4)
SFG_SEQ                                 NUMBER(4)
CONTR_FLAG                              VARCHAR2(1)
LOCATION                                VARCHAR2(70)
DESCRIPTION                             VARCHAR2(70)
SQLWKS> 	desc PAVE_PROJ_APPR;                
Column Name                    Null?    Type
------------------------------ -------- ----
CATEGORY                       NOT NULL VARCHAR2(1)
BRANCH                         NOT NULL NUMBER(4)
SECTION                        NOT NULL NUMBER(4)
SEGMENT                                 NUMBER(4)
RCVD_BY                                 VARCHAR2(10)
REQ_DATE                                DATE
SFG_NUMBER                     NOT NULL NUMBER(4)
LOCATION                                VARCHAR2(70)
DESCRIPTION                             VARCHAR2(70)
SQLWKS> 	desc PAVE_PROJ_ARCH;                
Column Name                    Null?    Type
------------------------------ -------- ----
PROJ_YEAR                               NUMBER(4)
PROJ_SEQ                                NUMBER(4)
CATEGORY                                VARCHAR2(1)
BRANCH                                  NUMBER(4)
SECTION                                 NUMBER(4)
SEGMENT                                 NUMBER(4)
STATUS                                  VARCHAR2(8)
RCVD_BY                                 VARCHAR2(10)
REQ_DATE                                DATE
TIME_STAMP                              DATE
REMARKS                                 VARCHAR2(70)
COUN_DIST                               NUMBER(2)
ADDR_NUM                                NUMBER(6)
ADDR_PFX                                VARCHAR2(2)
ADDR_NAME                               VARCHAR2(20)
ADDR_TYPE                               VARCHAR2(4)
ADDR_SFX                                VARCHAR2(2)
XST1_NUM                                NUMBER(6)
XST1_PFX                                VARCHAR2(2)
XST1_NAME                               VARCHAR2(20)
XST1_TYPE                               VARCHAR2(4)
XST1_SFX                                VARCHAR2(2)
XST2_NUM                                NUMBER(6)
XST2_PFX                                VARCHAR2(2)
XST2_NAME                               VARCHAR2(20)
XST2_TYPE                               VARCHAR2(4)
XST2_SFX                                VARCHAR2(2)
PLACE_NAME                              VARCHAR2(80)
SFG_NUMBER                              NUMBER(4)
SFG_SEQ                                 NUMBER(4)
CONTR_FLAG                              VARCHAR2(1)
LOCATION                                VARCHAR2(70)
DESCRIPTION                             VARCHAR2(70)
TIME_CLOSED                             DATE
SQLWKS> 	desc PAVE_SURF_MAST;                
Column Name                    Null?    Type
------------------------------ -------- ----
CATEGORY                       NOT NULL VARCHAR2(1)
SURF_TYPE                      NOT NULL VARCHAR2(3)
INSPECT_INTERVAL                        NUMBER(2)
CONT_REPAIR                             NUMBER(5)
CONT_REPLACE                            NUMBER(5)
IRR_REPAIR                              NUMBER(5)
IRR_REPLACE                             NUMBER(5)
MAT_REPAIR                              NUMBER(5)
MAT_REPLACE                             NUMBER(5)
SQLWKS> 	desc PAVE_TASK;                     
Column Name                    Null?    Type
------------------------------ -------- ----
PROJ_YEAR                      NOT NULL NUMBER(4)
PROJ_SEQ                       NOT NULL NUMBER(4)
SUBTASK_SFG_NUM                NOT NULL NUMBER(38)
TASK_SEQ                                NUMBER(3)
EST_START_DATE                          DATE
ACT_START_DATE                          DATE
EST_END_DATE                            DATE
ACT_END_DATE                            DATE
EST_DURATION                            NUMBER(8,3)
ACT_DURATION                            NUMBER(8,3)
EST_TOTL_UNITS                          NUMBER(8,3)
ACT_TOTL_UNITS                          NUMBER(8,3)
PROJ_INFO                               VARCHAR2(120)
SQLWKS> 	desc PLAN_TABLE;                    
Column Name                    Null?    Type
------------------------------ -------- ----
STATEMENT_ID                            VARCHAR2(30)
TIMESTAMP                               DATE
REMARKS                                 VARCHAR2(80)
OPERATION                               VARCHAR2(30)
OPTIONS                                 VARCHAR2(30)
OBJECT_NODE                             VARCHAR2(128)
OBJECT_OWNER                            VARCHAR2(30)
OBJECT_NAME                             VARCHAR2(30)
OBJECT_INSTANCE                         NUMBER(38)
OBJECT_TYPE                             VARCHAR2(30)
OPTIMIZER                               VARCHAR2(255)
SEARCH_COLUMNS                          NUMBER
ID                                      NUMBER(38)
PARENT_ID                               NUMBER(38)
POSITION                                NUMBER(38)
COST                                    NUMBER(38)
CARDINALITY                             NUMBER(38)
BYTES                                   NUMBER(38)
OTHER_TAG                               VARCHAR2(255)
PARTITION_START                         VARCHAR2(255)
PARTITION_STOP                          VARCHAR2(255)
PARTITION_ID                            NUMBER(38)
OTHER                                   LONG
SQLWKS> 	desc RANGE_DOMAIN;                  
Column Name                    Null?    Type
------------------------------ -------- ----
RDOMAIN                        NOT NULL NUMBER(10)
MIN_VALUE                      NOT NULL NUMBER
MAX_VALUE                      NOT NULL NUMBER
SQLWKS> 	desc RMS_LOMAIN;                    
Column Name                    Null?    Type
------------------------------ -------- ----
LOMAINID                                NUMBER
ADDR_NUM                                VARCHAR2(10)
ADDR_PFX                                VARCHAR2(10)
ADDR_NAME                               VARCHAR2(40)
ADDR_TYPE                               VARCHAR2(20)
ADDR_SFX                                VARCHAR2(10)
ADDR_UNIT                               VARCHAR2(10)
ROW_ID                                  ROWID
SQLWKS> 	desc RQST_USER_LOG;                 
Column Name                    Null?    Type
------------------------------ -------- ----
USER_NAME                      NOT NULL VARCHAR2(8)
USER_PWD                       NOT NULL VARCHAR2(8)
USER_TYPE                      NOT NULL VARCHAR2(8)
SQLWKS> 	desc SANI_ASSET;                    
Column Name                    Null?    Type
------------------------------ -------- ----
REC_KEY                                 NUMBER
ADDR_NUM                                VARCHAR2(5)
ADDR_PFX                                VARCHAR2(2)
ADDR_NAME                               VARCHAR2(30)
ADDR_TYPE                               VARCHAR2(4)
BUSI_NAME                               VARCHAR2(40)
BUSI_TYPE                               VARCHAR2(40)
PARCEL_ID                               VARCHAR2(11)
ADDR_CODE                               VARCHAR2(6)
ADDR_UNIT                               VARCHAR2(10)
SQLWKS> 	desc SANI_COMMERCIAL;               
Column Name                    Null?    Type
------------------------------ -------- ----
REC_KEY                                 NUMBER
ADDR_NUM                                VARCHAR2(5)
ADDR_PFX                                VARCHAR2(2)
ADDR_NAME                               VARCHAR2(30)
ADDR_TYPE                               VARCHAR2(4)
ADDR_SFX                                VARCHAR2(2)
BUSI_NAME                               VARCHAR2(40)
BUSI_TYPE                               VARCHAR2(40)
PARCEL_ID                               VARCHAR2(11)
SQLWKS> 	desc SNGLFAM_RENTAL;                
Column Name                    Null?    Type
------------------------------ -------- ----
ADDR_NUM                                NUMBER(10)
ADDR_PFX                                VARCHAR2(2)
ADDR_NAME                               VARCHAR2(40)
ADDR_TYPE                               VARCHAR2(4)
ADDR_SFX                                VARCHAR2(2)
TAX_OWNER                               VARCHAR2(40)
MAIL_ADDR                               VARCHAR2(40)
MAIL_CITY                               VARCHAR2(30)
UMS_OCCUPANT                            VARCHAR2(30)
LAND_USE_CODE                           VARCHAR2(4)
SQLWKS> 	desc SURFACE_MASTER;                
Column Name                    Null?    Type
------------------------------ -------- ----
SURFACE_TYPE                   NOT NULL VARCHAR2(3)
CONT_REPAIR                             NUMBER(7,2)
CONT_REPLACE                            NUMBER(7,2)
IRR_REPAIR                              NUMBER(7,2)
IRR_REPLACE                             NUMBER(7,2)
MATERIAL_REPAIR                         NUMBER(7,2)
MATERIAL_REPLACE                        NUMBER(7,2)
INSPECTION_INTERVAL                     NUMBER(2)
CATEGORY                       NOT NULL VARCHAR2(1)
SQLWKS> 	desc TAX_ABSTRACT;                  
Column Name                    Null?    Type
------------------------------ -------- ----
PARCEL_ID                      NOT NULL VARCHAR2(11)
DCAD_ACCT                               VARCHAR2(17)
COG_ACCT                                VARCHAR2(11)
SQLWKS> 	desc TAX_SUBDIV_ID;                 
Column Name                    Null?    Type
------------------------------ -------- ----
SUBDIV_ID                               VARCHAR2(5)
SUBDIV_NAME                             VARCHAR2(38)
NSA_ID                                  VARCHAR2(5)
NSA_NAME                                VARCHAR2(38)
SQLWKS> 	desc TAX_UB;                        
Column Name                    Null?    Type
------------------------------ -------- ----
SUBDIVKEY                               VARCHAR2(15)
TAXPAYER_NAME                           VARCHAR2(40)
DCAD_ACCOUNT                            VARCHAR2(17)
TAXPAYER_ADDRESS2                       VARCHAR2(30)
TAXPAYER_ADDRESS_CITY                   VARCHAR2(15)
TAXPAYER_ADDRESS_STATE                  VARCHAR2(2)
TAXPAYER_ADDRESS_ZIP                    VARCHAR2(10)
STREET_NUMBER                           NUMBER(6)
STREET_PREFIX                           VARCHAR2(1)
STREET_NAME                             VARCHAR2(30)
STREET_TYPE                             VARCHAR2(4)
STREET_SUFFIX                           VARCHAR2(1)
PROPERTY_ADDR_ZIP                       VARCHAR2(10)
BILLAMT                                 NUMBER
BILLASSD                                NUMBER
OCCUPANT_NAME                           VARCHAR2(30)
DL                                      VARCHAR2(13)
SSN                                     VARCHAR2(11)
PARCEL_ID                               VARCHAR2(12)
SQLWKS> 	desc TEST_JOHN;                     
Column Name                    Null?    Type
------------------------------ -------- ----
ADDR_PFX                                VARCHAR2(2)
ADDR_NAME                               VARCHAR2(20)
ADDR_TYPE                               VARCHAR2(4)
ADDR_SFX                                VARCHAR2(2)
STREET_ID                               NUMBER(8)
ADDR_COMPRESS                           VARCHAR2(20)
ADDR_COMPACT                            VARCHAR2(20)
ADDR_REDUCED                            VARCHAR2(20)
ADDR_ENDING                             VARCHAR2(20)
ADDR_SOUNDEX                            VARCHAR2(4)
ADDR_PERMUTE                            NUMBER
SQLWKS> 	desc TMP_APP_ADDRESS;               
Column Name                    Null?    Type
------------------------------ -------- ----
USER_KEY                                VARCHAR2(40)
ADDR_NUM                                VARCHAR2(20)
ADDR_PFX                                VARCHAR2(2)
ADDR_NAME                               VARCHAR2(100)
ADDR_TYPE                               VARCHAR2(4)
ADDR_SFX                                VARCHAR2(2)
VERIFY_ID                               NUMBER
SQLWKS> 	desc TMP_JOHN;                      
Column Name                    Null?    Type
------------------------------ -------- ----
OTHER                                   VARCHAR2(20)
SQLWKS> 	desc TMP_PARCEL_REGION;             
Column Name                    Null?    Type
------------------------------ -------- ----
PARCEL_ID                               VARCHAR2(11)
REGION_ID                               VARCHAR2(20)
SQLWKS> 	desc TRVEHACL;                      
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
ALLEY_ID                                VARCHAR2(10)
BRANCH_NO                               NUMBER(5)
SECTION_NO                              NUMBER(5)
ALLEY_AREA                              NUMBER(10)
SQLWKS> 	desc TRVEHALY;                      
Column Name                    Null?    Type
------------------------------ -------- ----
BRANCH_NO                      NOT NULL NUMBER(5)
SECTION_NO                     NOT NULL NUMBER(5)
COUNCIL_DIST                            NUMBER(5)
ALLEY_NAME                              VARCHAR2(40)
ST_NAME_FROM                            VARCHAR2(40)
ST_NAME_TO                              VARCHAR2(40)
REAR_ENTRY                              VARCHAR2(1)
SECTION_LENGTH                          NUMBER
NUM_OF_LANES                            NUMBER(3,1)
SEAL_COND                               VARCHAR2(1)
DISTRESSES                              NUMBER(5)
PCI                                     NUMBER(5)
SURFACE_TYPE                            VARCHAR2(20)
LAST_INSPECTION                         NUMBER(10)
NEXT_INSPECTION                         NUMBER(10)
SECTION_CLASS                           VARCHAR2(10)
CONT_REPAIR_COST                        NUMBER(12,2)
CONT_REPLACE_COST                       NUMBER(12,2)
CITY_REPLACE_COST                       NUMBER(12,2)
MAT_REPAIR_COST                         NUMBER(12,2)
MAT_REPLACE_COST                        NUMBER(12,2)
CONSTR_DATE                             NUMBER(10)
CDBG                                    VARCHAR2(1)
THOR_TYPE                               CHAR(2)
SQLWKS> 	desc TRVEHRCL;                      
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
CLINE_ID                                NUMBER(10)
BRANCH_NO                               NUMBER(5)
SECTION_NO                              NUMBER(5)
NUM_LANES                               NUMBER(5)
FR_COORD                                NUMBER
TO_COORD                                NUMBER
CLINE_LENGTH                            NUMBER
ST_NAME                                 VARCHAR2(40)
COUNCIL_DISTRICT                        NUMBER(5)
BOND_PROJ                               VARCHAR2(16)
ADDR_NUM                                NUMBER
ADDR_PFX                                VARCHAR2(2)
ADDR_NAME                               VARCHAR2(35)
ADDR_TYPE                               VARCHAR2(4)
ADDR_SFX                                VARCHAR2(2)
ADDR_LEFT_FROM                          NUMBER(6)
ADDR_LEFT_TO                            NUMBER(6)
ADDR_RGHT_FROM                          NUMBER(6)
ADDR_RGHT_TO                            NUMBER(6)
PILOT                                   VARCHAR2(1)
SOURCE                                  VARCHAR2(1)
NOTCARRIED                              VARCHAR2(1)
ADDR_LO                                 NUMBER(10)
ADDR_HI                                 NUMBER(10)
SEGMENT_ID                              NUMBER(4)
SQLWKS> 	desc TRVEHRCL_AUDIT;                
Column Name                    Null?    Type
------------------------------ -------- ----
PERSON                                  VARCHAR2(8)
ACTION                                  VARCHAR2(1)
TIMESTAMP                               DATE
MSLINK_BEF                              NUMBER
MSLINK_AFT                              NUMBER
BRANCH_BEF                              NUMBER
BRANCH_AFT                              NUMBER
SECTION_BEF                             NUMBER
SECTION_AFT                             NUMBER
PFX_BEF                                 VARCHAR2(2)
PFX_AFT                                 VARCHAR2(2)
NAME_BEF                                VARCHAR2(35)
NAME_AFT                                VARCHAR2(35)
TYPE_BEF                                VARCHAR2(4)
TYPE_AFT                                VARCHAR2(4)
SFX_BEF                                 VARCHAR2(2)
SFX_AFT                                 VARCHAR2(2)
LO_BEF                                  NUMBER
LO_AFT                                  NUMBER
HI_BEF                                  NUMBER
HI_AFT                                  NUMBER
SQLWKS> 	desc TRVEHRCL_REGION;               
Column Name                    Null?    Type
------------------------------ -------- ----
SEGMENT_ID                              NUMBER
ZIP_CODE                                VARCHAR2(5)
SUBDIV_ID                               VARCHAR2(5)
COUNCIL_ID                              VARCHAR2(1)
POLICE_BEAT                             VARCHAR2(3)
FIRE_DISTRICT                           VARCHAR2(1)
CODE_INSPECT_AREA                       VARCHAR2(2)
SQLWKS> 	desc TRVEHSTR;                      
Column Name                    Null?    Type
------------------------------ -------- ----
BRANCH_NO                      NOT NULL NUMBER(5)
SECTION_NO                     NOT NULL NUMBER(5)
COUNCIL_DIST                            NUMBER(5)
ST_NAME                                 VARCHAR2(40)
ST_NAME_FROM                            VARCHAR2(40)
ST_NAME_TO                              VARCHAR2(40)
SECTION_LENGTH                          NUMBER
NUM_OF_LANES                            NUMBER(3,1)
SEAL_COND                               VARCHAR2(1)
DISTRESSES                              NUMBER(5)
PCI                                     NUMBER(5)
SURFACE_TYPE                            VARCHAR2(20)
LAST_INSPECTION                         NUMBER(10)
NEXT_INSPECTION                         NUMBER(10)
SECTION_CLASS                           VARCHAR2(10)
CONT_REPAIR_COST                        NUMBER(12,2)
CONT_REPLACE_COST                       NUMBER(12,2)
CITY_REPLACE_COST                       NUMBER(12,2)
MAT_REPAIR_COST                         NUMBER(12,2)
MAT_REPLACE_COST                        NUMBER(12,2)
CONSTR_DATE                             NUMBER(10)
CDBG                                    VARCHAR2(1)
THOR_TYPE                               CHAR(2)
SQLWKS> 	desc TRVEHUNP;                      
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
ALLEY_ID                       NOT NULL NUMBER(10)
ALLEY_TYPE                              VARCHAR2(6)
ALLEY_WIDTH                             NUMBER
ALLEY_LENGTH                            NUMBER
ALLEY_AREA                              NUMBER
SQLWKS> 	desc TRVEH_THOR_INTERSECT;          
Column Name                    Null?    Type
------------------------------ -------- ----
INT_MSLINK                     NOT NULL NUMBER(10)
TRV_MSLINK                     NOT NULL NUMBER(10)
TRV_BRANCH                              NUMBER(10)
TRV_SECTION                             NUMBER(10)
TR_TYPE                                 VARCHAR2(2)
SQLWKS> 	desc TSSDS;                         
Column Name                    Null?    Type
------------------------------ -------- ----
REC_SEQ                                 NUMBER
REC_TYPE                                VARCHAR2(8)
TABLE_NAME                              VARCHAR2(8)
FIELD_NAME                              VARCHAR2(20)
FIELD_TYPE                              VARCHAR2(1)
FIELD_LENGTH                            NUMBER
FIELD_DOMAIN                            VARCHAR2(20)
FIELD_KEY                               VARCHAR2(20)
FIELD_DESCRIBE                          VARCHAR2(400)
SQLWKS> 	desc TST_JOHN;                      
Column Name                    Null?    Type
------------------------------ -------- ----
ADDR_NAME                      NOT NULL VARCHAR2(20)
SQLWKS> 	desc UMS_DETAIL;                    
Column Name                    Null?    Type
------------------------------ -------- ----
LOCATION_NO                             NUMBER
ACCOUNT_NO                              NUMBER
SERVICE_SEQ                             NUMBER
SERVICE_TYPE                            VARCHAR2(5)
BILL_DATE                               DATE
CONS_AMT                                NUMBER(19,6)
DETAIL_AMT                              NUMBER(15,2)
ASSET                                   VARCHAR2(10)
ASSET_NO                                VARCHAR2(15)
PARCEL_ID                               VARCHAR2(12)
SQLWKS> 	desc UMS_KEYS;                      
Column Name                    Null?    Type
------------------------------ -------- ----
LOCATION_NO                    NOT NULL NUMBER
ACCOUNT_NO                     NOT NULL NUMBER
SERVICE_SEQ                    NOT NULL NUMBER
PERSON_NO                               NUMBER
SERVICE_TYPE                            VARCHAR2(5)
MANY_ACCT_LOCNS                         NUMBER
MANY_LOCN_ACCTS                         NUMBER
MANY_LOCN_SERVS                         NUMBER
PARCEL_ID                               VARCHAR2(12)
SQLWKS> 	desc UMS_LOCATION_PARCEL;           
Column Name                    Null?    Type
------------------------------ -------- ----
LOCATION_NO                    NOT NULL NUMBER
PARCEL_ID                               VARCHAR2(12)
SQLWKS> 	desc US_STATES;                     
Column Name                    Null?    Type
------------------------------ -------- ----
ABBRV                                   VARCHAR2(2)
NAME                                    VARCHAR2(20)
SQLWKS> 	desc UTELETVT;                      
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(22)
TRANVLT_ID                              VARCHAR2(20)
MAPID                                   NUMBER(10)
META_ID                                 VARCHAR2(20)
MEDIA_ID                                VARCHAR2(20)
COORD_ID                       NOT NULL VARCHAR2(20)
DISPOSTN_D                              VARCHAR2(16)
NO_TRANS                                NUMBER(5)
MANUF_ID                                VARCHAR2(16)
MODEL_NO                                VARCHAR2(12)
SERIAL_NO                               VARCHAR2(15)
SUBSTA_ID                               VARCHAR2(20)
INSTLN_ID                               VARCHAR2(20)
PROJECT_ID                              VARCHAR2(20)
EVENT_ID                                VARCHAR2(20)
NARRATIVE                               VARCHAR2(240)
USER_FLAG                               VARCHAR2(20)
SQLWKS> 	desc UTSANARW;                      
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
ATS                                     NUMBER(10)
SQLWKS> 	desc UTSANFIT;                      
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
FITTING_ID                              VARCHAR2(15)
FITTING_CODE                            VARCHAR2(2)
MAP_GRID                                VARCHAR2(3)
MAP_QUAD                                VARCHAR2(1)
FITTING_NUM                             NUMBER(5)
FITTING_NAME                            VARCHAR2(15)
FITTING_SIZE                            NUMBER(5)
BASIN                                   VARCHAR2(20)
SUB_BASIN                               VARCHAR2(5)
SUB_SUBBASIN                            VARCHAR2(5)
UPSTREAM_NODE                           VARCHAR2(15)
DNSTREAM_NODE                           VARCHAR2(15)
ASBUILT_DATE                            NUMBER(5)
ATS                                     NUMBER(10)
SQLWKS> 	desc UTSANLAT;                      
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
LATERAL_ID                              VARCHAR2(15)
MAP_GRID                                VARCHAR2(3)
MAP_QUAD                                VARCHAR2(1)
LATERAL_NUM                             NUMBER(5)
LATERAL_SIZE                            NUMBER(5)
BASIN                                   VARCHAR2(20)
SUB_BASIN                               VARCHAR2(5)
SUB_SUBBASIN                            VARCHAR2(5)
UPSTREAM_NODE                           VARCHAR2(15)
DNSTREAM_NODE                           VARCHAR2(15)
ASBUILT_DATE                            NUMBER(5)
ATS                                     NUMBER(10)
SQLWKS> 	desc UTSANLST;                      
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
LIFTSTA_ID                              VARCHAR2(15)
MAP_GRID                                VARCHAR2(3)
MAP_QUAD                                VARCHAR2(1)
LIFTSTA_NUM                             NUMBER(5)
DESCRIPT                                VARCHAR2(40)
LIFTSTA_SIZE                            NUMBER(5)
BASIN                                   VARCHAR2(20)
SUB_BASIN                               VARCHAR2(5)
SUB_SUBBASIN                            VARCHAR2(5)
UPSTREAM_NODE                           VARCHAR2(15)
DNSTREAM_NODE                           VARCHAR2(15)
ASBUILT_DATE                            NUMBER(5)
ATS                                     NUMBER(10)
SQLWKS> 	desc UTSANMH;                       
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
MANHOLE_ID                              VARCHAR2(15)
MAP_GRID                                VARCHAR2(3)
MAP_QUAD                                VARCHAR2(1)
MANHOLE_NUM                             NUMBER(5)
MANHOLE_SIZE                            NUMBER(5)
BASIN                                   VARCHAR2(20)
SUB_BASIN                               VARCHAR2(5)
SUB_SUBBASIN                            VARCHAR2(5)
UPSTREAM_NODE                           VARCHAR2(15)
DNSTREAM_NODE                           VARCHAR2(15)
ASBUILT_DATE                            NUMBER(5)
ATS                                     NUMBER(10)
SQLWKS> 	desc UTSANPIP;                      
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
PIPE_DIAMETER                           NUMBER(5)
PIPE_LENGTH                             NUMBER(5)
PIPE_MATERIAL                           VARCHAR2(15)
PIPE_TYPE                               VARCHAR2(20)
PIPE_CLASS                              VARCHAR2(20)
PIPE_USE                                VARCHAR2(8)
PIPE_MANUFACTURER                       VARCHAR2(20)
MODELED                                 VARCHAR2(1)
IDM                                     NUMBER(5,2)
BASIN                                   VARCHAR2(20)
SUB_BASIN                               VARCHAR2(15)
SUB_SUBBASIN                            VARCHAR2(15)
UP_NODE_ID                              VARCHAR2(15)
UP_NODE_TYPE                            VARCHAR2(2)
DN_NODE_ID                              VARCHAR2(15)
DN_NODE_TYPE                            VARCHAR2(2)
UP_BASIN_ID                             VARCHAR2(20)
UP_SUB_BASIN_ID                         VARCHAR2(20)
UP_NODE_XCOORD                          NUMBER(11,3)
UP_NODE_YCOORD                          NUMBER(11,3)
UP_NODE_ELEV                            NUMBER(5,2)
UP_NODE_GRND_ELEV                       NUMBER(5,2)
DN_BASIN_ID                             VARCHAR2(20)
DN_SUB_BASIN_ID                         VARCHAR2(20)
DN_NODE_XCOORD                          NUMBER(11,3)
DN_NODE_YCOORD                          NUMBER(11,3)
DN_NODE_ELEV                            NUMBER(5,2)
DN_NODE_GRND_ELEV                       NUMBER(5,2)
SLOPE                                   NUMBER(5,2)
ASBUILT_DATE                            NUMBER(5)
PIPE_LENGTH1                            FLOAT(21)
PIPE_ID                                 VARCHAR2(12)
MAP_GRID                                NUMBER(5)
MAP_QUAD                                VARCHAR2(1)
PIPE_NUM                                NUMBER(5)
ATS                                     NUMBER(10)
SQLWKS> 	desc UTSANPIP_MSLINK_JUNCTION;      
Column Name                    Null?    Type
------------------------------ -------- ----
OLD_MSLINK                              VARCHAR2(40)
NEW_MSLINK                              VARCHAR2(20)
SQLWKS> 	desc UTSANSRVLN;                    
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
ATS                                     NUMBER(10)
SQLWKS> 	desc UTSTOARW;                      
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
ATS                                     NUMBER(10)
SQLWKS> 	desc UTSTOCOM;                      
Column Name                    Null?    Type
------------------------------ -------- ----
PARCEL_ID                      NOT NULL VARCHAR2(12)
ACCOUNT                        NOT NULL NUMBER(10)
POLYAREA                                FLOAT(21)
ADDR_NUM                                VARCHAR2(6)
ADDR_PFX                                VARCHAR2(1)
ADDR_NAME                               VARCHAR2(40)
ADDR_TYPE                               VARCHAR2(4)
CUSTOMER                                VARCHAR2(40)
ZIPCODE                                 NUMBER(10)
TOT_IMPER                               FLOAT(21)
FEE                                     NUMBER(5,2)
MSLINK                                  NUMBER(10)
MAPID                                   NUMBER(10)
SQLWKS> 	desc UTSTOCTY;                      
Column Name                    Null?    Type
------------------------------ -------- ----
DEPARTMENT                              VARCHAR2(20)
CUSTOMER                                VARCHAR2(40)
ADDR_PFX                                VARCHAR2(1)
ADDR_NUM                                NUMBER(5)
ADDR_NAME                               VARCHAR2(40)
ADDR_TYPE                               VARCHAR2(4)
PARCEL_ID                      NOT NULL VARCHAR2(12)
ACCOUNT                        NOT NULL NUMBER(10)
POLYAREA                                NUMBER(10)
TOT_IMPER                               NUMBER(10)
FEE                                     NUMBER(6,2)
FUND                                    VARCHAR2(1)
MSLINK                                  NUMBER(10)
MAPID                                   NUMBER(10)
SQLWKS> 	desc UTSTOHDWL;                     
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
ATS                                     NUMBER(10)
SQLWKS> 	desc UTSTOINL;                      
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
INLET_ID                                VARCHAR2(12)
INLET_CODE                              VARCHAR2(2)
MAP_GRID                                VARCHAR2(3)
MAP_QUAD                                VARCHAR2(1)
INLET_NUM                               NUMBER(5)
INLET_TYPE                              VARCHAR2(30)
INLET_SIZE                              NUMBER(5,2)
ASBUILT_DATE                            NUMBER(5)
ATS                                     NUMBER(10)
SQLWKS> 	desc UTSTOMDU;                      
Column Name                    Null?    Type
------------------------------ -------- ----
PARCEL_ID                      NOT NULL VARCHAR2(12)
ACCOUNT                        NOT NULL NUMBER(10)
POLYAREA                                FLOAT(21)
TOT_IMPER                               FLOAT(21)
PER_IMPER                               NUMBER(5,2)
IND_IMPER                               FLOAT(21)
FEE                                     NUMBER(7,2)
ADDR_NUM                                VARCHAR2(14)
ADDR_PFX                                VARCHAR2(1)
ADDR_NAME                               VARCHAR2(40)
ADDR_TYPE                               VARCHAR2(4)
CUSTOMER                                VARCHAR2(40)
MSLINK                                  NUMBER(10)
MAPID                                   NUMBER(10)
SQLWKS> 	desc UTSTOMH;                       
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
MANHOLE_ID                              VARCHAR2(15)
MAP_GRID                                VARCHAR2(3)
MAP_QUAD                                VARCHAR2(1)
MANHOLE_NUM                             NUMBER(5)
ASBUILT_DATE                            NUMBER(5)
ATS                                     NUMBER(10)
SQLWKS> 	desc UTSTOOCH;                      
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
CHANNEL_TYPE                            VARCHAR2(2)
CHANNEL_DESC                            VARCHAR2(20)
GENERAL_DESC                            VARCHAR2(20)
CHANNEL_SIZE                            NUMBER(5)
CHANNEL_LENGTH                          NUMBER(5)
QUANTITY                                NUMBER(5)
BOXWIDE                                 NUMBER(5)
BOXTALL                                 NUMBER(10)
YEAR_BLT                                NUMBER(5)
FLAG                                    NUMBER(5)
CHANNEL_ID                              VARCHAR2(12)
MAP_GRID                                NUMBER(5)
MAP_QUAD                                VARCHAR2(1)
CHANNEL_NUM                             NUMBER(5)
PIPE_LENGTH1                            FLOAT(21)
ATS                                     NUMBER(10)
SQLWKS> 	desc UTSTOPIP;                      
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
PIPE_TYPE                               VARCHAR2(2)
PIPE_DESC                               VARCHAR2(20)
GENERAL_DESC                            VARCHAR2(20)
PIPE_SIZE                               NUMBER(5)
PIPE_LENGTH                             NUMBER(5)
QUANTITY                                NUMBER(5)
BOXWIDE                                 NUMBER(5)
BOXTALL                                 NUMBER(5)
YEAR_BLT                                NUMBER(5)
FLAG                                    NUMBER(5)
PIPE_ID                                 VARCHAR2(12)
MAP_GRID                                NUMBER(5)
MAP_QUAD                                VARCHAR2(1)
PIPE_NUM                                NUMBER(5)
PIPE_LENGTH1                            NUMBER(8,2)
ATS                                     NUMBER(10)
SQLWKS> 	desc UTSTOSRVLN;                    
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
ATS                                     NUMBER(10)
SQLWKS> 	desc UTWATARW;                      
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
ATS                                     NUMBER(10)
SQLWKS> 	desc UTWATFIT;                      
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
FITTING_ID                              VARCHAR2(12)
FITTING_TYPE                            VARCHAR2(10)
FITTING_SIZE                            NUMBER
FITTING_WIDTH                           NUMBER
FITTING_LENGTH                          NUMBER
MATERIAL                                VARCHAR2(6)
CLASS                                   VARCHAR2(6)
STRUCTURE_TYPE                          VARCHAR2(10)
STRUCTURE_ID                            VARCHAR2(12)
FITTING_USE                             VARCHAR2(16)
FITTING_STATUS                          VARCHAR2(6)
MAP_GRID                                NUMBER(5)
MAP_QUAD                                VARCHAR2(1)
FITTING_NUM                             NUMBER(5)
X_COORD                                 NUMBER
Y_COORD                                 NUMBER
UP_NODE_ID                              VARCHAR2(12)
DOWN_NODE_ID                            VARCHAR2(12)
MANUFACTURER                            VARCHAR2(20)
ASBUILT_DATE                            DATE
OWNER                                   VARCHAR2(20)
OWNER_STATUS                            VARCHAR2(8)
CONTRACTOR                              VARCHAR2(20)
CONTRACT_NUM                            VARCHAR2(20)
LINE_NUM                                VARCHAR2(12)
ZONE                                    VARCHAR2(4)
SUB_BASIN                               VARCHAR2(6)
SUB_SUBBASIN                            VARCHAR2(6)
FLOWLINE_ELEV                           NUMBER(3,2)
GROUND_ELEV                             NUMBER(3,2)
PRESSURE_NORMAL                         NUMBER
PRESSURE_MAX                            NUMBER
PRESSURE_SOURCE                         VARCHAR2(10)
REPAIR_DATE                             DATE
WORK_ORDER_NUM                          VARCHAR2(10)
INSPECTION_DATE                         DATE
DATA_SOURCE                             VARCHAR2(24)
USER_FLAG                               NUMBER(5)
POST_MODE                               VARCHAR2(1)
DATE_ADD                                DATE
ATS                                     NUMBER(10)
SQLWKS> 	desc UTWATHYD;                      
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
HYDRANT_ID                              VARCHAR2(12)
HYDRANT_TYPE                            VARCHAR2(10)
HYDRANT_MATERIAL                        VARCHAR2(10)
MAP_QUAD                                VARCHAR2(1)
MAP_GRID                                NUMBER(5)
HYDRANT_NUM                             NUMBER(5)
X_COORD                                 NUMBER
Y_COORD                                 NUMBER
VALVE_ID                                VARCHAR2(12)
FLOWLINE_ELEV                           NUMBER(3,2)
GROUND_ELEV                             NUMBER(3,2)
MANUFACTURER                            VARCHAR2(20)
ASBUILT_DATE                            NUMBER(38)
HYDRANT_STATUS                          VARCHAR2(10)
HYDRANT_OWNER                           VARCHAR2(16)
OWNER_STATUS                            VARCHAR2(8)
CONTRACTOR                              VARCHAR2(20)
PROJECT_NAME                            VARCHAR2(20)
CONTRACT_NUM                            VARCHAR2(20)
LINE_NUM                                VARCHAR2(12)
ZONE                                    VARCHAR2(4)
SUB_BASIN                               VARCHAR2(6)
SUB_SUB_BASIN                           VARCHAR2(6)
PRESSURE_STATIC                         NUMBER
PRESSURE_MAX                            NUMBER
PRESSURE_FLOWTEST                       VARCHAR2(20)
PRESSURE_TEST_DATE                      DATE
REQ_FLOW_RATE                           NUMBER
REPAIR_DATE                             DATE
WORK_ORDER_NUM                          VARCHAR2(12)
INSPECT_DATE                            DATE
DATA_SOURCE                             VARCHAR2(24)
USER_FLAG                               NUMBER(5)
POST_MODE                               VARCHAR2(1)
DATE_ADD                                DATE
LINE_SIZE                               NUMBER(5)
ATS                                     NUMBER(10)
SQLWKS> 	desc UTWATMTR;                      
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
ATS                                     NUMBER(10)
SQLWKS> 	desc UTWATPIP;                      
Column Name                    Null?    Type
------------------------------ -------- ----
PROJECT_NO                              VARCHAR2(11)
PROJECT_NAME                            VARCHAR2(50)
SUBDIVISION_NAME                        VARCHAR2(50)
PROJECT_DESC                            VARCHAR2(50)
ASBUILT_DATE                            VARCHAR2(10)
INSPECTOR_NAME                          VARCHAR2(20)
CONTRACT_NAME                           VARCHAR2(20)
MAP_GRID                                NUMBER(5)
MAP_QUAD                                VARCHAR2(1)
MSLINK                                  NUMBER(10)
MAPID                                   NUMBER(10)
PIPE_DIAMETER                           NUMBER(5)
PIPE_LENGTH                             NUMBER(5)
PIPE_MATERIAL                           VARCHAR2(5)
UP_NODE_ID                              VARCHAR2(12)
DN_NODE_ID                              VARCHAR2(12)
UP_NODE_ELEV                            NUMBER(5,2)
UP_NODE_GRND_ELEV                       NUMBER(5,2)
DN_NODE_ELEV                            NUMBER(5,2)
DN_NODE_GRND_ELEV                       NUMBER(5,2)
SLOPE                                   NUMBER(22)
PIPE_CLASS                              VARCHAR2(5)
PIPE_MANUFACTURER                       VARCHAR2(20)
PIPE_USE                                VARCHAR2(10)
PIPE_STATUS                             VARCHAR2(5)
PIPE_OWNER                              VARCHAR2(10)
PIPE_OWNER_STATUS                       VARCHAR2(10)
CONTRACTOR                              VARCHAR2(20)
CONTRACT_NUM                            VARCHAR2(20)
LINE_NUM                                VARCHAR2(10)
ZONE                                    VARCHAR2(4)
SUB_BASIN                               VARCHAR2(5)
SUB_SUB_BASIN                           VARCHAR2(5)
PRESSURE_NORMAL                         FLOAT
PRESSURE_MAX                            FLOAT
PRESSURE_SOURCE                         VARCHAR2(20)
REPAIR_DATE                             NUMBER(22)
WORK_ORDER_NUM                          VARCHAR2(10)
INSPECT_DATE                            NUMBER(22)
FROM_X_COORD                            NUMBER(22)
FROM_Y_COORD                            NUMBER(22)
TO_X_COORD                              NUMBER(22)
TO_Y_COORD                              NUMBER(22)
DATA_SOURCE                             VARCHAR2(20)
USER_FLAG                               VARCHAR2(10)
POST_MODE                               VARCHAR2(1)
DATE_ADD                                VARCHAR2(10)
PIPE_ID                                 VARCHAR2(12)
PIPE_NUM                                NUMBER(5)
ATS                                     NUMBER(10)
COMMENTS                                VARCHAR2(50)
SQLWKS> 	desc UTWATPLG;                      
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
ATS                                     NUMBER(10)
SQLWKS> 	desc UTWATPSTA;                     
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
PUMPSTA_ID                              VARCHAR2(15)
PUMPSTA_TYPE                            VARCHAR2(2)
MAP_GRID                                VARCHAR2(3)
MAP_QUAD                                VARCHAR2(1)
PUMPSTA_NUM                             NUMBER(5)
ASBUILT_DATE                            NUMBER(5)
ATS                                     NUMBER(10)
SQLWKS> 	desc UTWATSRVLN;                    
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
ATS                                     NUMBER(10)
SQLWKS> 	desc UTWATTNK;                      
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
TANK_ID                                 VARCHAR2(15)
TANK_TYPE                               VARCHAR2(2)
MAP_GRID                                VARCHAR2(3)
MAP_QUAD                                VARCHAR2(1)
TANK_NUM                                NUMBER(5)
ASBUILT_DATE                            NUMBER(5)
ATS                                     NUMBER(10)
SQLWKS> 	desc UTWATVLV;                      
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(10)
MAPID                                   NUMBER(10)
VALVE_ID                                VARCHAR2(12)
VALVE_TYPE                              VARCHAR2(10)
VALVE_SIZE                              NUMBER(5)
VALVE_USE                               VARCHAR2(16)
VALVE_STATUS                            VARCHAR2(6)
MAP_GRID                                NUMBER(5)
MAP_QUAD                                VARCHAR2(1)
VALVE_NUM                               NUMBER(5)
X_COORD                                 NUMBER
Y_COORD                                 NUMBER
UP_NODE_ID                              VARCHAR2(12)
DOWN_NODE_ID                            VARCHAR2(12)
STRUCTURE_TYPE                          VARCHAR2(10)
STRUCTURE_ID                            VARCHAR2(12)
FIT_WIDTH                               FLOAT(21)
FIT_LENGTH                              FLOAT(21)
MANUFACTURER                            VARCHAR2(20)
ASBUILT_DATE                            DATE
OWNER                                   VARCHAR2(20)
OWNER_STATUS                            VARCHAR2(8)
CONTRACTOR                              VARCHAR2(20)
PROJECT_NAME                            VARCHAR2(20)
CONTRACT_NUM                            VARCHAR2(20)
LINE_NUM                                VARCHAR2(12)
ZONE                                    VARCHAR2(4)
SUB_BASIN                               VARCHAR2(6)
SUB_SUBBASIN                            VARCHAR2(6)
FLOWLINE_ELEV                           NUMBER(3,2)
GROUND_ELEV                             NUMBER(3,2)
PRESSURE_NORMAL                         FLOAT(21)
PRESSURE_MAX                            FLOAT(21)
PRESSURE_SOURCE                         VARCHAR2(10)
REPAIR_DATE                             DATE
WORK_ORDER_NUM                          VARCHAR2(10)
INSPECT_DATE                            DATE
DATA_SOURCE                             VARCHAR2(24)
USER_FLAG                               NUMBER(5)
POST_MODE                               VARCHAR2(1)
DATE_ADD                                DATE
MATERIAL                                VARCHAR2(6)
CLASS                                   VARCHAR2(6)
ATS                                     NUMBER(10)
SQLWKS> 	desc VIEW_CATALOG;                  
Column Name                    Null?    Type
------------------------------ -------- ----
ENTITYNUM                      NOT NULL NUMBER(10)
VIEWNAME                                VARCHAR2(18)
VIEWTYPE                       NOT NULL NUMBER(10)
SQLWKS> 	desc VIEW_CONTENT;                  
Column Name                    Null?    Type
------------------------------ -------- ----
VIEWNAME                       NOT NULL VARCHAR2(18)
TABLENAME                      NOT NULL VARCHAR2(18)
COLUMNNAME                     NOT NULL VARCHAR2(18)
ALIASNAME                      NOT NULL VARCHAR2(18)
SQLWKS> 	desc VIEW_JOIN;                     
Column Name                    Null?    Type
------------------------------ -------- ----
VIEWNAME                       NOT NULL VARCHAR2(18)
JOINID                         NOT NULL NUMBER(10)
SQLWKS> 	desc WORK_MAST;                     
Column Name                    Null?    Type
------------------------------ -------- ----
SFG_NUM                        NOT NULL NUMBER(4)
SUB_TASK_NUM                   NOT NULL NUMBER(4)
SFG_NAME                                VARCHAR2(40)
SFG_UNITS                               VARCHAR2(4)
SFG_TIME                                NUMBER(6,3)
CATEGORY                                VARCHAR2(10)
CREW_SIZE                               NUMBER(3)

