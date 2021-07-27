	set echo on;
--	====================================================================
--	Rules governing Find_Address validation procedure
--	Find_Address_Rule_Vw defines each column of this table
--	====================================================================

	create table	garland.Find_Address_Rule
(
	rule_01			varchar2(20),
	rule_02			varchar2(20),

	rule_03			varchar2(10),
	rule_04			varchar2(10),
	rule_05			varchar2(10),
	rule_06			varchar2(10),
	rule_07			varchar2(10),
	rule_08			varchar2(10),
	rule_09			varchar2(10),
	rule_10			varchar2(10),
	rule_11			varchar2(10),
	rule_12			varchar2(10),
	rule_13			varchar2(10),
	rule_14			varchar2(10),
	rule_15			varchar2(10),
	rule_16			varchar2(10),
	rule_17			varchar2(10),
	rule_18			varchar2(10),
	rule_19			varchar2(10),
	rule_20			varchar2(10),
	rule_21			varchar2(10),
	rule_22			varchar2(10),
	rule_23			varchar2(10),
	rule_24			varchar2(10),
	rule_25			varchar2(10),
	rule_26			varchar2(10),
	rule_27			varchar2(10),
	rule_28			varchar2(10),
	rule_29			varchar2(10),
	rule_30			varchar2(10)
)

	tablespace		gis_data
	storage		(initial 64k  next 64k  pctincrease 0)
	nologging;

--	====================================================================
	set echo off;
