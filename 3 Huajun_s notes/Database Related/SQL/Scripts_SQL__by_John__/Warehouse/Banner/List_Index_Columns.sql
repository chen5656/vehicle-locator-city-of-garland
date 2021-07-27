
TABLE_OWNER     TABLE_NAME      INDEX_NAME                     COLUMN_NAME                    POSN
--------------- --------------- ------------------------------ ------------------------------ ----
UIMSMGR         UCBCUST         UCBCUST_UPPER_NAME_INDEX       SYS_NC00035$                      1
UIMSMGR         UCBCUST         UCBCUST_UPPER_NAME_INDEX       SYS_NC00036$                      2

UIMSMGR         UCBCUST         UCBCUST_SSN_INDEX              UCBCUST_SSN                       1

UIMSMGR         UCBCUST         UCBCUST_SOUNDEX_INDEX          UCBCUST_LAST_NAME_SDX             1
UIMSMGR         UCBCUST         UCBCUST_SOUNDEX_INDEX          UCBCUST_FIRST_NAME_SDX            2
UIMSMGR         UCBCUST         UCBCUST_SOUNDEX_INDEX          UCBCUST_MIDDLE_NAME_SDX           3

UIMSMGR         UCBCUST         UCBCUST_TAX_ID_INDEX           UCBCUST_1099_ID                   1

UIMSMGR         UCBCUST         UCBCUST_CUST_KEY_INDEX         UCBCUST_CUST_CODE                 1

UIMSMGR         UCBCUST         UCBCUST_LNAME_INDEX            UCBCUST_LAST_NAME                 1
UIMSMGR         UCBCUST         UCBCUST_LNAME_INDEX            UCBCUST_FIRST_NAME                2

--------------------------------------------------------------------------------------------------

UIMSMGR         UCBPREM         UCBPREM_KEY_INDEX              UCBPREM_CODE                      1

UIMSMGR         UCBPREM         UCBPREM_STREET_NAME_INDEX      UCBPREM_STREET_NAME               1

UIMSMGR         UCBPREM         UCBPREM_SOUNDEX_INDEX          UCBPREM_STREET_NAME_SDX           1

--------------------------------------------------------------------------------------------------

UIMSMGR         UCRACCT         UCRACCT_PREM_CODE_INDEX        UCRACCT_PREM_CODE                 1
UIMSMGR         UCRACCT         UCRACCT_PREM_CODE_INDEX        UCRACCT_CUST_CODE                 2

UIMSMGR         UCRACCT         UCRACCT_UTRCOMP_FK             UCRACCT_COMPANY_CODE              1

UIMSMGR         UCRACCT         UCRACCT_MMBR_INDEX             UCRACCT_MMBR_CODE                 1
UIMSMGR         UCRACCT         UCRACCT_MMBR_INDEX             UCRACCT_CUST_CODE                 2
UIMSMGR         UCRACCT         UCRACCT_MMBR_INDEX             UCRACCT_PREM_CODE                 3

UIMSMGR         UCRACCT         UCRACCT_MASTER_INDEX           UCRACCT_MBIL_NUM                  1
UIMSMGR         UCRACCT         UCRACCT_ACCT_KEY_INDEX         UCRACCT_ACCT_CODE                 1

UIMSMGR         UCRACCT         UCRACCT_CYCLE_INDEX            UCRACCT_CYCL_CODE                 1
UIMSMGR         UCRACCT         UCRACCT_CYCLE_INDEX            UCRACCT_CUST_CODE                 2
UIMSMGR         UCRACCT         UCRACCT_CYCLE_INDEX            UCRACCT_PREM_CODE                 3

UIMSMGR         UCRACCT         UCRACCT_PIDM_KEY_INDEX         UCRACCT_CUST_CODE                 1
UIMSMGR         UCRACCT         UCRACCT_PIDM_KEY_INDEX         UCRACCT_PREM_CODE                 2

UIMSMGR         UCRACCT         UCRACCT_UTVDELQ_FK_I           UCRACCT_DELQ_OVERRIDE             1

UIMSMGR         UCRACCT         UCRACCT_UTVSCLS_FK_I           UCRACCT_SCLS_ACCOUNT              1

UIMSMGR         UCRACCT         UCRACCT_UTRAFMT_FK_I           UCRACCT_BANK_CODE                 1
UIMSMGR         UCRACCT         UCRACCT_UTRAFMT_FK_I           UCRACCT_AFMT_CODE                 2


--------------------------------------------------------------------------------------------------

