
	=======================
	CODE ENFORCEMENT TABLES
	=======================

CODE
====

Column Name                    Null?    Type
------------------------------ -------- ----
CODE_ID                        NOT NULL VARCHAR2(5)
CODE_VIOLATION                 NOT NULL VARCHAR2(30)
CITY_ORDINANCE                          VARCHAR2(10)
LONG_DESCRIPTION                        VARCHAR2(200)
STATUS                                  VARCHAR2(1)
ANNUAL_NOTICE                           VARCHAR2(1)


CODEADDR
========

Column Name                    Null?    Type
------------------------------ -------- ----
ADDR_ID                        NOT NULL VARCHAR2(374)
ADDRESS_NAME                            VARCHAR2(40)
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
COG_TAX_ID                     NOT NULL VARCHAR2(17)
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
SUPERCEDED                              VARCHAR2(1)
TEMP_ADDR_DISABLED                      VARCHAR2(1)


COMPLAINT
=========

Column Name                    Null?    Type
------------------------------ -------- ----
COMPLAINT_NUMBER               NOT NULL NUMBER(9)
TAXID_NUMBER                            VARCHAR2(17)
COMPLAINT_DATE                          DATE
COMPLAINT_TIME                          DATE
COMPLAINT_ORGIN                         VARCHAR2(1)
COMPLAINT                               VARCHAR2(60)
COMPLAINTANT_NAME                       VARCHAR2(30)
COMPLAINTANT_ADDRESS                    VARCHAR2(30)
COMPLAINTANT_CITY_ST                    VARCHAR2(30)
COMPLAINTANT_PHONE_NUMBER               NUMBER(10)
COMPLAINT_LOCATION                      VARCHAR2(45)
INSPECTION_NOTES                        VARCHAR2(60)
INSPECTION_PRINT_DATE                   DATE
INSPECTION_RESULT                       VARCHAR2(1)
CASE_NUMBER                             NUMBER(10)
INSPECTOR_RESPONSE                      VARCHAR2(1)
RESPONSE_DATE                           DATE
COMPLAINT_FOLLOW_UP                     VARCHAR2(1)
PRINT_FLAG                              VARCHAR2(1)
INSPECTOR_NAME                          VARCHAR2(3)
NO_ADDRESS                              VARCHAR2(1)
HIGH_WEEDS                              VARCHAR2(1)
TRASH                                   VARCHAR2(1)
ENCROACHMENT                            VARCHAR2(1)
ILLEGAL_PARKING                         VARCHAR2(1)
IMPROPER_STORAGE                        VARCHAR2(1)
JUNK_MOTOR_VEHICLE                      VARCHAR2(1)
FENCE                                   VARCHAR2(1)
GREEN_CONTAINERS                        VARCHAR2(1)
STAGNANT_WATER                          VARCHAR2(1)
ZONING                                  VARCHAR2(1)
FECAL_ACCUM                             VARCHAR2(1)
ILLEGAL_DUMPING                         VARCHAR2(1)
OVERWEIGHT_VEHICLE                      VARCHAR2(1)
GRAFFITI                                VARCHAR2(1)
OVERCROWDING                            VARCHAR2(1)
HOME_OCCUPATION                         VARCHAR2(1)
POOL                                    VARCHAR2(1)
VACANT_SUB_STRUCTURE                    VARCHAR2(1)
MULTIFAMILY                             VARCHAR2(1)
HEALTH_HAZARD                           VARCHAR2(1)
OTHER                                   VARCHAR2(1)
ADDR_ID                                 VARCHAR2(374)


CITATION
========

Column Name                    Null?    Type
------------------------------ -------- ----
CASE_NUMBER                    NOT NULL NUMBER(10)
CITATION_NUMBER                NOT NULL NUMBER(6)
REMARKS                        NOT NULL VARCHAR2(50)
CITATION_ISSUE_DATE                     DATE
CITATION_COMPLY_DATE                    DATE
PRINT_RECHECK                           VARCHAR2(1)


INSPECTION
==========

Column Name                    Null?    Type
------------------------------ -------- ----
CASE_NUMBER                    NOT NULL NUMBER(10)
COMPLAINT_NUMBER                        NUMBER(9)
TAX_ID                         NOT NULL VARCHAR2(17)
INSPECTION_DATE                         DATE
INSPECTION_TIME                         DATE
INSPECTOR_INITIALS                      VARCHAR2(3)
VIOLATION_NOTICE_TYPE                   VARCHAR2(1)
COMPLIANCE_DAYS                         NUMBER(3)
COMPLIANCE_DUE_DATE                     DATE
DATE_OF_FOLLOW_UP                       DATE
TIME_OF_FOLLOW_UP                       DATE
FOLLOW_UP_ACTION                        VARCHAR2(2)
REMARKS                                 VARCHAR2(60)
WORK_ORDER_NUMBER                       VARCHAR2(9)
CITATION_NUMBER                         VARCHAR2(7)
LOCATION                                VARCHAR2(500)
PRINT_FLAG                              VARCHAR2(1)
INSPECTION_PRINT_DATE                   DATE
NOV_PRINT_FLAG                          VARCHAR2(1)
NOV_PRINT_DATE                          DATE
INSPECTION_NUMBER                       NUMBER(10)
NOV_TENANT                              VARCHAR2(1)
NOV_OWNER                               VARCHAR2(1)
NOV_DOOR_HANGER                         VARCHAR2(1)
NOV_TENANT_PRINT                        VARCHAR2(1)
ADDR_ID                                 VARCHAR2(374)
STATUS                                  VARCHAR2(1)
CASE_CLOSED_DATE                        DATE
ADDL_ADDRESS                            VARCHAR2(1)
ADDL_ADDRESS_PRINTED                    VARCHAR2(1)
REINSPECTION_COUNT                      NUMBER(10)
ANNUAL_NOTICE                           VARCHAR2(1)
ANNUAL_NOTICE_PRINTED                   VARCHAR2(1)


CITATION
========

Column Name                    Null?    Type
------------------------------ -------- ----
CASE_NUMBER                    NOT NULL NUMBER(10)
CITATION_NUMBER                NOT NULL NUMBER(6)
REMARKS                        NOT NULL VARCHAR2(50)
CITATION_ISSUE_DATE                     DATE
CITATION_COMPLY_DATE                    DATE
PRINT_RECHECK                           VARCHAR2(1)


CASE_VIOLATION
==============

Column Name                    Null?    Type
------------------------------ -------- ----
CASE_NUMBER                    NOT NULL NUMBER(10)
VIOLATION_ID                   NOT NULL VARCHAR2(10)
VIOLATION                               VARCHAR2(30)
CODE_ID                                 VARCHAR2(5)
ACTION                                  NUMBER(2)
CVDATE                                  DATE
STATUS                                  VARCHAR2(1)



CASE_VIOLATION_ACTIONS
======================

Column Name                    Null?    Type
------------------------------ -------- ----
ACTION_CODE                    NOT NULL NUMBER(2)
ACTION_DESCRIPTION             NOT NULL VARCHAR2(30)
ACTION_STATUS                  NOT NULL VARCHAR2(1)


ACTION_COD ACTION_DESCRIPTION             A
---------- ------------------------------ -
         1 Resident Complied              C
         2 Citiation Issued               O
         3 Work Order Issued              O
         4 Citation and Work Order        O
         5 Granted Extension              O
         6 Violation Logged               O
         7 NOV Tenant Printed             O
         8 NOV Owner Printed              O
         9 Re-Inspection Printed          O
        10 Work Order Complied            C
         0 Red Tagged                     O


=======================================================================
=======================================================================

CODE
====

SELECT TABLE_NAME, COLUMN_NAME FROM COLS WHERE COLUMN_NAME LIKE 'CODE%'

TABLE_NAME                     COLUMN_NAME                   
------------------------------ ------------------------------
CASE_VIOLATION                 CODE_ID                       
CODE                           CODE_ID                       
CODE                           CODE_VIOLATION                
PARAMETER                      CODE_ID                       
RETURNED_REASON                CODE                          


CASE
====

SELECT TABLE_NAME, COLUMN_NAME FROM COLS WHERE COLUMN_NAME LIKE 'CASE%'

TABLE_NAME                     COLUMN_NAME                   
------------------------------ ------------------------------
ADDITIONAL_ADDRESS             CASE_NUMBER                   
ANNUAL_NOTICE                  CASE_NUMBER                   
AUDIT_INSPECTION               CASE_NUMBER                   
AUDIT_INVOICE                  CASE_NUMBER                   
AUDIT_WORK_ORDER               CASE_NUMBER                   
CASE_VIOLATION                 CASE_NUMBER                   
CITATION                       CASE_NUMBER                   
CODE_STATS                     CASES_OPENED                  
CODE_STATS                     CASES_CLOSED                  
COMPLAINT                      CASE_NUMBER                   
HCR_INPUT                      CASE_NUMBER                   
HCR_INPUT                      CASE_STATUS                   
HCR_INPUT                      CASE_CLOSED_DATE              
HCR_INSPECTION                 CASE_NUMBER                   
INSPECTION                     CASE_NUMBER                   
INSPECTION                     CASE_CLOSED_DATE              
INVOICE                        CASE_NUMBER                   
PARAMETER                      CASE_NUMBER                   
WORK_ORDER                     CASE_NUMBER                   
WOR_INPUT                      CASE_NUMBER                   



VIOLATION
=========

SELECT TABLE_NAME, COLUMN_NAME FROM COLS WHERE COLUMN_NAME LIKE 'VIOL%'

TABLE_NAME                     COLUMN_NAME                   
------------------------------ ------------------------------
CASE_VIOLATION                 VIOLATION_ID                  
CASE_VIOLATION                 VIOLATION                     
HCR_ACT_INDICATOR              VIOL_CASELOAD_RATIO           
HCR_AI_DATA                    VIOL_CASELOAD_RATIO           
HCR_INPUT                      VIOLATION_ID                  
HCR_INPUT                      VIOLATION_STATUS              
ILLEGAL_VEHICLES               VIOLATION                     
INSPECTION                     VIOLATION_NOTICE_TYPE         
INSPECTOR_STATISTICS           VIOLATION_TYPE                


NUISANCE
========

SELECT TABLE_NAME, COLUMN_NAME FROM COLS WHERE COLUMN_NAME LIKE 'NUIS%'

TABLE_NAME                     COLUMN_NAME                   
------------------------------ ------------------------------
HCR_DATA                       NUIS_VOLUNTARY                
HCR_DATA                       NUIS_CITY_ABATED              
HCR_DATA                       NUIS_VIOLS                    
HCR_DATA                       NUIS_VIOLS_OPEN               
HCR_DATA                       NUIS_VIOLS_OPEN_GT31          
HCR_DATA                       NUIS_VOLUNTARY_PCENT          
HCR_DATA                       NUIS_CITY_ABATED_PCENT        
HCR_DATA                       NUIS_TOTAL_COMPLIED_PCENT     
HCR_DATA                       NUIS_NO_COMPLY_PCENT          
HCR_RESULTS                    NUIS_VIOLS                    
HCR_RESULTS                    NUIS_VIOLS_OPEN               
HCR_RESULTS                    NUIS_VIOLS_OPEN_GT31          
HCR_RESULTS                    NUIS_VOLUNTARY_PCENT          
HCR_RESULTS                    NUIS_CITY_ABATED_PCENT        
HCR_RESULTS                    NUIS_TOTAL_COMPLIED_PCENT     
HCR_RESULTS                    NUIS_NO_COMPLY_PCENT          
HCR_RESULTS                    NUIS_VOLUNTARY                
HCR_RESULTS                    NUIS_CITY_ABATED              


DATES
=====

SELECT TABLE_NAME, COLUMN_NAME FROM COLS WHERE COLUMN_NAME LIKE '%DATE%'

TABLE_NAME                     COLUMN_NAME                   
------------------------------ ------------------------------
ACCOUNTS                       ACCOUNT_DATE                  
ANNUAL_NOTICE                  SENT_DATE                     
ANNUAL_NOTICE                  RETURNED_DATE                 
AUDIT_ADDRESS                  AUDIT_DATE_TIME               
AUDIT_COMPLAINT                AUDIT_DATE_TIME               
AUDIT_INSPECTION               AUDIT_DATE_TIME               
AUDIT_INVOICE                  AUDIT_DATE_TIME               
AUDIT_WORK_ORDER               AUDIT_DATE_TIME               
CASE_VIOLATION                 CVDATE                        
CITATION                       CITATION_ISSUE_DATE           
CITATION                       CITATION_COMPLY_DATE          
CODE_STATS                     START_DATE                    
CODE_STATS                     END_DATE                      
COMPLAINT                      COMPLAINT_DATE                
COMPLAINT                      INSPECTION_PRINT_DATE         
COMPLAINT                      RESPONSE_DATE                 
HCR_COMPLAINT                  COMPLAINT_DATE                
HCR_COMPLAINT                  RESPONSE_DATE                 
HCR_DATA                       PREV_PERIOD_START_DATE        
HCR_DATA                       PREV_PERIOD_END_DATE          
HCR_INPUT                      INSPECTION_DATE               
HCR_INPUT                      CASE_CLOSED_DATE              
HCR_INPUT                      CVDATE                        
HCR_INSPECTION                 INSPECTION_DATE               
HCR_RESULTS                    RLY_PREV_PERIOD_START_DATE    
HCR_RESULTS                    RLY_PREV_PERIOD_END_DATE      
HCR_RESULTS                    PREV_PERIOD_START_DATE        
HCR_RESULTS                    PREV_PERIOD_END_DATE          
HCR_RESULTS                    LY_PREV_PERIOD_START_DATE     
HCR_RESULTS                    LY_PREV_PERIOD_END_DATE       
HCR_RESULTS                    RPREV_PERIOD_START_DATE       
HCR_RESULTS                    RPREV_PERIOD_END_DATE         
ILLEGAL_VEHICLES               DATE_DISCOVERED               
INSPECTION                     INSPECTION_DATE               
INSPECTION                     COMPLIANCE_DUE_DATE           
INSPECTION                     DATE_OF_FOLLOW_UP             
INSPECTION                     INSPECTION_PRINT_DATE         
INSPECTION                     NOV_PRINT_DATE                
INSPECTION                     CASE_CLOSED_DATE              
INTEREST                       FROM_DATE                     
INTEREST                       TO_DATE                       
INVOICE                        MAIL_DATE                     
INVOICE                        ARRANGEMENT_DUE_DATE          
INVOICE                        LAST_INTEREST_CHARGE_DATE     
INVOICE                        LAST_PAYMENT_DATE             
INVOICE                        TO_DATE_INTEREST              
INVOICE                        ARRANGE_FOR_PAYMENT_DATE      
INVOICE                        FROM_DATE_INTEREST            
LIEN                           PRINT_DATE                    
LIEN                           FILE_DATE                     
LIEN                           RELEASED_DATE                 
NOTES                          ENTRY_DATE                    
PAYMENT                        PAY_DATE                      
PAYMENT                        INTEREST_FROM_DATE            
PAYMENT                        INTEREST_TO_DATE              
PAYMENT_HISTORY                PAY_DATE                      
PAYMENT_SCHEDULE               PAYMENT_CYCLE_START_DATE      
PAYMENT_SCHEDULE               NEXT_PAYMENT_DATE             
PAYMENT_SCHEDULE               LAST_PAYMENT_DATE             
PAY_DISTRIBUTION               PAY_DATE                      
SIGN_REMOVAL                   WORK_DATE                     
WORK_ORDER                     WO_STS_3_DATE                 
WORK_ORDER                     WO_STS_4_DATE                 
WORK_ORDER                     WO_STS_5_DATE                 
WORK_ORDER                     WO_STS_6_DATE                 
WORK_ORDER                     WO_STS_7_DATE                 
WORK_ORDER                     WO_STS_8_DATE                 
WORK_ORDER                     REISSUE_DATE                  
WORK_ORDER                     WO_STS_9_DATE                 
WORK_ORDER                     WORK_ORDER_DATE               
WORK_ORDER                     WORK_ORDER_COMPLIANCE_DATE    
WORK_ORDER                     PAPER_WORK_DUE_DATE           
WORK_ORDER                     DATE_WORK_PERFORMED           
WORK_ORDER                     ORDER_INSPECTION_DATE         
WORK_ORDER                     WO_STS_1_DATE                 
WORK_ORDER                     WO_STS_2_DATE                 
WOR_INPUT                      WO_DATE                       
WOR_INPUT                      COMPLIANCE_DATE               



TABLE NOTES
============

CODE_STATS	MONTHLY SUMMARY FOR EACH INSPECTOR
