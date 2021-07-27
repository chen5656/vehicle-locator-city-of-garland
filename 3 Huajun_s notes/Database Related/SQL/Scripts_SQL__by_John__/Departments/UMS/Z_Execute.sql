Echo                            OFF
ORA-20000: ORU-10027: buffer overflow, limit of 99999 bytes
ORA-06512: at "SYS.DBMS_OUTPUT", line 91
ORA-06512: at "SYS.DBMS_OUTPUT", line 58
ORA-06512: at line 71
;
 
select  'AM00100M' " ",  'ASSET_MODEL' " ",  rpad(ASSET_MODEL,20) " " 
from SFG.AM00100M@UMSP.WORLD where ASSET_MODEL like '%tp'	
 and rownum < 2;

select  'AM00100M' " ",  'ASSET_QUALIFIER' " ",  rpad(ASSET_QUALIFIER,20) " " 
from SFG.AM00100M@UMSP.WORLD where ASSET_QUALIFIER like '%tp'	
 and rownum < 2;

select  'AM00200M' " ",  'FMT_CD' " ",  rpad(FMT_CD,20) " " 
from SFG.AM00200M@UMSP.WORLD where FMT_CD like '%tp'	
 and rownum < 2;

select  'AM00200M' " ",  'ATTRIBUTE_CD' " ",  rpad(ATTRIBUTE_CD,20) " " 
from SFG.AM00200M@UMSP.WORLD where ATTRIBUTE_CD like '%tp'	
 and rownum < 2;

select  'AM00200M' " ",  'OBJECT_CD' " ",  rpad(OBJECT_CD,20) " " 
from SFG.AM00200M@UMSP.WORLD where OBJECT_CD like '%tp'	
 and rownum < 2;

select  'AM00200M' " ",  'CONTROL_CD' " ",  rpad(CONTROL_CD,20) " " 
from SFG.AM00200M@UMSP.WORLD where CONTROL_CD like '%tp'	
 and rownum < 2;

select  'AM00206M' " ",  'FMT_CD' " ",  rpad(FMT_CD,20) " " 
from SFG.AM00206M@UMSP.WORLD where FMT_CD like '%tp'	
 and rownum < 2;

select  'AM00206M' " ",  'ATTRIBUTE_CD' " ",  rpad(ATTRIBUTE_CD,20) " " 
from SFG.AM00206M@UMSP.WORLD where ATTRIBUTE_CD like '%tp'	
 and rownum < 2;

select  'AM00220M' " ",  'FMT_CD' " ",  rpad(FMT_CD,20) " " 
from SFG.AM00220M@UMSP.WORLD where FMT_CD like '%tp'	
 and rownum < 2;

select  'AM00510M' " ",  'FMT_CD' " ",  rpad(FMT_CD,20) " " 
from SFG.AM00510M@UMSP.WORLD where FMT_CD like '%tp'	
 and rownum < 2;

select  'AM00511M' " ",  'FMT_CD' " ",  rpad(FMT_CD,20) " " 
from SFG.AM00511M@UMSP.WORLD where FMT_CD like '%tp'	
 and rownum < 2;

select  'AM01200M' " ",  'TABLE_ID' " ",  rpad(TABLE_ID,20) " " 
from SFG.AM01200M@UMSP.WORLD where TABLE_ID like '%tp'	
 and rownum < 2;

select  'AM03300C' " ",  'SHEET_NO' " ",  rpad(SHEET_NO,20) " " 
from SFG.AM03300C@UMSP.WORLD where SHEET_NO like '%tp'	
 and rownum < 2;

select  'AM03300C' " ",  'SEQ_NO' " ",  rpad(SEQ_NO,20) " " 
from SFG.AM03300C@UMSP.WORLD where SEQ_NO like '%tp'	
 and rownum < 2;

select  'AM03300C' " ",  'JOB_OBJECT' " ",  rpad(JOB_OBJECT,20) " " 
from SFG.AM03300C@UMSP.WORLD where JOB_OBJECT like '%tp'	
 and rownum < 2;

select  'AM03510M' " ",  'SEQ_NO' " ",  rpad(SEQ_NO,20) " " 
from SFG.AM03510M@UMSP.WORLD where SEQ_NO like '%tp'	
 and rownum < 2;

select  'AM50001C' " ",  'OBJECT_CD' " ",  rpad(OBJECT_CD,20) " " 
from SFG.AM50001C@UMSP.WORLD where OBJECT_CD like '%tp'	
 and rownum < 2;

select  'AM50001C' " ",  'CONTROL_CD' " ",  rpad(CONTROL_CD,20) " " 
from SFG.AM50001C@UMSP.WORLD where CONTROL_CD like '%tp'	
 and rownum < 2;

select  'AM50010C' " ",  'OBJECT_CD' " ",  rpad(OBJECT_CD,20) " " 
from SFG.AM50010C@UMSP.WORLD where OBJECT_CD like '%tp'	
 and rownum < 2;

select  'AM50010C' " ",  'CONTROL_CD' " ",  rpad(CONTROL_CD,20) " " 
from SFG.AM50010C@UMSP.WORLD where CONTROL_CD like '%tp'	
 and rownum < 2;

select  'AM50010C' " ",  'SUBCNTL_CD_SFG' " ",  rpad(SUBCNTL_CD_SFG,20) " " 
from SFG.AM50010C@UMSP.WORLD where SUBCNTL_CD_SFG like '%tp'	
 and rownum < 2;

select  'AM50010C' " ",  'SUBCNTL_CD_CUSTOM' " ",  rpad(SUBCNTL_CD_CUSTOM,20) " " 
from SFG.AM50010C@UMSP.WORLD where SUBCNTL_CD_CUSTOM like '%tp'	
 and rownum < 2;

select  'AM50010C' " ",  'SUBCNTL_CD_GRP' " ",  rpad(SUBCNTL_CD_GRP,20) " " 
from SFG.AM50010C@UMSP.WORLD where SUBCNTL_CD_GRP like '%tp'	
 and rownum < 2;

select  'AMCHILDREN' " ",  'UN_END_USER' " ",  rpad(UN_END_USER,20) " " 
from SFG.AMCHILDREN@UMSP.WORLD where UN_END_USER like '%tp'	
 and rownum < 2;

select  'AP914T' " ",  'AP914T_SEQUENCE' " ",  rpad(AP914T_SEQUENCE,20) " " 
from SFG.AP914T@UMSP.WORLD where AP914T_SEQUENCE like '%tp'	
 and rownum < 2;

select  'AP914T' " ",  'VENDOR' " ",  rpad(VENDOR,20) " " 
from SFG.AP914T@UMSP.WORLD where VENDOR like '%tp'	
 and rownum < 2;

select  'AR00100T' " ",  'GROUP_STAT' " ",  rpad(GROUP_STAT,20) " " 
from SFG.AR00100T@UMSP.WORLD where GROUP_STAT like '%tp'	
 and rownum < 2;

select  'AR00200T' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.AR00200T@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'AR00200T' " ",  'ITEM_CATEGORY' " ",  rpad(ITEM_CATEGORY,20) " " 
from SFG.AR00200T@UMSP.WORLD where ITEM_CATEGORY like '%tp'	
 and rownum < 2;

select  'AR00200T' " ",  'ITEM_SUMMARY' " ",  rpad(ITEM_SUMMARY,20) " " 
from SFG.AR00200T@UMSP.WORLD where ITEM_SUMMARY like '%tp'	
 and rownum < 2;

select  'AR00200T' " ",  'ITEM_STAT' " ",  rpad(ITEM_STAT,20) " " 
from SFG.AR00200T@UMSP.WORLD where ITEM_STAT like '%tp'	
 and rownum < 2;

select  'AR00200T' " ",  'SOURCE_SS_ID' " ",  rpad(SOURCE_SS_ID,20) " " 
from SFG.AR00200T@UMSP.WORLD where SOURCE_SS_ID like '%tp'	
 and rownum < 2;

select  'AR00280T' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.AR00280T@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'AR00300T' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.AR00300T@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'AR00500T' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.AR00500T@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'AR00500T' " ",  'METHOD_OF_DRAFT_OVR' " ",  rpad(METHOD_OF_DRAFT_OVR,20) " " 
from SFG.AR00500T@UMSP.WORLD where METHOD_OF_DRAFT_OVR like '%tp'	
 and rownum < 2;

select  'AR00500T' " ",  'BANK_ACCOUNT_TP' " ",  rpad(BANK_ACCOUNT_TP,20) " " 
from SFG.AR00500T@UMSP.WORLD where BANK_ACCOUNT_TP like '%tp'	
 and rownum < 2;

select  'AR00500T' " ",  'PREFERRED_DRAFT_DT_TP' " ",  rpad(PREFERRED_DRAFT_DT_TP,20) " " 
from SFG.AR00500T@UMSP.WORLD where PREFERRED_DRAFT_DT_TP like '%tp'	
 and rownum < 2;

select  'AR00610T' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.AR00610T@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'AR00610T' " ",  'METHOD_OF_DRAFT' " ",  rpad(METHOD_OF_DRAFT,20) " " 
from SFG.AR00610T@UMSP.WORLD where METHOD_OF_DRAFT like '%tp'	
 and rownum < 2;

select  'AR00610T' " ",  'BANK_ACCOUNT_TP' " ",  rpad(BANK_ACCOUNT_TP,20) " " 
from SFG.AR00610T@UMSP.WORLD where BANK_ACCOUNT_TP like '%tp'	
 and rownum < 2;

select  'AR02000T' " ",  'HEADER_STAT' " ",  rpad(HEADER_STAT,20) " " 
from SFG.AR02000T@UMSP.WORLD where HEADER_STAT like '%tp'	
 and rownum < 2;

select  'AR02000T' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.AR02000T@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'AR20200W' " ",  'MATCH_SUMMARY_CD' " ",  rpad(MATCH_SUMMARY_CD,20) " " 
from SFG.AR20200W@UMSP.WORLD where MATCH_SUMMARY_CD like '%tp'	
 and rownum < 2;

select  'AR50100C' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.AR50100C@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'AR50100C' " ",  'ITEM_STAT_DFLT' " ",  rpad(ITEM_STAT_DFLT,20) " " 
from SFG.AR50100C@UMSP.WORLD where ITEM_STAT_DFLT like '%tp'	
 and rownum < 2;

select  'AR50100C' " ",  'CATEGORY_CD_DFLT' " ",  rpad(CATEGORY_CD_DFLT,20) " " 
from SFG.AR50100C@UMSP.WORLD where CATEGORY_CD_DFLT like '%tp'	
 and rownum < 2;

select  'AR50100C' " ",  'SUMMARY_CD_DFLT' " ",  rpad(SUMMARY_CD_DFLT,20) " " 
from SFG.AR50100C@UMSP.WORLD where SUMMARY_CD_DFLT like '%tp'	
 and rownum < 2;

select  'AR50200C' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.AR50200C@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'AR50200C' " ",  'MATCHING_RULE_TP' " ",  rpad(MATCHING_RULE_TP,20) " " 
from SFG.AR50200C@UMSP.WORLD where MATCHING_RULE_TP like '%tp'	
 and rownum < 2;

select  'AR50400C' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.AR50400C@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'AR50400C' " ",  'AGING_CD' " ",  rpad(AGING_CD,20) " " 
from SFG.AR50400C@UMSP.WORLD where AGING_CD like '%tp'	
 and rownum < 2;

select  'AR50500C' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.AR50500C@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'AR50500C' " ",  'CATEGORY_CD' " ",  rpad(CATEGORY_CD,20) " " 
from SFG.AR50500C@UMSP.WORLD where CATEGORY_CD like '%tp'	
 and rownum < 2;

select  'AR50600C' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.AR50600C@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'AR50600C' " ",  'SUMMARY_CD' " ",  rpad(SUMMARY_CD,20) " " 
from SFG.AR50600C@UMSP.WORLD where SUMMARY_CD like '%tp'	
 and rownum < 2;

select  'AR50700C' " ",  'METHOD_OF_DRAFT' " ",  rpad(METHOD_OF_DRAFT,20) " " 
from SFG.AR50700C@UMSP.WORLD where METHOD_OF_DRAFT like '%tp'	
 and rownum < 2;

select  'AR50700C' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.AR50700C@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'AR50900C' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.AR50900C@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'AR51000C' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.AR51000C@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'AR51000C' " ",  'SUMMARY_CD' " ",  rpad(SUMMARY_CD,20) " " 
from SFG.AR51000C@UMSP.WORLD where SUMMARY_CD like '%tp'	
 and rownum < 2;

select  'CO00100T' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.CO00100T@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'CO00100T' " ",  'STREAM_CD' " ",  rpad(STREAM_CD,20) " " 
from SFG.CO00100T@UMSP.WORLD where STREAM_CD like '%tp'	
 and rownum < 2;

select  'CO00100T' " ",  'ACTION_CD' " ",  rpad(ACTION_CD,20) " " 
from SFG.CO00100T@UMSP.WORLD where ACTION_CD like '%tp'	
 and rownum < 2;

select  'CO00100T' " ",  'CREDIT_EVENT_CD' " ",  rpad(CREDIT_EVENT_CD,20) " " 
from SFG.CO00100T@UMSP.WORLD where CREDIT_EVENT_CD like '%tp'	
 and rownum < 2;

select  'CO00200M' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.CO00200M@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'CO00200M' " ",  'STATUS_CD' " ",  rpad(STATUS_CD,20) " " 
from SFG.CO00200M@UMSP.WORLD where STATUS_CD like '%tp'	
 and rownum < 2;

select  'CO00200M' " ",  'PAY_OPTION_CD' " ",  rpad(PAY_OPTION_CD,20) " " 
from SFG.CO00200M@UMSP.WORLD where PAY_OPTION_CD like '%tp'	
 and rownum < 2;

select  'CO00200M' " ",  'STREAM_CD' " ",  rpad(STREAM_CD,20) " " 
from SFG.CO00200M@UMSP.WORLD where STREAM_CD like '%tp'	
 and rownum < 2;

select  'CO00300T' " ",  'SUBSYSTEM_CD' " ",  rpad(SUBSYSTEM_CD,20) " " 
from SFG.CO00300T@UMSP.WORLD where SUBSYSTEM_CD like '%tp'	
 and rownum < 2;

select  'CO00300T' " ",  'CREDIT_EVENT_CD' " ",  rpad(CREDIT_EVENT_CD,20) " " 
from SFG.CO00300T@UMSP.WORLD where CREDIT_EVENT_CD like '%tp'	
 and rownum < 2;

select  'CO00400M' " ",  'UN_END_USER' " ",  rpad(UN_END_USER,20) " " 
from SFG.CO00400M@UMSP.WORLD where UN_END_USER like '%tp'	
 and rownum < 2;

select  'CO00400M' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.CO00400M@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'CO00400M' " ",  'STATUS_CD' " ",  rpad(STATUS_CD,20) " " 
from SFG.CO00400M@UMSP.WORLD where STATUS_CD like '%tp'	
 and rownum < 2;

select  'CO00400T' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.CO00400T@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'CO00400T' " ",  'STATUS_CD' " ",  rpad(STATUS_CD,20) " " 
from SFG.CO00400T@UMSP.WORLD where STATUS_CD like '%tp'	
 and rownum < 2;

select  'CO00410M' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.CO00410M@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'CO00410M' " ",  'AGY_STATUS_CD' " ",  rpad(AGY_STATUS_CD,20) " " 
from SFG.CO00410M@UMSP.WORLD where AGY_STATUS_CD like '%tp'	
 and rownum < 2;

select  'CO00410M' " ",  'UN_END_USER' " ",  rpad(UN_END_USER,20) " " 
from SFG.CO00410M@UMSP.WORLD where UN_END_USER like '%tp'	
 and rownum < 2;

select  'CO00410T' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.CO00410T@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'CO00410T' " ",  'UN_END_USER' " ",  rpad(UN_END_USER,20) " " 
from SFG.CO00410T@UMSP.WORLD where UN_END_USER like '%tp'	
 and rownum < 2;

select  'CO00450T' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.CO00450T@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'CO00450T' " ",  'CYCLE_CD' " ",  rpad(CYCLE_CD,20) " " 
from SFG.CO00450T@UMSP.WORLD where CYCLE_CD like '%tp'	
 and rownum < 2;

select  'CO00450T' " ",  'CUST_STATE' " ",  rpad(CUST_STATE,20) " " 
from SFG.CO00450T@UMSP.WORLD where CUST_STATE like '%tp'	
 and rownum < 2;

select  'CO00450T' " ",  'PREL_TP1' " ",  rpad(PREL_TP1,20) " " 
from SFG.CO00450T@UMSP.WORLD where PREL_TP1 like '%tp'	
 and rownum < 2;

select  'CO00450T' " ",  'PREL_TP2' " ",  rpad(PREL_TP2,20) " " 
from SFG.CO00450T@UMSP.WORLD where PREL_TP2 like '%tp'	
 and rownum < 2;

select  'CO00450T' " ",  'PREL_TP3' " ",  rpad(PREL_TP3,20) " " 
from SFG.CO00450T@UMSP.WORLD where PREL_TP3 like '%tp'	
 and rownum < 2;

select  'CO00450T' " ",  'PREL_TP4' " ",  rpad(PREL_TP4,20) " " 
from SFG.CO00450T@UMSP.WORLD where PREL_TP4 like '%tp'	
 and rownum < 2;

select  'CO00450T' " ",  'PREL_TP5' " ",  rpad(PREL_TP5,20) " " 
from SFG.CO00450T@UMSP.WORLD where PREL_TP5 like '%tp'	
 and rownum < 2;

select  'CO50100C' " ",  'STREAM_CD' " ",  rpad(STREAM_CD,20) " " 
from SFG.CO50100C@UMSP.WORLD where STREAM_CD like '%tp'	
 and rownum < 2;

select  'CO50110C' " ",  'STREAM_CD' " ",  rpad(STREAM_CD,20) " " 
from SFG.CO50110C@UMSP.WORLD where STREAM_CD like '%tp'	
 and rownum < 2;

select  'CO50110C' " ",  'ACTION_CD' " ",  rpad(ACTION_CD,20) " " 
from SFG.CO50110C@UMSP.WORLD where ACTION_CD like '%tp'	
 and rownum < 2;

select  'CO50110C' " ",  'SUBSYSTEM_CD' " ",  rpad(SUBSYSTEM_CD,20) " " 
from SFG.CO50110C@UMSP.WORLD where SUBSYSTEM_CD like '%tp'	
 and rownum < 2;

select  'CO50110C' " ",  'CREDIT_EVENT_CD' " ",  rpad(CREDIT_EVENT_CD,20) " " 
from SFG.CO50110C@UMSP.WORLD where CREDIT_EVENT_CD like '%tp'	
 and rownum < 2;

select  'CO50110C' " ",  'AR_SUBSYSTEM_ID' " ",  rpad(AR_SUBSYSTEM_ID,20) " " 
from SFG.CO50110C@UMSP.WORLD where AR_SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'CO50110C' " ",  'RS_REQUEST_TP' " ",  rpad(RS_REQUEST_TP,20) " " 
from SFG.CO50110C@UMSP.WORLD where RS_REQUEST_TP like '%tp'	
 and rownum < 2;

select  'CO50110C' " ",  'CONTINUOUS_STREAM_CD' " ",  rpad(CONTINUOUS_STREAM_CD,20) " " 
from SFG.CO50110C@UMSP.WORLD where CONTINUOUS_STREAM_CD like '%tp'	
 and rownum < 2;

select  'CO50110C' " ",  'MIN_AMT_IND' " ",  rpad(MIN_AMT_IND,20) " " 
from SFG.CO50110C@UMSP.WORLD where MIN_AMT_IND like '%tp'	
 and rownum < 2;

select  'CO50110C' " ",  'LANDLORD_STREAM_CD' " ",  rpad(LANDLORD_STREAM_CD,20) " " 
from SFG.CO50110C@UMSP.WORLD where LANDLORD_STREAM_CD like '%tp'	
 and rownum < 2;

select  'CO50111C' " ",  'STREAM_CD' " ",  rpad(STREAM_CD,20) " " 
from SFG.CO50111C@UMSP.WORLD where STREAM_CD like '%tp'	
 and rownum < 2;

select  'CO50111C' " ",  'ACTION_CD' " ",  rpad(ACTION_CD,20) " " 
from SFG.CO50111C@UMSP.WORLD where ACTION_CD like '%tp'	
 and rownum < 2;

select  'CO50111C' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.CO50111C@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'CO50111C' " ",  'SUMMARY_CD' " ",  rpad(SUMMARY_CD,20) " " 
from SFG.CO50111C@UMSP.WORLD where SUMMARY_CD like '%tp'	
 and rownum < 2;

select  'CO50111C' " ",  'RS_REQUEST_TP' " ",  rpad(RS_REQUEST_TP,20) " " 
from SFG.CO50111C@UMSP.WORLD where RS_REQUEST_TP like '%tp'	
 and rownum < 2;

select  'CO50120C' " ",  'BILLING_STAT' " ",  rpad(BILLING_STAT,20) " " 
from SFG.CO50120C@UMSP.WORLD where BILLING_STAT like '%tp'	
 and rownum < 2;

select  'CO50120C' " ",  'SUBSYSTEM_CD' " ",  rpad(SUBSYSTEM_CD,20) " " 
from SFG.CO50120C@UMSP.WORLD where SUBSYSTEM_CD like '%tp'	
 and rownum < 2;

select  'CO50120C' " ",  'CREDIT_RATING_CD' " ",  rpad(CREDIT_RATING_CD,20) " " 
from SFG.CO50120C@UMSP.WORLD where CREDIT_RATING_CD like '%tp'	
 and rownum < 2;

select  'CO50120C' " ",  'ACCOUNT_CLASS' " ",  rpad(ACCOUNT_CLASS,20) " " 
from SFG.CO50120C@UMSP.WORLD where ACCOUNT_CLASS like '%tp'	
 and rownum < 2;

select  'CO50120C' " ",  'STREAM_CD' " ",  rpad(STREAM_CD,20) " " 
from SFG.CO50120C@UMSP.WORLD where STREAM_CD like '%tp'	
 and rownum < 2;

select  'CO50200C' " ",  'CALC_METHOD' " ",  rpad(CALC_METHOD,20) " " 
from SFG.CO50200C@UMSP.WORLD where CALC_METHOD like '%tp'	
 and rownum < 2;

select  'CO50200C' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.CO50200C@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'CO50200C' " ",  'UN_END_USER' " ",  rpad(UN_END_USER,20) " " 
from SFG.CO50200C@UMSP.WORLD where UN_END_USER like '%tp'	
 and rownum < 2;

select  'CO50200C' " ",  'MIN_AMT_IND' " ",  rpad(MIN_AMT_IND,20) " " 
from SFG.CO50200C@UMSP.WORLD where MIN_AMT_IND like '%tp'	
 and rownum < 2;

select  'CO50210C' " ",  'ACCOUNT_CLASS' " ",  rpad(ACCOUNT_CLASS,20) " " 
from SFG.CO50210C@UMSP.WORLD where ACCOUNT_CLASS like '%tp'	
 and rownum < 2;

select  'CO50210C' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.CO50210C@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'CO50210C' " ",  'SUMMARY_CD' " ",  rpad(SUMMARY_CD,20) " " 
from SFG.CO50210C@UMSP.WORLD where SUMMARY_CD like '%tp'	
 and rownum < 2;

select  'CO50210C' " ",  'UN_END_USER' " ",  rpad(UN_END_USER,20) " " 
from SFG.CO50210C@UMSP.WORLD where UN_END_USER like '%tp'	
 and rownum < 2;

select  'CO50210C' " ",  'AGING_CD' " ",  rpad(AGING_CD,20) " " 
from SFG.CO50210C@UMSP.WORLD where AGING_CD like '%tp'	
 and rownum < 2;

select  'CO50300C' " ",  'SUBSYSTEM_CD' " ",  rpad(SUBSYSTEM_CD,20) " " 
from SFG.CO50300C@UMSP.WORLD where SUBSYSTEM_CD like '%tp'	
 and rownum < 2;

select  'CO50300C' " ",  'CREDIT_EVENT_CD' " ",  rpad(CREDIT_EVENT_CD,20) " " 
from SFG.CO50300C@UMSP.WORLD where CREDIT_EVENT_CD like '%tp'	
 and rownum < 2;

select  'CO50300C' " ",  'SFG_CD' " ",  rpad(SFG_CD,20) " " 
from SFG.CO50300C@UMSP.WORLD where SFG_CD like '%tp'	
 and rownum < 2;

select  'CO50310C' " ",  'SUBSYSTEM_CD' " ",  rpad(SUBSYSTEM_CD,20) " " 
from SFG.CO50310C@UMSP.WORLD where SUBSYSTEM_CD like '%tp'	
 and rownum < 2;

select  'CO50310C' " ",  'CREDIT_RATING_CD' " ",  rpad(CREDIT_RATING_CD,20) " " 
from SFG.CO50310C@UMSP.WORLD where CREDIT_RATING_CD like '%tp'	
 and rownum < 2;

select  'CO50310C' " ",  'SFG_CD' " ",  rpad(SFG_CD,20) " " 
from SFG.CO50310C@UMSP.WORLD where SFG_CD like '%tp'	
 and rownum < 2;

select  'GL98000T' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.GL98000T@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'GL98100T' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.GL98100T@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'OAM00220M' " ",  'FMT_CD' " ",  rpad(FMT_CD,20) " " 
from SFG.OAM00220M@UMSP.WORLD where FMT_CD like '%tp'	
 and rownum < 2;

select  'OAM50001C' " ",  'OBJECT_CD' " ",  rpad(OBJECT_CD,20) " " 
from SFG.OAM50001C@UMSP.WORLD where OBJECT_CD like '%tp'	
 and rownum < 2;

select  'OAM50001C' " ",  'CONTROL_CD' " ",  rpad(CONTROL_CD,20) " " 
from SFG.OAM50001C@UMSP.WORLD where CONTROL_CD like '%tp'	
 and rownum < 2;

select  'OAM50010C' " ",  'OBJECT_CD' " ",  rpad(OBJECT_CD,20) " " 
from SFG.OAM50010C@UMSP.WORLD where OBJECT_CD like '%tp'	
 and rownum < 2;

select  'OAM50010C' " ",  'CONTROL_CD' " ",  rpad(CONTROL_CD,20) " " 
from SFG.OAM50010C@UMSP.WORLD where CONTROL_CD like '%tp'	
 and rownum < 2;

select  'OAM50010C' " ",  'SUBCNTL_CD_SFG' " ",  rpad(SUBCNTL_CD_SFG,20) " " 
from SFG.OAM50010C@UMSP.WORLD where SUBCNTL_CD_SFG like '%tp'	
 and rownum < 2;

select  'OAR50100C' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.OAR50100C@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'OAR50400C' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.OAR50400C@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'OAR50400C' " ",  'AGING_CD' " ",  rpad(AGING_CD,20) " " 
from SFG.OAR50400C@UMSP.WORLD where AGING_CD like '%tp'	
 and rownum < 2;

select  'OAR50500C' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.OAR50500C@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'OAR50500C' " ",  'CATEGORY_CD' " ",  rpad(CATEGORY_CD,20) " " 
from SFG.OAR50500C@UMSP.WORLD where CATEGORY_CD like '%tp'	
 and rownum < 2;

select  'OAR50600C' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.OAR50600C@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'OAR50600C' " ",  'SUMMARY_CD' " ",  rpad(SUMMARY_CD,20) " " 
from SFG.OAR50600C@UMSP.WORLD where SUMMARY_CD like '%tp'	
 and rownum < 2;

select  'OAR50700C' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.OAR50700C@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'OAR50700C' " ",  'METHOD_OF_DRAFT' " ",  rpad(METHOD_OF_DRAFT,20) " " 
from SFG.OAR50700C@UMSP.WORLD where METHOD_OF_DRAFT like '%tp'	
 and rownum < 2;

select  'OCO00400M' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.OCO00400M@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'OCO50200C' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.OCO50200C@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'OGL98000T' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.OGL98000T@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'OGL98100T' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.OGL98100T@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'OPP50100C' " ",  'TEMPLATE_CD' " ",  rpad(TEMPLATE_CD,20) " " 
from SFG.OPP50100C@UMSP.WORLD where TEMPLATE_CD like '%tp'	
 and rownum < 2;

select  'OPP50200C' " ",  'METHOD' " ",  rpad(METHOD,20) " " 
from SFG.OPP50200C@UMSP.WORLD where METHOD like '%tp'	
 and rownum < 2;

select  'OPP50400C' " ",  'LOCATION_CD' " ",  rpad(LOCATION_CD,20) " " 
from SFG.OPP50400C@UMSP.WORLD where LOCATION_CD like '%tp'	
 and rownum < 2;

select  'OPP50600C' " ",  'SOURCE_CD' " ",  rpad(SOURCE_CD,20) " " 
from SFG.OPP50600C@UMSP.WORLD where SOURCE_CD like '%tp'	
 and rownum < 2;

select  'ORS50100C' " ",  'REQUEST_TP' " ",  rpad(REQUEST_TP,20) " " 
from SFG.ORS50100C@UMSP.WORLD where REQUEST_TP like '%tp'	
 and rownum < 2;

select  'ORS50200C' " ",  'ACTION_CD' " ",  rpad(ACTION_CD,20) " " 
from SFG.ORS50200C@UMSP.WORLD where ACTION_CD like '%tp'	
 and rownum < 2;

select  'ORS50240C' " ",  'ACTION_CD' " ",  rpad(ACTION_CD,20) " " 
from SFG.ORS50240C@UMSP.WORLD where ACTION_CD like '%tp'	
 and rownum < 2;

select  'ORS50240C' " ",  'ACTION_STOPPER_CD' " ",  rpad(ACTION_STOPPER_CD,20) " " 
from SFG.ORS50240C@UMSP.WORLD where ACTION_STOPPER_CD like '%tp'	
 and rownum < 2;

select  'OSG00300T' " ",  'OWNERSHIP_CD' " ",  rpad(OWNERSHIP_CD,20) " " 
from SFG.OSG00300T@UMSP.WORLD where OWNERSHIP_CD like '%tp'	
 and rownum < 2;

select  'OSG00400T' " ",  'OWNERSHIP_CD' " ",  rpad(OWNERSHIP_CD,20) " " 
from SFG.OSG00400T@UMSP.WORLD where OWNERSHIP_CD like '%tp'	
 and rownum < 2;

select  'OSG00400T' " ",  'ALERT_CD' " ",  rpad(ALERT_CD,20) " " 
from SFG.OSG00400T@UMSP.WORLD where ALERT_CD like '%tp'	
 and rownum < 2;

select  'OSG00500T' " ",  'OBJECT_CD' " ",  rpad(OBJECT_CD,20) " " 
from SFG.OSG00500T@UMSP.WORLD where OBJECT_CD like '%tp'	
 and rownum < 2;

select  'OSG00500T' " ",  'FUNCTION_CD' " ",  rpad(FUNCTION_CD,20) " " 
from SFG.OSG00500T@UMSP.WORLD where FUNCTION_CD like '%tp'	
 and rownum < 2;

select  'OSG00600M' " ",  'OBJECT_CD' " ",  rpad(OBJECT_CD,20) " " 
from SFG.OSG00600M@UMSP.WORLD where OBJECT_CD like '%tp'	
 and rownum < 2;

select  'OSG00600M' " ",  'PREF_CD' " ",  rpad(PREF_CD,20) " " 
from SFG.OSG00600M@UMSP.WORLD where PREF_CD like '%tp'	
 and rownum < 2;

select  'OSG50000C' " ",  'OBJECT_CD' " ",  rpad(OBJECT_CD,20) " " 
from SFG.OSG50000C@UMSP.WORLD where OBJECT_CD like '%tp'	
 and rownum < 2;

select  'OSG50000C' " ",  'CONTROL_CD' " ",  rpad(CONTROL_CD,20) " " 
from SFG.OSG50000C@UMSP.WORLD where CONTROL_CD like '%tp'	
 and rownum < 2;

select  'OSG50010C' " ",  'OBJECT_CD' " ",  rpad(OBJECT_CD,20) " " 
from SFG.OSG50010C@UMSP.WORLD where OBJECT_CD like '%tp'	
 and rownum < 2;

select  'OSG50010C' " ",  'CONTROL_CD' " ",  rpad(CONTROL_CD,20) " " 
from SFG.OSG50010C@UMSP.WORLD where CONTROL_CD like '%tp'	
 and rownum < 2;

select  'OSG50010C' " ",  'SUBCNTL_CD_SFG' " ",  rpad(SUBCNTL_CD_SFG,20) " " 
from SFG.OSG50010C@UMSP.WORLD where SUBCNTL_CD_SFG like '%tp'	
 and rownum < 2;

select  'OSG50100C' " ",  'PROVINCE_CD' " ",  rpad(PROVINCE_CD,20) " " 
from SFG.OSG50100C@UMSP.WORLD where PROVINCE_CD like '%tp'	
 and rownum < 2;

select  'OSG50300C' " ",  'OWNERSHIP_CD' " ",  rpad(OWNERSHIP_CD,20) " " 
from SFG.OSG50300C@UMSP.WORLD where OWNERSHIP_CD like '%tp'	
 and rownum < 2;

select  'OSG50300C' " ",  'ALERT_CD_SFG' " ",  rpad(ALERT_CD_SFG,20) " " 
from SFG.OSG50300C@UMSP.WORLD where ALERT_CD_SFG like '%tp'	
 and rownum < 2;

select  'OUM00142T' " ",  'BILL_CD' " ",  rpad(BILL_CD,20) " " 
from SFG.OUM00142T@UMSP.WORLD where BILL_CD like '%tp'	
 and rownum < 2;

select  'OUM00144T' " ",  'TAX_CD' " ",  rpad(TAX_CD,20) " " 
from SFG.OUM00144T@UMSP.WORLD where TAX_CD like '%tp'	
 and rownum < 2;

select  'OUM00150T' " ",  'ASSET_TP' " ",  rpad(ASSET_TP,20) " " 
from SFG.OUM00150T@UMSP.WORLD where ASSET_TP like '%tp'	
 and rownum < 2;

select  'OUM00151T' " ",  'ASSET_TP' " ",  rpad(ASSET_TP,20) " " 
from SFG.OUM00151T@UMSP.WORLD where ASSET_TP like '%tp'	
 and rownum < 2;

select  'OUM00155T' " ",  'UMS_ASSET_TP' " ",  rpad(UMS_ASSET_TP,20) " " 
from SFG.OUM00155T@UMSP.WORLD where UMS_ASSET_TP like '%tp'	
 and rownum < 2;

select  'OUM00162T' " ",  'BILL_CD' " ",  rpad(BILL_CD,20) " " 
from SFG.OUM00162T@UMSP.WORLD where BILL_CD like '%tp'	
 and rownum < 2;

select  'OUM00170T' " ",  'ASSET_TP' " ",  rpad(ASSET_TP,20) " " 
from SFG.OUM00170T@UMSP.WORLD where ASSET_TP like '%tp'	
 and rownum < 2;

select  'OUM00170T' " ",  'CONFIG_CD' " ",  rpad(CONFIG_CD,20) " " 
from SFG.OUM00170T@UMSP.WORLD where CONFIG_CD like '%tp'	
 and rownum < 2;

select  'OUM00230T' " ",  'EXEMPTION_CD' " ",  rpad(EXEMPTION_CD,20) " " 
from SFG.OUM00230T@UMSP.WORLD where EXEMPTION_CD like '%tp'	
 and rownum < 2;

select  'OUM00411T' " ",  'TEST_TP' " ",  rpad(TEST_TP,20) " " 
from SFG.OUM00411T@UMSP.WORLD where TEST_TP like '%tp'	
 and rownum < 2;

select  'OUM00600M' " ",  'ASSET_TP' " ",  rpad(ASSET_TP,20) " " 
from SFG.OUM00600M@UMSP.WORLD where ASSET_TP like '%tp'	
 and rownum < 2;

select  'OUM50100C' " ",  'SERVICE_TP' " ",  rpad(SERVICE_TP,20) " " 
from SFG.OUM50100C@UMSP.WORLD where SERVICE_TP like '%tp'	
 and rownum < 2;

select  'OUM50110C' " ",  'LOCATION_CLASS' " ",  rpad(LOCATION_CLASS,20) " " 
from SFG.OUM50110C@UMSP.WORLD where LOCATION_CLASS like '%tp'	
 and rownum < 2;

select  'OUM50110C' " ",  'SERVICE_TP' " ",  rpad(SERVICE_TP,20) " " 
from SFG.OUM50110C@UMSP.WORLD where SERVICE_TP like '%tp'	
 and rownum < 2;

select  'OUM50200C' " ",  'OBJECT_CD' " ",  rpad(OBJECT_CD,20) " " 
from SFG.OUM50200C@UMSP.WORLD where OBJECT_CD like '%tp'	
 and rownum < 2;

select  'OUM50200C' " ",  'CONTROL_CD' " ",  rpad(CONTROL_CD,20) " " 
from SFG.OUM50200C@UMSP.WORLD where CONTROL_CD like '%tp'	
 and rownum < 2;

select  'OUM50200C' " ",  'SITUAT_CD' " ",  rpad(SITUAT_CD,20) " " 
from SFG.OUM50200C@UMSP.WORLD where SITUAT_CD like '%tp'	
 and rownum < 2;

select  'OUM50200C' " ",  'SUBSIT_CD' " ",  rpad(SUBSIT_CD,20) " " 
from SFG.OUM50200C@UMSP.WORLD where SUBSIT_CD like '%tp'	
 and rownum < 2;

select  'OUM50600C' " ",  'OBJECT_CD' " ",  rpad(OBJECT_CD,20) " " 
from SFG.OUM50600C@UMSP.WORLD where OBJECT_CD like '%tp'	
 and rownum < 2;

select  'OUM50600C' " ",  'CONTROL_CD' " ",  rpad(CONTROL_CD,20) " " 
from SFG.OUM50600C@UMSP.WORLD where CONTROL_CD like '%tp'	
 and rownum < 2;

select  'OUM50600C' " ",  'REPAIR_TP' " ",  rpad(REPAIR_TP,20) " " 
from SFG.OUM50600C@UMSP.WORLD where REPAIR_TP like '%tp'	
 and rownum < 2;

select  'OUM50700C' " ",  'CYCLE_CD' " ",  rpad(CYCLE_CD,20) " " 
from SFG.OUM50700C@UMSP.WORLD where CYCLE_CD like '%tp'	
 and rownum < 2;

select  'OUM51200C' " ",  'LOCATION_CLASS' " ",  rpad(LOCATION_CLASS,20) " " 
from SFG.OUM51200C@UMSP.WORLD where LOCATION_CLASS like '%tp'	
 and rownum < 2;

select  'OUM51200C' " ",  'SERVICE_TP' " ",  rpad(SERVICE_TP,20) " " 
from SFG.OUM51200C@UMSP.WORLD where SERVICE_TP like '%tp'	
 and rownum < 2;

select  'OUM51200C' " ",  'BILL_CD' " ",  rpad(BILL_CD,20) " " 
from SFG.OUM51200C@UMSP.WORLD where BILL_CD like '%tp'	
 and rownum < 2;

select  'OUM51300C' " ",  'LOCATION_CLASS' " ",  rpad(LOCATION_CLASS,20) " " 
from SFG.OUM51300C@UMSP.WORLD where LOCATION_CLASS like '%tp'	
 and rownum < 2;

select  'OUM51300C' " ",  'SERVICE_TP' " ",  rpad(SERVICE_TP,20) " " 
from SFG.OUM51300C@UMSP.WORLD where SERVICE_TP like '%tp'	
 and rownum < 2;

select  'OUM51300C' " ",  'TAX_CD' " ",  rpad(TAX_CD,20) " " 
from SFG.OUM51300C@UMSP.WORLD where TAX_CD like '%tp'	
 and rownum < 2;

select  'OUM51300C' " ",  'TAX_DISTRICT_CD' " ",  rpad(TAX_DISTRICT_CD,20) " " 
from SFG.OUM51300C@UMSP.WORLD where TAX_DISTRICT_CD like '%tp'	
 and rownum < 2;

select  'OUM51400C' " ",  'LOCATION_CLASS' " ",  rpad(LOCATION_CLASS,20) " " 
from SFG.OUM51400C@UMSP.WORLD where LOCATION_CLASS like '%tp'	
 and rownum < 2;

select  'OUM51400C' " ",  'SERVICE_TP' " ",  rpad(SERVICE_TP,20) " " 
from SFG.OUM51400C@UMSP.WORLD where SERVICE_TP like '%tp'	
 and rownum < 2;

select  'OUM51400C' " ",  'BILL_CD' " ",  rpad(BILL_CD,20) " " 
from SFG.OUM51400C@UMSP.WORLD where BILL_CD like '%tp'	
 and rownum < 2;

select  'OUM51800C' " ",  'CONTRACT_CD' " ",  rpad(CONTRACT_CD,20) " " 
from SFG.OUM51800C@UMSP.WORLD where CONTRACT_CD like '%tp'	
 and rownum < 2;

select  'OUM52000C' " ",  'CONS_RATE_CD' " ",  rpad(CONS_RATE_CD,20) " " 
from SFG.OUM52000C@UMSP.WORLD where CONS_RATE_CD like '%tp'	
 and rownum < 2;

select  'OUM52100C' " ",  'CONS_RATE_CD' " ",  rpad(CONS_RATE_CD,20) " " 
from SFG.OUM52100C@UMSP.WORLD where CONS_RATE_CD like '%tp'	
 and rownum < 2;

select  'OUM52200C' " ",  'DEM_READ_CALC_TP' " ",  rpad(DEM_READ_CALC_TP,20) " " 
from SFG.OUM52200C@UMSP.WORLD where DEM_READ_CALC_TP like '%tp'	
 and rownum < 2;

select  'OUM52300C' " ",  'BASE_RATE_CD' " ",  rpad(BASE_RATE_CD,20) " " 
from SFG.OUM52300C@UMSP.WORLD where BASE_RATE_CD like '%tp'	
 and rownum < 2;

select  'OUM52400C' " ",  'BASE_RATE_CD' " ",  rpad(BASE_RATE_CD,20) " " 
from SFG.OUM52400C@UMSP.WORLD where BASE_RATE_CD like '%tp'	
 and rownum < 2;

select  'OUM52400C' " ",  'METER_SZ' " ",  rpad(METER_SZ,20) " " 
from SFG.OUM52400C@UMSP.WORLD where METER_SZ like '%tp'	
 and rownum < 2;

select  'OUM52500C' " ",  'BILL_CD' " ",  rpad(BILL_CD,20) " " 
from SFG.OUM52500C@UMSP.WORLD where BILL_CD like '%tp'	
 and rownum < 2;

select  'OUM52510C' " ",  'BILL_CD' " ",  rpad(BILL_CD,20) " " 
from SFG.OUM52510C@UMSP.WORLD where BILL_CD like '%tp'	
 and rownum < 2;

select  'OUM52510C' " ",  'CHARGE_MODE' " ",  rpad(CHARGE_MODE,20) " " 
from SFG.OUM52510C@UMSP.WORLD where CHARGE_MODE like '%tp'	
 and rownum < 2;

select  'OUM52600C' " ",  'TAX_TP' " ",  rpad(TAX_TP,20) " " 
from SFG.OUM52600C@UMSP.WORLD where TAX_TP like '%tp'	
 and rownum < 2;

select  'OUM52600C' " ",  'SUBSYTEM_ID' " ",  rpad(SUBSYTEM_ID,20) " " 
from SFG.OUM52600C@UMSP.WORLD where SUBSYTEM_ID like '%tp'	
 and rownum < 2;

select  'OUM52700C' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.OUM52700C@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'OUM52700C' " ",  'TAX_CD' " ",  rpad(TAX_CD,20) " " 
from SFG.OUM52700C@UMSP.WORLD where TAX_CD like '%tp'	
 and rownum < 2;

select  'OUM52800C' " ",  'TAX_CD' " ",  rpad(TAX_CD,20) " " 
from SFG.OUM52800C@UMSP.WORLD where TAX_CD like '%tp'	
 and rownum < 2;

select  'OUM52800C' " ",  'TAX_TP' " ",  rpad(TAX_TP,20) " " 
from SFG.OUM52800C@UMSP.WORLD where TAX_TP like '%tp'	
 and rownum < 2;

select  'OUM52800C' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.OUM52800C@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'OUM52900C' " ",  'AR_MAP_CD' " ",  rpad(AR_MAP_CD,20) " " 
from SFG.OUM52900C@UMSP.WORLD where AR_MAP_CD like '%tp'	
 and rownum < 2;

select  'OUM53000C' " ",  'SERVICE_TP' " ",  rpad(SERVICE_TP,20) " " 
from SFG.OUM53000C@UMSP.WORLD where SERVICE_TP like '%tp'	
 and rownum < 2;

select  'OUM53000C' " ",  'LOCATION_CLASS' " ",  rpad(LOCATION_CLASS,20) " " 
from SFG.OUM53000C@UMSP.WORLD where LOCATION_CLASS like '%tp'	
 and rownum < 2;

select  'OUM53000C' " ",  'DEPOSIT_RULE_TP' " ",  rpad(DEPOSIT_RULE_TP,20) " " 
from SFG.OUM53000C@UMSP.WORLD where DEPOSIT_RULE_TP like '%tp'	
 and rownum < 2;

select  'OUM53010C' " ",  'INTEREST_CD' " ",  rpad(INTEREST_CD,20) " " 
from SFG.OUM53010C@UMSP.WORLD where INTEREST_CD like '%tp'	
 and rownum < 2;

select  'OUM53020C' " ",  'EVENT' " ",  rpad(EVENT,20) " " 
from SFG.OUM53020C@UMSP.WORLD where EVENT like '%tp'	
 and rownum < 2;

select  'OUM53500C' " ",  'BILL_MSG_CD' " ",  rpad(BILL_MSG_CD,20) " " 
from SFG.OUM53500C@UMSP.WORLD where BILL_MSG_CD like '%tp'	
 and rownum < 2;

select  'OUM54010C' " ",  'INTEREST_CD' " ",  rpad(INTEREST_CD,20) " " 
from SFG.OUM54010C@UMSP.WORLD where INTEREST_CD like '%tp'	
 and rownum < 2;

select  'PP00100T' " ",  'LOCATION_CD' " ",  rpad(LOCATION_CD,20) " " 
from SFG.PP00100T@UMSP.WORLD where LOCATION_CD like '%tp'	
 and rownum < 2;

select  'PP00100T' " ",  'TITLE_CD' " ",  rpad(TITLE_CD,20) " " 
from SFG.PP00100T@UMSP.WORLD where TITLE_CD like '%tp'	
 and rownum < 2;

select  'PP00100T' " ",  'STREET_PFX_DIR' " ",  rpad(STREET_PFX_DIR,20) " " 
from SFG.PP00100T@UMSP.WORLD where STREET_PFX_DIR like '%tp'	
 and rownum < 2;

select  'PP00100T' " ",  'STREET_SFX_DIR' " ",  rpad(STREET_SFX_DIR,20) " " 
from SFG.PP00100T@UMSP.WORLD where STREET_SFX_DIR like '%tp'	
 and rownum < 2;

select  'PP00100T' " ",  'SEC_ADDR_ID' " ",  rpad(SEC_ADDR_ID,20) " " 
from SFG.PP00100T@UMSP.WORLD where SEC_ADDR_ID like '%tp'	
 and rownum < 2;

select  'PP00100T' " ",  'PROVINCE_CD' " ",  rpad(PROVINCE_CD,20) " " 
from SFG.PP00100T@UMSP.WORLD where PROVINCE_CD like '%tp'	
 and rownum < 2;

select  'PP00100T' " ",  'RECEIPT_PRINT_OPT' " ",  rpad(RECEIPT_PRINT_OPT,20) " " 
from SFG.PP00100T@UMSP.WORLD where RECEIPT_PRINT_OPT like '%tp'	
 and rownum < 2;

select  'PP00110T' " ",  'METHOD' " ",  rpad(METHOD,20) " " 
from SFG.PP00110T@UMSP.WORLD where METHOD like '%tp'	
 and rownum < 2;

select  'PP00110T' " ",  'LOCATION_CD' " ",  rpad(LOCATION_CD,20) " " 
from SFG.PP00110T@UMSP.WORLD where LOCATION_CD like '%tp'	
 and rownum < 2;

select  'PP00110T' " ",  'PAYMENT_STAT' " ",  rpad(PAYMENT_STAT,20) " " 
from SFG.PP00110T@UMSP.WORLD where PAYMENT_STAT like '%tp'	
 and rownum < 2;

select  'PP00120T' " ",  'ITEM_STAT' " ",  rpad(ITEM_STAT,20) " " 
from SFG.PP00120T@UMSP.WORLD where ITEM_STAT like '%tp'	
 and rownum < 2;

select  'PP00121T' " ",  'UN_END_USER' " ",  rpad(UN_END_USER,20) " " 
from SFG.PP00121T@UMSP.WORLD where UN_END_USER like '%tp'	
 and rownum < 2;

select  'PP00200T' " ",  'SOURCE_CD' " ",  rpad(SOURCE_CD,20) " " 
from SFG.PP00200T@UMSP.WORLD where SOURCE_CD like '%tp'	
 and rownum < 2;

select  'PP00200T' " ",  'DRAWER_STAT' " ",  rpad(DRAWER_STAT,20) " " 
from SFG.PP00200T@UMSP.WORLD where DRAWER_STAT like '%tp'	
 and rownum < 2;

select  'PP00200T' " ",  'DEFAULT_METHOD' " ",  rpad(DEFAULT_METHOD,20) " " 
from SFG.PP00200T@UMSP.WORLD where DEFAULT_METHOD like '%tp'	
 and rownum < 2;

select  'PP00200T' " ",  'DEFAULT_PRINT_OPT' " ",  rpad(DEFAULT_PRINT_OPT,20) " " 
from SFG.PP00200T@UMSP.WORLD where DEFAULT_PRINT_OPT like '%tp'	
 and rownum < 2;

select  'PP00200T' " ",  'CURRENT_LOC_CD' " ",  rpad(CURRENT_LOC_CD,20) " " 
from SFG.PP00200T@UMSP.WORLD where CURRENT_LOC_CD like '%tp'	
 and rownum < 2;

select  'PP00210T' " ",  'METHOD' " ",  rpad(METHOD,20) " " 
from SFG.PP00210T@UMSP.WORLD where METHOD like '%tp'	
 and rownum < 2;

select  'PP00300T' " ",  'DEPOSIT_STAT' " ",  rpad(DEPOSIT_STAT,20) " " 
from SFG.PP00300T@UMSP.WORLD where DEPOSIT_STAT like '%tp'	
 and rownum < 2;

select  'PP00310T' " ",  'METHOD' " ",  rpad(METHOD,20) " " 
from SFG.PP00310T@UMSP.WORLD where METHOD like '%tp'	
 and rownum < 2;

select  'PP50100C' " ",  'TEMPLATE_CD' " ",  rpad(TEMPLATE_CD,20) " " 
from SFG.PP50100C@UMSP.WORLD where TEMPLATE_CD like '%tp'	
 and rownum < 2;

select  'PP50100C' " ",  'DEFAULT_METHOD' " ",  rpad(DEFAULT_METHOD,20) " " 
from SFG.PP50100C@UMSP.WORLD where DEFAULT_METHOD like '%tp'	
 and rownum < 2;

select  'PP50100C' " ",  'DEFAULT_PRINT_OPT' " ",  rpad(DEFAULT_PRINT_OPT,20) " " 
from SFG.PP50100C@UMSP.WORLD where DEFAULT_PRINT_OPT like '%tp'	
 and rownum < 2;

select  'PP50100C' " ",  'DEFAULT_LOC_CD' " ",  rpad(DEFAULT_LOC_CD,20) " " 
from SFG.PP50100C@UMSP.WORLD where DEFAULT_LOC_CD like '%tp'	
 and rownum < 2;

select  'PP50200C' " ",  'METHOD' " ",  rpad(METHOD,20) " " 
from SFG.PP50200C@UMSP.WORLD where METHOD like '%tp'	
 and rownum < 2;

select  'PP50300C' " ",  'SS_SUBSYSTEM' " ",  rpad(SS_SUBSYSTEM,20) " " 
from SFG.PP50300C@UMSP.WORLD where SS_SUBSYSTEM like '%tp'	
 and rownum < 2;

select  'PP50400C' " ",  'LOCATION_CD' " ",  rpad(LOCATION_CD,20) " " 
from SFG.PP50400C@UMSP.WORLD where LOCATION_CD like '%tp'	
 and rownum < 2;

select  'PP50600C' " ",  'SOURCE_CD' " ",  rpad(SOURCE_CD,20) " " 
from SFG.PP50600C@UMSP.WORLD where SOURCE_CD like '%tp'	
 and rownum < 2;

select  'RC00110M' " ",  'PAY_STAT' " ",  rpad(PAY_STAT,20) " " 
from SFG.RC00110M@UMSP.WORLD where PAY_STAT like '%tp'	
 and rownum < 2;

select  'RC50100C' " ",  'REASON_CD' " ",  rpad(REASON_CD,20) " " 
from SFG.RC50100C@UMSP.WORLD where REASON_CD like '%tp'	
 and rownum < 2;

select  'RC50100C' " ",  'CREDIT_EVENT_CD' " ",  rpad(CREDIT_EVENT_CD,20) " " 
from SFG.RC50100C@UMSP.WORLD where CREDIT_EVENT_CD like '%tp'	
 and rownum < 2;

select  'RE00100M' " ",  'REFUND_TP' " ",  rpad(REFUND_TP,20) " " 
from SFG.RE00100M@UMSP.WORLD where REFUND_TP like '%tp'	
 and rownum < 2;

select  'RE00100M' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.RE00100M@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'RE00100M' " ",  'SUBSYSTEM_ID_DB' " ",  rpad(SUBSYSTEM_ID_DB,20) " " 
from SFG.RE00100M@UMSP.WORLD where SUBSYSTEM_ID_DB like '%tp'	
 and rownum < 2;

select  'RE00100M' " ",  'SERVICE_TP' " ",  rpad(SERVICE_TP,20) " " 
from SFG.RE00100M@UMSP.WORLD where SERVICE_TP like '%tp'	
 and rownum < 2;

select  'RE00100M' " ",  'CALC_CD' " ",  rpad(CALC_CD,20) " " 
from SFG.RE00100M@UMSP.WORLD where CALC_CD like '%tp'	
 and rownum < 2;

select  'RE00100T' " ",  'GROUP_STAT' " ",  rpad(GROUP_STAT,20) " " 
from SFG.RE00100T@UMSP.WORLD where GROUP_STAT like '%tp'	
 and rownum < 2;

select  'RE00110T' " ",  'REFUND_STATUS' " ",  rpad(REFUND_STATUS,20) " " 
from SFG.RE00110T@UMSP.WORLD where REFUND_STATUS like '%tp'	
 and rownum < 2;

select  'RE00200T' " ",  'CHEQUE_STATUS' " ",  rpad(CHEQUE_STATUS,20) " " 
from SFG.RE00200T@UMSP.WORLD where CHEQUE_STATUS like '%tp'	
 and rownum < 2;

select  'RE00200T' " ",  'CHEQUE_TP' " ",  rpad(CHEQUE_TP,20) " " 
from SFG.RE00200T@UMSP.WORLD where CHEQUE_TP like '%tp'	
 and rownum < 2;

select  'RE00200T' " ",  'CLEAR_CD' " ",  rpad(CLEAR_CD,20) " " 
from SFG.RE00200T@UMSP.WORLD where CLEAR_CD like '%tp'	
 and rownum < 2;

select  'RE00200T' " ",  'REPLACE_CD' " ",  rpad(REPLACE_CD,20) " " 
from SFG.RE00200T@UMSP.WORLD where REPLACE_CD like '%tp'	
 and rownum < 2;

select  'RE00200T' " ",  'STREET_PFX_DIR' " ",  rpad(STREET_PFX_DIR,20) " " 
from SFG.RE00200T@UMSP.WORLD where STREET_PFX_DIR like '%tp'	
 and rownum < 2;

select  'RE00200T' " ",  'STREET_SFX_DIR' " ",  rpad(STREET_SFX_DIR,20) " " 
from SFG.RE00200T@UMSP.WORLD where STREET_SFX_DIR like '%tp'	
 and rownum < 2;

select  'RE00200T' " ",  'SEC_ADDR_ID' " ",  rpad(SEC_ADDR_ID,20) " " 
from SFG.RE00200T@UMSP.WORLD where SEC_ADDR_ID like '%tp'	
 and rownum < 2;

select  'RE00200T' " ",  'SG_PROV_CD' " ",  rpad(SG_PROV_CD,20) " " 
from SFG.RE00200T@UMSP.WORLD where SG_PROV_CD like '%tp'	
 and rownum < 2;

select  'RE00200T' " ",  'ROUTE_PFX' " ",  rpad(ROUTE_PFX,20) " " 
from SFG.RE00200T@UMSP.WORLD where ROUTE_PFX like '%tp'	
 and rownum < 2;

select  'RE00210T' " ",  'PAYMENT_TP' " ",  rpad(PAYMENT_TP,20) " " 
from SFG.RE00210T@UMSP.WORLD where PAYMENT_TP like '%tp'	
 and rownum < 2;

select  'RE00210T' " ",  'AP_VENDOR_NO' " ",  rpad(AP_VENDOR_NO,20) " " 
from SFG.RE00210T@UMSP.WORLD where AP_VENDOR_NO like '%tp'	
 and rownum < 2;

select  'RS00100M' " ",  'REQUEST_TP' " ",  rpad(REQUEST_TP,20) " " 
from SFG.RS00100M@UMSP.WORLD where REQUEST_TP like '%tp'	
 and rownum < 2;

select  'RS00100M' " ",  'OWNER_OVRD' " ",  rpad(OWNER_OVRD,20) " " 
from SFG.RS00100M@UMSP.WORLD where OWNER_OVRD like '%tp'	
 and rownum < 2;

select  'RS00100M' " ",  'SUBSYSTEM_CD' " ",  rpad(SUBSYSTEM_CD,20) " " 
from SFG.RS00100M@UMSP.WORLD where SUBSYSTEM_CD like '%tp'	
 and rownum < 2;

select  'RS00100M' " ",  'SERV_LIMITED_TO' " ",  rpad(SERV_LIMITED_TO,20) " " 
from SFG.RS00100M@UMSP.WORLD where SERV_LIMITED_TO like '%tp'	
 and rownum < 2;

select  'RS00100M' " ",  'SOURCE_CD' " ",  rpad(SOURCE_CD,20) " " 
from SFG.RS00100M@UMSP.WORLD where SOURCE_CD like '%tp'	
 and rownum < 2;

select  'RS00100M' " ",  'REASON_CD' " ",  rpad(REASON_CD,20) " " 
from SFG.RS00100M@UMSP.WORLD where REASON_CD like '%tp'	
 and rownum < 2;

select  'RS00100M' " ",  'REQUEST_STAT' " ",  rpad(REQUEST_STAT,20) " " 
from SFG.RS00100M@UMSP.WORLD where REQUEST_STAT like '%tp'	
 and rownum < 2;

select  'RS00100M' " ",  'RESOLUTION_CD' " ",  rpad(RESOLUTION_CD,20) " " 
from SFG.RS00100M@UMSP.WORLD where RESOLUTION_CD like '%tp'	
 and rownum < 2;

select  'RS00110W' " ",  'SERVICE_TP' " ",  rpad(SERVICE_TP,20) " " 
from SFG.RS00110W@UMSP.WORLD where SERVICE_TP like '%tp'	
 and rownum < 2;

select  'RS00120W' " ",  'ASSET_TP' " ",  rpad(ASSET_TP,20) " " 
from SFG.RS00120W@UMSP.WORLD where ASSET_TP like '%tp'	
 and rownum < 2;

select  'RS00200M' " ",  'REQUEST_TP' " ",  rpad(REQUEST_TP,20) " " 
from SFG.RS00200M@UMSP.WORLD where REQUEST_TP like '%tp'	
 and rownum < 2;

select  'RS00200M' " ",  'ACTION_CD' " ",  rpad(ACTION_CD,20) " " 
from SFG.RS00200M@UMSP.WORLD where ACTION_CD like '%tp'	
 and rownum < 2;

select  'RS00200M' " ",  'ACTION_TP' " ",  rpad(ACTION_TP,20) " " 
from SFG.RS00200M@UMSP.WORLD where ACTION_TP like '%tp'	
 and rownum < 2;

select  'RS00200M' " ",  'SUBSYSTEM_CD' " ",  rpad(SUBSYSTEM_CD,20) " " 
from SFG.RS00200M@UMSP.WORLD where SUBSYSTEM_CD like '%tp'	
 and rownum < 2;

select  'RS00200M' " ",  'SOURCE_CD' " ",  rpad(SOURCE_CD,20) " " 
from SFG.RS00200M@UMSP.WORLD where SOURCE_CD like '%tp'	
 and rownum < 2;

select  'RS00200M' " ",  'GEO_AREA_CD' " ",  rpad(GEO_AREA_CD,20) " " 
from SFG.RS00200M@UMSP.WORLD where GEO_AREA_CD like '%tp'	
 and rownum < 2;

select  'RS00200M' " ",  'SERVICE_TP' " ",  rpad(SERVICE_TP,20) " " 
from SFG.RS00200M@UMSP.WORLD where SERVICE_TP like '%tp'	
 and rownum < 2;

select  'RS00200M' " ",  'RESOLUTION_CD' " ",  rpad(RESOLUTION_CD,20) " " 
from SFG.RS00200M@UMSP.WORLD where RESOLUTION_CD like '%tp'	
 and rownum < 2;

select  'RS00200M' " ",  'ASSET_TP' " ",  rpad(ASSET_TP,20) " " 
from SFG.RS00200M@UMSP.WORLD where ASSET_TP like '%tp'	
 and rownum < 2;

select  'RS00200M' " ",  'ACTION_STAT' " ",  rpad(ACTION_STAT,20) " " 
from SFG.RS00200M@UMSP.WORLD where ACTION_STAT like '%tp'	
 and rownum < 2;

select  'RS00200M' " ",  'DISTRIBUTION_OVRD' " ",  rpad(DISTRIBUTION_OVRD,20) " " 
from SFG.RS00200M@UMSP.WORLD where DISTRIBUTION_OVRD like '%tp'	
 and rownum < 2;

select  'RS00210M' " ",  'CONFIG_CD' " ",  rpad(CONFIG_CD,20) " " 
from SFG.RS00210M@UMSP.WORLD where CONFIG_CD like '%tp'	
 and rownum < 2;

select  'RS00210M' " ",  'ASSET_TP' " ",  rpad(ASSET_TP,20) " " 
from SFG.RS00210M@UMSP.WORLD where ASSET_TP like '%tp'	
 and rownum < 2;

select  'RS00210M' " ",  'ASSET_NEW_STAT' " ",  rpad(ASSET_NEW_STAT,20) " " 
from SFG.RS00210M@UMSP.WORLD where ASSET_NEW_STAT like '%tp'	
 and rownum < 2;

select  'RS00210M' " ",  'ASSET_STAT' " ",  rpad(ASSET_STAT,20) " " 
from SFG.RS00210M@UMSP.WORLD where ASSET_STAT like '%tp'	
 and rownum < 2;

select  'RS00211M' " ",  'ASSET_TP' " ",  rpad(ASSET_TP,20) " " 
from SFG.RS00211M@UMSP.WORLD where ASSET_TP like '%tp'	
 and rownum < 2;

select  'RS00211M' " ",  'INPUT_TP_OVRD' " ",  rpad(INPUT_TP_OVRD,20) " " 
from SFG.RS00211M@UMSP.WORLD where INPUT_TP_OVRD like '%tp'	
 and rownum < 2;

select  'RS00211M' " ",  'READER_EXCEPTION_CD' " ",  rpad(READER_EXCEPTION_CD,20) " " 
from SFG.RS00211M@UMSP.WORLD where READER_EXCEPTION_CD like '%tp'	
 and rownum < 2;

select  'RS00211M' " ",  'PREV_INPUT_TP' " ",  rpad(PREV_INPUT_TP,20) " " 
from SFG.RS00211M@UMSP.WORLD where PREV_INPUT_TP like '%tp'	
 and rownum < 2;

select  'RS00211M' " ",  'PREV_EXCEPTION_CD' " ",  rpad(PREV_EXCEPTION_CD,20) " " 
from SFG.RS00211M@UMSP.WORLD where PREV_EXCEPTION_CD like '%tp'	
 and rownum < 2;

select  'RS00211M' " ",  'DETAIL_TP' " ",  rpad(DETAIL_TP,20) " " 
from SFG.RS00211M@UMSP.WORLD where DETAIL_TP like '%tp'	
 and rownum < 2;

select  'RS00220M' " ",  'SERVICE_TP' " ",  rpad(SERVICE_TP,20) " " 
from SFG.RS00220M@UMSP.WORLD where SERVICE_TP like '%tp'	
 and rownum < 2;

select  'RS00230M' " ",  'ITEM_CD' " ",  rpad(ITEM_CD,20) " " 
from SFG.RS00230M@UMSP.WORLD where ITEM_CD like '%tp'	
 and rownum < 2;

select  'RS00235T' " ",  'AR_AGING_CD_01' " ",  rpad(AR_AGING_CD_01,20) " " 
from SFG.RS00235T@UMSP.WORLD where AR_AGING_CD_01 like '%tp'	
 and rownum < 2;

select  'RS00235T' " ",  'AR_AGING_CD_02' " ",  rpad(AR_AGING_CD_02,20) " " 
from SFG.RS00235T@UMSP.WORLD where AR_AGING_CD_02 like '%tp'	
 and rownum < 2;

select  'RS00235T' " ",  'AR_AGING_CD_03' " ",  rpad(AR_AGING_CD_03,20) " " 
from SFG.RS00235T@UMSP.WORLD where AR_AGING_CD_03 like '%tp'	
 and rownum < 2;

select  'RS00235T' " ",  'AR_AGING_CD_04' " ",  rpad(AR_AGING_CD_04,20) " " 
from SFG.RS00235T@UMSP.WORLD where AR_AGING_CD_04 like '%tp'	
 and rownum < 2;

select  'RS00235T' " ",  'AR_AGING_CD_05' " ",  rpad(AR_AGING_CD_05,20) " " 
from SFG.RS00235T@UMSP.WORLD where AR_AGING_CD_05 like '%tp'	
 and rownum < 2;

select  'RS00235T' " ",  'AR_AGING_CD_06' " ",  rpad(AR_AGING_CD_06,20) " " 
from SFG.RS00235T@UMSP.WORLD where AR_AGING_CD_06 like '%tp'	
 and rownum < 2;

select  'RS00235T' " ",  'AR_AGING_CD_07' " ",  rpad(AR_AGING_CD_07,20) " " 
from SFG.RS00235T@UMSP.WORLD where AR_AGING_CD_07 like '%tp'	
 and rownum < 2;

select  'RS00235T' " ",  'AR_AGING_CD_08' " ",  rpad(AR_AGING_CD_08,20) " " 
from SFG.RS00235T@UMSP.WORLD where AR_AGING_CD_08 like '%tp'	
 and rownum < 2;

select  'RS00235T' " ",  'AR_AGING_CD_09' " ",  rpad(AR_AGING_CD_09,20) " " 
from SFG.RS00235T@UMSP.WORLD where AR_AGING_CD_09 like '%tp'	
 and rownum < 2;

select  'RS00235T' " ",  'AR_AGING_CD_10' " ",  rpad(AR_AGING_CD_10,20) " " 
from SFG.RS00235T@UMSP.WORLD where AR_AGING_CD_10 like '%tp'	
 and rownum < 2;

select  'RS00235T' " ",  'AR_SUMMARY_CD_01' " ",  rpad(AR_SUMMARY_CD_01,20) " " 
from SFG.RS00235T@UMSP.WORLD where AR_SUMMARY_CD_01 like '%tp'	
 and rownum < 2;

select  'RS00235T' " ",  'AR_SUMMARY_CD_02' " ",  rpad(AR_SUMMARY_CD_02,20) " " 
from SFG.RS00235T@UMSP.WORLD where AR_SUMMARY_CD_02 like '%tp'	
 and rownum < 2;

select  'RS00235T' " ",  'AR_SUMMARY_CD_03' " ",  rpad(AR_SUMMARY_CD_03,20) " " 
from SFG.RS00235T@UMSP.WORLD where AR_SUMMARY_CD_03 like '%tp'	
 and rownum < 2;

select  'RS00235T' " ",  'AR_SUMMARY_CD_04' " ",  rpad(AR_SUMMARY_CD_04,20) " " 
from SFG.RS00235T@UMSP.WORLD where AR_SUMMARY_CD_04 like '%tp'	
 and rownum < 2;

select  'RS00235T' " ",  'AR_SUMMARY_CD_05' " ",  rpad(AR_SUMMARY_CD_05,20) " " 
from SFG.RS00235T@UMSP.WORLD where AR_SUMMARY_CD_05 like '%tp'	
 and rownum < 2;

select  'RS00235T' " ",  'AR_SUMMARY_CD_06' " ",  rpad(AR_SUMMARY_CD_06,20) " " 
from SFG.RS00235T@UMSP.WORLD where AR_SUMMARY_CD_06 like '%tp'	
 and rownum < 2;

select  'RS00235T' " ",  'AR_SUMMARY_CD_07' " ",  rpad(AR_SUMMARY_CD_07,20) " " 
from SFG.RS00235T@UMSP.WORLD where AR_SUMMARY_CD_07 like '%tp'	
 and rownum < 2;

select  'RS00235T' " ",  'AR_SUMMARY_CD_08' " ",  rpad(AR_SUMMARY_CD_08,20) " " 
from SFG.RS00235T@UMSP.WORLD where AR_SUMMARY_CD_08 like '%tp'	
 and rownum < 2;

select  'RS00235T' " ",  'AR_SUMMARY_CD_09' " ",  rpad(AR_SUMMARY_CD_09,20) " " 
from SFG.RS00235T@UMSP.WORLD where AR_SUMMARY_CD_09 like '%tp'	
 and rownum < 2;

select  'RS00235T' " ",  'AR_SUMMARY_CD_10' " ",  rpad(AR_SUMMARY_CD_10,20) " " 
from SFG.RS00235T@UMSP.WORLD where AR_SUMMARY_CD_10 like '%tp'	
 and rownum < 2;

select  'RS00235T' " ",  'AR_SUMMARY_CD_11' " ",  rpad(AR_SUMMARY_CD_11,20) " " 
from SFG.RS00235T@UMSP.WORLD where AR_SUMMARY_CD_11 like '%tp'	
 and rownum < 2;

select  'RS00235T' " ",  'AR_SUMMARY_CD_12' " ",  rpad(AR_SUMMARY_CD_12,20) " " 
from SFG.RS00235T@UMSP.WORLD where AR_SUMMARY_CD_12 like '%tp'	
 and rownum < 2;

select  'RS00235T' " ",  'AR_SUMMARY_CD_13' " ",  rpad(AR_SUMMARY_CD_13,20) " " 
from SFG.RS00235T@UMSP.WORLD where AR_SUMMARY_CD_13 like '%tp'	
 and rownum < 2;

select  'RS00235T' " ",  'AR_SUMMARY_CD_14' " ",  rpad(AR_SUMMARY_CD_14,20) " " 
from SFG.RS00235T@UMSP.WORLD where AR_SUMMARY_CD_14 like '%tp'	
 and rownum < 2;

select  'RS00235T' " ",  'AR_SUMMARY_CD_15' " ",  rpad(AR_SUMMARY_CD_15,20) " " 
from SFG.RS00235T@UMSP.WORLD where AR_SUMMARY_CD_15 like '%tp'	
 and rownum < 2;

select  'RS00235T' " ",  'AR_SUMMARY_CD_16' " ",  rpad(AR_SUMMARY_CD_16,20) " " 
from SFG.RS00235T@UMSP.WORLD where AR_SUMMARY_CD_16 like '%tp'	
 and rownum < 2;

select  'RS00235T' " ",  'AR_SUMMARY_CD_17' " ",  rpad(AR_SUMMARY_CD_17,20) " " 
from SFG.RS00235T@UMSP.WORLD where AR_SUMMARY_CD_17 like '%tp'	
 and rownum < 2;

select  'RS00235T' " ",  'AR_SUMMARY_CD_18' " ",  rpad(AR_SUMMARY_CD_18,20) " " 
from SFG.RS00235T@UMSP.WORLD where AR_SUMMARY_CD_18 like '%tp'	
 and rownum < 2;

select  'RS00235T' " ",  'AR_SUMMARY_CD_19' " ",  rpad(AR_SUMMARY_CD_19,20) " " 
from SFG.RS00235T@UMSP.WORLD where AR_SUMMARY_CD_19 like '%tp'	
 and rownum < 2;

select  'RS00235T' " ",  'AR_SUMMARY_CD_20' " ",  rpad(AR_SUMMARY_CD_20,20) " " 
from SFG.RS00235T@UMSP.WORLD where AR_SUMMARY_CD_20 like '%tp'	
 and rownum < 2;

select  'RS00235T' " ",  'CREDIT_RATING_CD' " ",  rpad(CREDIT_RATING_CD,20) " " 
from SFG.RS00235T@UMSP.WORLD where CREDIT_RATING_CD like '%tp'	
 and rownum < 2;

select  'RS00236T' " ",  'ACTION_TYPE' " ",  rpad(ACTION_TYPE,20) " " 
from SFG.RS00236T@UMSP.WORLD where ACTION_TYPE like '%tp'	
 and rownum < 2;

select  'RS00236T' " ",  'RESOLUTION_CD' " ",  rpad(RESOLUTION_CD,20) " " 
from SFG.RS00236T@UMSP.WORLD where RESOLUTION_CD like '%tp'	
 and rownum < 2;

select  'RS00237W' " ",  'BILL_CD' " ",  rpad(BILL_CD,20) " " 
from SFG.RS00237W@UMSP.WORLD where BILL_CD like '%tp'	
 and rownum < 2;

select  'RS00240W' " ",  'SERVICE_TP' " ",  rpad(SERVICE_TP,20) " " 
from SFG.RS00240W@UMSP.WORLD where SERVICE_TP like '%tp'	
 and rownum < 2;

select  'RS00240W' " ",  'CONFIG_CD' " ",  rpad(CONFIG_CD,20) " " 
from SFG.RS00240W@UMSP.WORLD where CONFIG_CD like '%tp'	
 and rownum < 2;

select  'RS00240W' " ",  'ASSET_TP' " ",  rpad(ASSET_TP,20) " " 
from SFG.RS00240W@UMSP.WORLD where ASSET_TP like '%tp'	
 and rownum < 2;

select  'RS00240W' " ",  'ASSET_NEW_STAT' " ",  rpad(ASSET_NEW_STAT,20) " " 
from SFG.RS00240W@UMSP.WORLD where ASSET_NEW_STAT like '%tp'	
 and rownum < 2;

select  'RS00240W' " ",  'WRK_FIELD_2' " ",  rpad(WRK_FIELD_2,20) " " 
from SFG.RS00240W@UMSP.WORLD where WRK_FIELD_2 like '%tp'	
 and rownum < 2;

select  'RS00250W' " ",  'ASSET_TP' " ",  rpad(ASSET_TP,20) " " 
from SFG.RS00250W@UMSP.WORLD where ASSET_TP like '%tp'	
 and rownum < 2;

select  'RS00250W' " ",  'DETAIL_REF_TP' " ",  rpad(DETAIL_REF_TP,20) " " 
from SFG.RS00250W@UMSP.WORLD where DETAIL_REF_TP like '%tp'	
 and rownum < 2;

select  'RS00250W' " ",  'INPUT_TP_OVRD' " ",  rpad(INPUT_TP_OVRD,20) " " 
from SFG.RS00250W@UMSP.WORLD where INPUT_TP_OVRD like '%tp'	
 and rownum < 2;

select  'RS00250W' " ",  'READER_EXCEPTION_CD' " ",  rpad(READER_EXCEPTION_CD,20) " " 
from SFG.RS00250W@UMSP.WORLD where READER_EXCEPTION_CD like '%tp'	
 and rownum < 2;

select  'RS00250W' " ",  'PREV_INPUT_TP' " ",  rpad(PREV_INPUT_TP,20) " " 
from SFG.RS00250W@UMSP.WORLD where PREV_INPUT_TP like '%tp'	
 and rownum < 2;

select  'RS00250W' " ",  'PREV_EXCEPTION_CD' " ",  rpad(PREV_EXCEPTION_CD,20) " " 
from SFG.RS00250W@UMSP.WORLD where PREV_EXCEPTION_CD like '%tp'	
 and rownum < 2;

select  'RS00260W' " ",  'ACTIVITY_CD' " ",  rpad(ACTIVITY_CD,20) " " 
from SFG.RS00260W@UMSP.WORLD where ACTIVITY_CD like '%tp'	
 and rownum < 2;

select  'RS00260W' " ",  'ACTIVITY_PROC_TP' " ",  rpad(ACTIVITY_PROC_TP,20) " " 
from SFG.RS00260W@UMSP.WORLD where ACTIVITY_PROC_TP like '%tp'	
 and rownum < 2;

select  'RS00270C' " ",  'GEO_AREA_CD' " ",  rpad(GEO_AREA_CD,20) " " 
from SFG.RS00270C@UMSP.WORLD where GEO_AREA_CD like '%tp'	
 and rownum < 2;

select  'RS00270C' " ",  'ACTION_CD' " ",  rpad(ACTION_CD,20) " " 
from SFG.RS00270C@UMSP.WORLD where ACTION_CD like '%tp'	
 and rownum < 2;

select  'RS00270W' " ",  'GEO_AREA_CD' " ",  rpad(GEO_AREA_CD,20) " " 
from SFG.RS00270W@UMSP.WORLD where GEO_AREA_CD like '%tp'	
 and rownum < 2;

select  'RS00270W' " ",  'ACTION_CD' " ",  rpad(ACTION_CD,20) " " 
from SFG.RS00270W@UMSP.WORLD where ACTION_CD like '%tp'	
 and rownum < 2;

select  'RS00275M' " ",  'GEO_AREA_CD' " ",  rpad(GEO_AREA_CD,20) " " 
from SFG.RS00275M@UMSP.WORLD where GEO_AREA_CD like '%tp'	
 and rownum < 2;

select  'RS00275M' " ",  'ACTION_CD' " ",  rpad(ACTION_CD,20) " " 
from SFG.RS00275M@UMSP.WORLD where ACTION_CD like '%tp'	
 and rownum < 2;

select  'RS50100C' " ",  'REQUEST_TP' " ",  rpad(REQUEST_TP,20) " " 
from SFG.RS50100C@UMSP.WORLD where REQUEST_TP like '%tp'	
 and rownum < 2;

select  'RS50100C' " ",  'SUBSYSTEM_CD' " ",  rpad(SUBSYSTEM_CD,20) " " 
from SFG.RS50100C@UMSP.WORLD where SUBSYSTEM_CD like '%tp'	
 and rownum < 2;

select  'RS50100C' " ",  'REQUEST_OWNER' " ",  rpad(REQUEST_OWNER,20) " " 
from SFG.RS50100C@UMSP.WORLD where REQUEST_OWNER like '%tp'	
 and rownum < 2;

select  'RS50100C' " ",  'ALL_ACTCLOSED_CD' " ",  rpad(ALL_ACTCLOSED_CD,20) " " 
from SFG.RS50100C@UMSP.WORLD where ALL_ACTCLOSED_CD like '%tp'	
 and rownum < 2;

select  'RS50110C' " ",  'REQUEST_TP' " ",  rpad(REQUEST_TP,20) " " 
from SFG.RS50110C@UMSP.WORLD where REQUEST_TP like '%tp'	
 and rownum < 2;

select  'RS50110C' " ",  'ACTION_CD' " ",  rpad(ACTION_CD,20) " " 
from SFG.RS50110C@UMSP.WORLD where ACTION_CD like '%tp'	
 and rownum < 2;

select  'RS50120C' " ",  'REQUEST_TP' " ",  rpad(REQUEST_TP,20) " " 
from SFG.RS50120C@UMSP.WORLD where REQUEST_TP like '%tp'	
 and rownum < 2;

select  'RS50120C' " ",  'RESOLUTION_CD' " ",  rpad(RESOLUTION_CD,20) " " 
from SFG.RS50120C@UMSP.WORLD where RESOLUTION_CD like '%tp'	
 and rownum < 2;

select  'RS50121C' " ",  'REQUEST_TP' " ",  rpad(REQUEST_TP,20) " " 
from SFG.RS50121C@UMSP.WORLD where REQUEST_TP like '%tp'	
 and rownum < 2;

select  'RS50121C' " ",  'RESOLUTION_CD' " ",  rpad(RESOLUTION_CD,20) " " 
from SFG.RS50121C@UMSP.WORLD where RESOLUTION_CD like '%tp'	
 and rownum < 2;

select  'RS50121C' " ",  'ACTIVITY_CD' " ",  rpad(ACTIVITY_CD,20) " " 
from SFG.RS50121C@UMSP.WORLD where ACTIVITY_CD like '%tp'	
 and rownum < 2;

select  'RS50130C' " ",  'REQUEST_TP' " ",  rpad(REQUEST_TP,20) " " 
from SFG.RS50130C@UMSP.WORLD where REQUEST_TP like '%tp'	
 and rownum < 2;

select  'RS50130C' " ",  'REASON_CD' " ",  rpad(REASON_CD,20) " " 
from SFG.RS50130C@UMSP.WORLD where REASON_CD like '%tp'	
 and rownum < 2;

select  'RS50130C' " ",  'UN_END_USER' " ",  rpad(UN_END_USER,20) " " 
from SFG.RS50130C@UMSP.WORLD where UN_END_USER like '%tp'	
 and rownum < 2;

select  'RS50200C' " ",  'ACTION_CD' " ",  rpad(ACTION_CD,20) " " 
from SFG.RS50200C@UMSP.WORLD where ACTION_CD like '%tp'	
 and rownum < 2;

select  'RS50200C' " ",  'ACTION_TP' " ",  rpad(ACTION_TP,20) " " 
from SFG.RS50200C@UMSP.WORLD where ACTION_TP like '%tp'	
 and rownum < 2;

select  'RS50200C' " ",  'SUBSYSTEM_CD' " ",  rpad(SUBSYSTEM_CD,20) " " 
from SFG.RS50200C@UMSP.WORLD where SUBSYSTEM_CD like '%tp'	
 and rownum < 2;

select  'RS50200C' " ",  'TEMPLATE_TP' " ",  rpad(TEMPLATE_TP,20) " " 
from SFG.RS50200C@UMSP.WORLD where TEMPLATE_TP like '%tp'	
 and rownum < 2;

select  'RS50200C' " ",  'DISTRIBUTION_DFLT' " ",  rpad(DISTRIBUTION_DFLT,20) " " 
from SFG.RS50200C@UMSP.WORLD where DISTRIBUTION_DFLT like '%tp'	
 and rownum < 2;

select  'RS50200C' " ",  'AUTO_CLOSE_CD' " ",  rpad(AUTO_CLOSE_CD,20) " " 
from SFG.RS50200C@UMSP.WORLD where AUTO_CLOSE_CD like '%tp'	
 and rownum < 2;

select  'RS50200C' " ",  'ASSET_TP' " ",  rpad(ASSET_TP,20) " " 
from SFG.RS50200C@UMSP.WORLD where ASSET_TP like '%tp'	
 and rownum < 2;

select  'RS50200C' " ",  'CANCEL_REQUEST_TP' " ",  rpad(CANCEL_REQUEST_TP,20) " " 
from SFG.RS50200C@UMSP.WORLD where CANCEL_REQUEST_TP like '%tp'	
 and rownum < 2;

select  'RS50200C' " ",  'INPUT_TP' " ",  rpad(INPUT_TP,20) " " 
from SFG.RS50200C@UMSP.WORLD where INPUT_TP like '%tp'	
 and rownum < 2;

select  'RS50200C' " ",  'CANCEL_RES_CD' " ",  rpad(CANCEL_RES_CD,20) " " 
from SFG.RS50200C@UMSP.WORLD where CANCEL_RES_CD like '%tp'	
 and rownum < 2;

select  'RS50200C' " ",  'STOP_ASSET_STAT' " ",  rpad(STOP_ASSET_STAT,20) " " 
from SFG.RS50200C@UMSP.WORLD where STOP_ASSET_STAT like '%tp'	
 and rownum < 2;

select  'RS50200C' " ",  'ACCOUNT_CLASS' " ",  rpad(ACCOUNT_CLASS,20) " " 
from SFG.RS50200C@UMSP.WORLD where ACCOUNT_CLASS like '%tp'	
 and rownum < 2;

select  'RS50200C' " ",  'DISTRICT_CD' " ",  rpad(DISTRICT_CD,20) " " 
from SFG.RS50200C@UMSP.WORLD where DISTRICT_CD like '%tp'	
 and rownum < 2;

select  'RS50200C' " ",  'HISTORY' " ",  rpad(HISTORY,20) " " 
from SFG.RS50200C@UMSP.WORLD where HISTORY like '%tp'	
 and rownum < 2;

select  'RS50200C' " ",  'WP_CANCEL_RES_CD' " ",  rpad(WP_CANCEL_RES_CD,20) " " 
from SFG.RS50200C@UMSP.WORLD where WP_CANCEL_RES_CD like '%tp'	
 and rownum < 2;

select  'RS50200C' " ",  'WP_COMPLETE_RES_CD' " ",  rpad(WP_COMPLETE_RES_CD,20) " " 
from SFG.RS50200C@UMSP.WORLD where WP_COMPLETE_RES_CD like '%tp'	
 and rownum < 2;

select  'RS50200C' " ",  'WO_BILL_TP' " ",  rpad(WO_BILL_TP,20) " " 
from SFG.RS50200C@UMSP.WORLD where WO_BILL_TP like '%tp'	
 and rownum < 2;

select  'RS50200C' " ",  'SERVICE_STOP_STAT' " ",  rpad(SERVICE_STOP_STAT,20) " " 
from SFG.RS50200C@UMSP.WORLD where SERVICE_STOP_STAT like '%tp'	
 and rownum < 2;

select  'RS50210C' " ",  'ACTION_CD' " ",  rpad(ACTION_CD,20) " " 
from SFG.RS50210C@UMSP.WORLD where ACTION_CD like '%tp'	
 and rownum < 2;

select  'RS50210C' " ",  'RESOLUTION_CD' " ",  rpad(RESOLUTION_CD,20) " " 
from SFG.RS50210C@UMSP.WORLD where RESOLUTION_CD like '%tp'	
 and rownum < 2;

select  'RS50211C' " ",  'ACTION_CD' " ",  rpad(ACTION_CD,20) " " 
from SFG.RS50211C@UMSP.WORLD where ACTION_CD like '%tp'	
 and rownum < 2;

select  'RS50211C' " ",  'RESOLUTION_CD' " ",  rpad(RESOLUTION_CD,20) " " 
from SFG.RS50211C@UMSP.WORLD where RESOLUTION_CD like '%tp'	
 and rownum < 2;

select  'RS50211C' " ",  'ACTIVITY_CD' " ",  rpad(ACTIVITY_CD,20) " " 
from SFG.RS50211C@UMSP.WORLD where ACTIVITY_CD like '%tp'	
 and rownum < 2;

select  'RS50220C' " ",  'ACTION_CD' " ",  rpad(ACTION_CD,20) " " 
from SFG.RS50220C@UMSP.WORLD where ACTION_CD like '%tp'	
 and rownum < 2;

select  'RS50220C' " ",  'SERVICE_TP' " ",  rpad(SERVICE_TP,20) " " 
from SFG.RS50220C@UMSP.WORLD where SERVICE_TP like '%tp'	
 and rownum < 2;

select  'RS50220C' " ",  'DISTRIBUTION_OVRD' " ",  rpad(DISTRIBUTION_OVRD,20) " " 
from SFG.RS50220C@UMSP.WORLD where DISTRIBUTION_OVRD like '%tp'	
 and rownum < 2;

select  'RS50230C' " ",  'ACTION_CD' " ",  rpad(ACTION_CD,20) " " 
from SFG.RS50230C@UMSP.WORLD where ACTION_CD like '%tp'	
 and rownum < 2;

select  'RS50230C' " ",  'SUBSYSTEM_ITEM_CD' " ",  rpad(SUBSYSTEM_ITEM_CD,20) " " 
from SFG.RS50230C@UMSP.WORLD where SUBSYSTEM_ITEM_CD like '%tp'	
 and rownum < 2;

select  'RS50240C' " ",  'ACTION_CD' " ",  rpad(ACTION_CD,20) " " 
from SFG.RS50240C@UMSP.WORLD where ACTION_CD like '%tp'	
 and rownum < 2;

select  'RS50240C' " ",  'ACTION_STOPPER_CD' " ",  rpad(ACTION_STOPPER_CD,20) " " 
from SFG.RS50240C@UMSP.WORLD where ACTION_STOPPER_CD like '%tp'	
 and rownum < 2;

select  'RS50240C' " ",  'STOP_LEVEL' " ",  rpad(STOP_LEVEL,20) " " 
from SFG.RS50240C@UMSP.WORLD where STOP_LEVEL like '%tp'	
 and rownum < 2;

select  'RS50250C' " ",  'ACTION_CD' " ",  rpad(ACTION_CD,20) " " 
from SFG.RS50250C@UMSP.WORLD where ACTION_CD like '%tp'	
 and rownum < 2;

select  'RS50250C' " ",  'LOCATION_CLASS' " ",  rpad(LOCATION_CLASS,20) " " 
from SFG.RS50250C@UMSP.WORLD where LOCATION_CLASS like '%tp'	
 and rownum < 2;

select  'RS50250C' " ",  'UN_END_USER' " ",  rpad(UN_END_USER,20) " " 
from SFG.RS50250C@UMSP.WORLD where UN_END_USER like '%tp'	
 and rownum < 2;

select  'RS50260C' " ",  'ACTION_CD' " ",  rpad(ACTION_CD,20) " " 
from SFG.RS50260C@UMSP.WORLD where ACTION_CD like '%tp'	
 and rownum < 2;

select  'RS50260C' " ",  'SUBSYSTEM_ITEM_CD' " ",  rpad(SUBSYSTEM_ITEM_CD,20) " " 
from SFG.RS50260C@UMSP.WORLD where SUBSYSTEM_ITEM_CD like '%tp'	
 and rownum < 2;

select  'RS50290C' " ",  'ACTION_CD' " ",  rpad(ACTION_CD,20) " " 
from SFG.RS50290C@UMSP.WORLD where ACTION_CD like '%tp'	
 and rownum < 2;

select  'RS50290C' " ",  'ATTRIBUTE_CD' " ",  rpad(ATTRIBUTE_CD,20) " " 
from SFG.RS50290C@UMSP.WORLD where ATTRIBUTE_CD like '%tp'	
 and rownum < 2;

select  'RS50300C' " ",  'SUBSYSTEM_CD' " ",  rpad(SUBSYSTEM_CD,20) " " 
from SFG.RS50300C@UMSP.WORLD where SUBSYSTEM_CD like '%tp'	
 and rownum < 2;

select  'RS50300C' " ",  'MODULE_CD' " ",  rpad(MODULE_CD,20) " " 
from SFG.RS50300C@UMSP.WORLD where MODULE_CD like '%tp'	
 and rownum < 2;

select  'RS50300C' " ",  'REQUEST_TP' " ",  rpad(REQUEST_TP,20) " " 
from SFG.RS50300C@UMSP.WORLD where REQUEST_TP like '%tp'	
 and rownum < 2;

select  'RS50400C' " ",  'ITEM_CD' " ",  rpad(ITEM_CD,20) " " 
from SFG.RS50400C@UMSP.WORLD where ITEM_CD like '%tp'	
 and rownum < 2;

select  'RS50400C' " ",  'SUBSYSTEM_CD' " ",  rpad(SUBSYSTEM_CD,20) " " 
from SFG.RS50400C@UMSP.WORLD where SUBSYSTEM_CD like '%tp'	
 and rownum < 2;

select  'RS50500C' " ",  'RESOLUTION_CD' " ",  rpad(RESOLUTION_CD,20) " " 
from SFG.RS50500C@UMSP.WORLD where RESOLUTION_CD like '%tp'	
 and rownum < 2;

select  'RS50510C' " ",  'RESOLUTION_CD' " ",  rpad(RESOLUTION_CD,20) " " 
from SFG.RS50510C@UMSP.WORLD where RESOLUTION_CD like '%tp'	
 and rownum < 2;

select  'RS50510C' " ",  'ACTIVITY_CD' " ",  rpad(ACTIVITY_CD,20) " " 
from SFG.RS50510C@UMSP.WORLD where ACTIVITY_CD like '%tp'	
 and rownum < 2;

select  'RS50600C' " ",  'ACTION_TP' " ",  rpad(ACTION_TP,20) " " 
from SFG.RS50600C@UMSP.WORLD where ACTION_TP like '%tp'	
 and rownum < 2;

select  'RS50610C' " ",  'ACTION_TP' " ",  rpad(ACTION_TP,20) " " 
from SFG.RS50610C@UMSP.WORLD where ACTION_TP like '%tp'	
 and rownum < 2;

select  'RS50610C' " ",  'SUBSYSTEM_CD' " ",  rpad(SUBSYSTEM_CD,20) " " 
from SFG.RS50610C@UMSP.WORLD where SUBSYSTEM_CD like '%tp'	
 and rownum < 2;

select  'RS50700C' " ",  'ACTIVITY_CD' " ",  rpad(ACTIVITY_CD,20) " " 
from SFG.RS50700C@UMSP.WORLD where ACTIVITY_CD like '%tp'	
 and rownum < 2;

select  'RS50700C' " ",  'ACTIVITY_PROC_TP' " ",  rpad(ACTIVITY_PROC_TP,20) " " 
from SFG.RS50700C@UMSP.WORLD where ACTIVITY_PROC_TP like '%tp'	
 and rownum < 2;

select  'RS50800C' " ",  'ASSET_TP' " ",  rpad(ASSET_TP,20) " " 
from SFG.RS50800C@UMSP.WORLD where ASSET_TP like '%tp'	
 and rownum < 2;

select  'RS50800C' " ",  'AMS_ASSET_AREA' " ",  rpad(AMS_ASSET_AREA,20) " " 
from SFG.RS50800C@UMSP.WORLD where AMS_ASSET_AREA like '%tp'	
 and rownum < 2;

select  'RS50800C' " ",  'AMS_ASSET_TP' " ",  rpad(AMS_ASSET_TP,20) " " 
from SFG.RS50800C@UMSP.WORLD where AMS_ASSET_TP like '%tp'	
 and rownum < 2;

select  'RS50800C' " ",  'EXT_AMS_ASSET_AREA' " ",  rpad(EXT_AMS_ASSET_AREA,20) " " 
from SFG.RS50800C@UMSP.WORLD where EXT_AMS_ASSET_AREA like '%tp'	
 and rownum < 2;

select  'RS50800C' " ",  'EXT_AMS_ASSET_TP' " ",  rpad(EXT_AMS_ASSET_TP,20) " " 
from SFG.RS50800C@UMSP.WORLD where EXT_AMS_ASSET_TP like '%tp'	
 and rownum < 2;

select  'RS50800C' " ",  'SET_DFLT_STAT' " ",  rpad(SET_DFLT_STAT,20) " " 
from SFG.RS50800C@UMSP.WORLD where SET_DFLT_STAT like '%tp'	
 and rownum < 2;

select  'RS50800C' " ",  'SERVICE_PURPOSE' " ",  rpad(SERVICE_PURPOSE,20) " " 
from SFG.RS50800C@UMSP.WORLD where SERVICE_PURPOSE like '%tp'	
 and rownum < 2;

select  'RS50900C' " ",  'SERVICE_TP' " ",  rpad(SERVICE_TP,20) " " 
from SFG.RS50900C@UMSP.WORLD where SERVICE_TP like '%tp'	
 and rownum < 2;

select  'RS50900C' " ",  'GEO_AREA_CD' " ",  rpad(GEO_AREA_CD,20) " " 
from SFG.RS50900C@UMSP.WORLD where GEO_AREA_CD like '%tp'	
 and rownum < 2;

select  'RS50900C' " ",  'ACTION_CD' " ",  rpad(ACTION_CD,20) " " 
from SFG.RS50900C@UMSP.WORLD where ACTION_CD like '%tp'	
 and rownum < 2;

select  'RS50900C' " ",  'DISTRIBUTION_CD' " ",  rpad(DISTRIBUTION_CD,20) " " 
from SFG.RS50900C@UMSP.WORLD where DISTRIBUTION_CD like '%tp'	
 and rownum < 2;

select  'RS51000C' " ",  'ACTION_CD' " ",  rpad(ACTION_CD,20) " " 
from SFG.RS51000C@UMSP.WORLD where ACTION_CD like '%tp'	
 and rownum < 2;

select  'RS51000C' " ",  'JOBBING_CATEGORY' " ",  rpad(JOBBING_CATEGORY,20) " " 
from SFG.RS51000C@UMSP.WORLD where JOBBING_CATEGORY like '%tp'	
 and rownum < 2;

select  'RS51000C' " ",  'WO_BILL_TP' " ",  rpad(WO_BILL_TP,20) " " 
from SFG.RS51000C@UMSP.WORLD where WO_BILL_TP like '%tp'	
 and rownum < 2;

select  'SG00100M' " ",  'PERSON_STAT' " ",  rpad(PERSON_STAT,20) " " 
from SFG.SG00100M@UMSP.WORLD where PERSON_STAT like '%tp'	
 and rownum < 2;

select  'SG00100M' " ",  'TITLE_CD' " ",  rpad(TITLE_CD,20) " " 
from SFG.SG00100M@UMSP.WORLD where TITLE_CD like '%tp'	
 and rownum < 2;

select  'SG00100M' " ",  'I_DRIVERS_LIC_PROV' " ",  rpad(I_DRIVERS_LIC_PROV,20) " " 
from SFG.SG00100M@UMSP.WORLD where I_DRIVERS_LIC_PROV like '%tp'	
 and rownum < 2;

select  'SG00100M' " ",  'I_GENDER' " ",  rpad(I_GENDER,20) " " 
from SFG.SG00100M@UMSP.WORLD where I_GENDER like '%tp'	
 and rownum < 2;

select  'SG00100M' " ",  'O_BUSINESS_TP' " ",  rpad(O_BUSINESS_TP,20) " " 
from SFG.SG00100M@UMSP.WORLD where O_BUSINESS_TP like '%tp'	
 and rownum < 2;

select  'SG00100M' " ",  'SELECT_CD' " ",  rpad(SELECT_CD,20) " " 
from SFG.SG00100M@UMSP.WORLD where SELECT_CD like '%tp'	
 and rownum < 2;

select  'SG00120T' " ",  'PERSON_STAT' " ",  rpad(PERSON_STAT,20) " " 
from SFG.SG00120T@UMSP.WORLD where PERSON_STAT like '%tp'	
 and rownum < 2;

select  'SG00120T' " ",  'TITLE_CD' " ",  rpad(TITLE_CD,20) " " 
from SFG.SG00120T@UMSP.WORLD where TITLE_CD like '%tp'	
 and rownum < 2;

select  'SG00120T' " ",  'I_DRIVERS_LIC_PROV' " ",  rpad(I_DRIVERS_LIC_PROV,20) " " 
from SFG.SG00120T@UMSP.WORLD where I_DRIVERS_LIC_PROV like '%tp'	
 and rownum < 2;

select  'SG00120T' " ",  'I_GENDER' " ",  rpad(I_GENDER,20) " " 
from SFG.SG00120T@UMSP.WORLD where I_GENDER like '%tp'	
 and rownum < 2;

select  'SG00120T' " ",  'O_BUSINESS_TP' " ",  rpad(O_BUSINESS_TP,20) " " 
from SFG.SG00120T@UMSP.WORLD where O_BUSINESS_TP like '%tp'	
 and rownum < 2;

select  'SG00120T' " ",  'SELECT_CD' " ",  rpad(SELECT_CD,20) " " 
from SFG.SG00120T@UMSP.WORLD where SELECT_CD like '%tp'	
 and rownum < 2;

select  'SG00140T' " ",  'PHONE_CD' " ",  rpad(PHONE_CD,20) " " 
from SFG.SG00140T@UMSP.WORLD where PHONE_CD like '%tp'	
 and rownum < 2;

select  'SG00150T' " ",  'DEPT_CD' " ",  rpad(DEPT_CD,20) " " 
from SFG.SG00150T@UMSP.WORLD where DEPT_CD like '%tp'	
 and rownum < 2;

select  'SG00160T' " ",  'REL_TP' " ",  rpad(REL_TP,20) " " 
from SFG.SG00160T@UMSP.WORLD where REL_TP like '%tp'	
 and rownum < 2;

select  'SG00300T' " ",  'OWNERSHIP_CD' " ",  rpad(OWNERSHIP_CD,20) " " 
from SFG.SG00300T@UMSP.WORLD where OWNERSHIP_CD like '%tp'	
 and rownum < 2;

select  'SG00300T' " ",  'ADDRESSEE_CD' " ",  rpad(ADDRESSEE_CD,20) " " 
from SFG.SG00300T@UMSP.WORLD where ADDRESSEE_CD like '%tp'	
 and rownum < 2;

select  'SG00400T' " ",  'OWNERSHIP_CD' " ",  rpad(OWNERSHIP_CD,20) " " 
from SFG.SG00400T@UMSP.WORLD where OWNERSHIP_CD like '%tp'	
 and rownum < 2;

select  'SG00400T' " ",  'ALERT_CD' " ",  rpad(ALERT_CD,20) " " 
from SFG.SG00400T@UMSP.WORLD where ALERT_CD like '%tp'	
 and rownum < 2;

select  'SG00400T' " ",  'ADDRESSEE_CD_OVRD' " ",  rpad(ADDRESSEE_CD_OVRD,20) " " 
from SFG.SG00400T@UMSP.WORLD where ADDRESSEE_CD_OVRD like '%tp'	
 and rownum < 2;

select  'SG00500T' " ",  'OBJECT_CD' " ",  rpad(OBJECT_CD,20) " " 
from SFG.SG00500T@UMSP.WORLD where OBJECT_CD like '%tp'	
 and rownum < 2;

select  'SG00500T' " ",  'FUNCTION_CD' " ",  rpad(FUNCTION_CD,20) " " 
from SFG.SG00500T@UMSP.WORLD where FUNCTION_CD like '%tp'	
 and rownum < 2;

select  'SG00500T' " ",  'MSG_TYP' " ",  rpad(MSG_TYP,20) " " 
from SFG.SG00500T@UMSP.WORLD where MSG_TYP like '%tp'	
 and rownum < 2;

select  'SG00600M' " ",  'OBJECT_CD' " ",  rpad(OBJECT_CD,20) " " 
from SFG.SG00600M@UMSP.WORLD where OBJECT_CD like '%tp'	
 and rownum < 2;

select  'SG00600M' " ",  'PREF_CD' " ",  rpad(PREF_CD,20) " " 
from SFG.SG00600M@UMSP.WORLD where PREF_CD like '%tp'	
 and rownum < 2;

select  'SG00600M' " ",  'PREF_DATA_TP' " ",  rpad(PREF_DATA_TP,20) " " 
from SFG.SG00600M@UMSP.WORLD where PREF_DATA_TP like '%tp'	
 and rownum < 2;

select  'SG00700M' " ",  'STREET_PFX_DIR' " ",  rpad(STREET_PFX_DIR,20) " " 
from SFG.SG00700M@UMSP.WORLD where STREET_PFX_DIR like '%tp'	
 and rownum < 2;

select  'SG00700M' " ",  'STREET_SFX_DIR' " ",  rpad(STREET_SFX_DIR,20) " " 
from SFG.SG00700M@UMSP.WORLD where STREET_SFX_DIR like '%tp'	
 and rownum < 2;

select  'SG00700M' " ",  'SEC_ADDR_ID' " ",  rpad(SEC_ADDR_ID,20) " " 
from SFG.SG00700M@UMSP.WORLD where SEC_ADDR_ID like '%tp'	
 and rownum < 2;

select  'SG00700M' " ",  'PROVINCE_CD' " ",  rpad(PROVINCE_CD,20) " " 
from SFG.SG00700M@UMSP.WORLD where PROVINCE_CD like '%tp'	
 and rownum < 2;

select  'SG00700M' " ",  'ROUTE_PFX' " ",  rpad(ROUTE_PFX,20) " " 
from SFG.SG00700M@UMSP.WORLD where ROUTE_PFX like '%tp'	
 and rownum < 2;

select  'SG00710M' " ",  'STREET_PFX_DIR' " ",  rpad(STREET_PFX_DIR,20) " " 
from SFG.SG00710M@UMSP.WORLD where STREET_PFX_DIR like '%tp'	
 and rownum < 2;

select  'SG00710M' " ",  'STREET_SFX_DIR' " ",  rpad(STREET_SFX_DIR,20) " " 
from SFG.SG00710M@UMSP.WORLD where STREET_SFX_DIR like '%tp'	
 and rownum < 2;

select  'SG00710M' " ",  'SEC_ADDR_ID' " ",  rpad(SEC_ADDR_ID,20) " " 
from SFG.SG00710M@UMSP.WORLD where SEC_ADDR_ID like '%tp'	
 and rownum < 2;

select  'SG00710M' " ",  'PROVINCE_CD' " ",  rpad(PROVINCE_CD,20) " " 
from SFG.SG00710M@UMSP.WORLD where PROVINCE_CD like '%tp'	
 and rownum < 2;

select  'SG00710M' " ",  'ROUTE_PFX' " ",  rpad(ROUTE_PFX,20) " " 
from SFG.SG00710M@UMSP.WORLD where ROUTE_PFX like '%tp'	
 and rownum < 2;

select  'SG50000C' " ",  'OBJECT_CD' " ",  rpad(OBJECT_CD,20) " " 
from SFG.SG50000C@UMSP.WORLD where OBJECT_CD like '%tp'	
 and rownum < 2;

select  'SG50000C' " ",  'CONTROL_CD' " ",  rpad(CONTROL_CD,20) " " 
from SFG.SG50000C@UMSP.WORLD where CONTROL_CD like '%tp'	
 and rownum < 2;

select  'SG50010C' " ",  'OBJECT_CD' " ",  rpad(OBJECT_CD,20) " " 
from SFG.SG50010C@UMSP.WORLD where OBJECT_CD like '%tp'	
 and rownum < 2;

select  'SG50010C' " ",  'CONTROL_CD' " ",  rpad(CONTROL_CD,20) " " 
from SFG.SG50010C@UMSP.WORLD where CONTROL_CD like '%tp'	
 and rownum < 2;

select  'SG50010C' " ",  'SUBCNTL_CD_SFG' " ",  rpad(SUBCNTL_CD_SFG,20) " " 
from SFG.SG50010C@UMSP.WORLD where SUBCNTL_CD_SFG like '%tp'	
 and rownum < 2;

select  'SG50010C' " ",  'SUBCNTL_CD_CUSTOM' " ",  rpad(SUBCNTL_CD_CUSTOM,20) " " 
from SFG.SG50010C@UMSP.WORLD where SUBCNTL_CD_CUSTOM like '%tp'	
 and rownum < 2;

select  'SG50010C' " ",  'SUBCNTL_CD_GRP' " ",  rpad(SUBCNTL_CD_GRP,20) " " 
from SFG.SG50010C@UMSP.WORLD where SUBCNTL_CD_GRP like '%tp'	
 and rownum < 2;

select  'SG50100C' " ",  'PROVINCE_CD' " ",  rpad(PROVINCE_CD,20) " " 
from SFG.SG50100C@UMSP.WORLD where PROVINCE_CD like '%tp'	
 and rownum < 2;

select  'SG50100C' " ",  'COUNTRY_CD' " ",  rpad(COUNTRY_CD,20) " " 
from SFG.SG50100C@UMSP.WORLD where COUNTRY_CD like '%tp'	
 and rownum < 2;

select  'SG50300C' " ",  'OWNERSHIP_CD' " ",  rpad(OWNERSHIP_CD,20) " " 
from SFG.SG50300C@UMSP.WORLD where OWNERSHIP_CD like '%tp'	
 and rownum < 2;

select  'SG50300C' " ",  'ALERT_CD_SFG' " ",  rpad(ALERT_CD_SFG,20) " " 
from SFG.SG50300C@UMSP.WORLD where ALERT_CD_SFG like '%tp'	
 and rownum < 2;

select  'SG50300C' " ",  'ALERT_CD_CUSTOM' " ",  rpad(ALERT_CD_CUSTOM,20) " " 
from SFG.SG50300C@UMSP.WORLD where ALERT_CD_CUSTOM like '%tp'	
 and rownum < 2;

select  'SG50300C' " ",  'ADDRESSEE_CD' " ",  rpad(ADDRESSEE_CD,20) " " 
from SFG.SG50300C@UMSP.WORLD where ADDRESSEE_CD like '%tp'	
 and rownum < 2;

select  'SG50400C' " ",  'STATUT_CD' " ",  rpad(STATUT_CD,20) " " 
from SFG.SG50400C@UMSP.WORLD where STATUT_CD like '%tp'	
 and rownum < 2;

select  'SG60100C' " ",  'OBJECT_CD' " ",  rpad(OBJECT_CD,20) " " 
from SFG.SG60100C@UMSP.WORLD where OBJECT_CD like '%tp'	
 and rownum < 2;

select  'SG60100C' " ",  'FUNCTION_CD' " ",  rpad(FUNCTION_CD,20) " " 
from SFG.SG60100C@UMSP.WORLD where FUNCTION_CD like '%tp'	
 and rownum < 2;

select  'SG60200C' " ",  'OBJECT_CD' " ",  rpad(OBJECT_CD,20) " " 
from SFG.SG60200C@UMSP.WORLD where OBJECT_CD like '%tp'	
 and rownum < 2;

select  'SG60200C' " ",  'FUNCTION_CD' " ",  rpad(FUNCTION_CD,20) " " 
from SFG.SG60200C@UMSP.WORLD where FUNCTION_CD like '%tp'	
 and rownum < 2;

select  'SG60200C' " ",  'UN_END_USER' " ",  rpad(UN_END_USER,20) " " 
from SFG.SG60200C@UMSP.WORLD where UN_END_USER like '%tp'	
 and rownum < 2;

select  'SY07600M' " ",  'IQ_TIMEOUT' " ",  rpad(IQ_TIMEOUT,20) " " 
from SFG.SY07600M@UMSP.WORLD where IQ_TIMEOUT like '%tp'	
 and rownum < 2;

select  'SY07700M' " ",  'REPORT_TYPE' " ",  rpad(REPORT_TYPE,20) " " 
from SFG.SY07700M@UMSP.WORLD where REPORT_TYPE like '%tp'	
 and rownum < 2;

select  'SY07843M' " ",  'UN_END_USER' " ",  rpad(UN_END_USER,20) " " 
from SFG.SY07843M@UMSP.WORLD where UN_END_USER like '%tp'	
 and rownum < 2;

select  'SY07844M' " ",  'RECORDSTATUS' " ",  rpad(RECORDSTATUS,20) " " 
from SFG.SY07844M@UMSP.WORLD where RECORDSTATUS like '%tp'	
 and rownum < 2;

select  'TEMP_UM_ONMD' " ",  'BILL_CD' " ",  rpad(BILL_CD,20) " " 
from SFG.TEMP_UM_ONMD@UMSP.WORLD where BILL_CD like '%tp'	
 and rownum < 2;

select  'TEMP_UM_ONMD' " ",  'LOCATION_CLASS' " ",  rpad(LOCATION_CLASS,20) " " 
from SFG.TEMP_UM_ONMD@UMSP.WORLD where LOCATION_CLASS like '%tp'	
 and rownum < 2;

select  'TMP_AR50200C' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.TMP_AR50200C@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'TMP_AR50200C' " ",  'MATCHING_RULE_TP' " ",  rpad(MATCHING_RULE_TP,20) " " 
from SFG.TMP_AR50200C@UMSP.WORLD where MATCHING_RULE_TP like '%tp'	
 and rownum < 2;

select  'TMP_AR50200C' " ",  'AGING_CD' " ",  rpad(AGING_CD,20) " " 
from SFG.TMP_AR50200C@UMSP.WORLD where AGING_CD like '%tp'	
 and rownum < 2;

select  'TMP_CO00100T' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.TMP_CO00100T@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'TMP_CO00100T' " ",  'STREAM_CD' " ",  rpad(STREAM_CD,20) " " 
from SFG.TMP_CO00100T@UMSP.WORLD where STREAM_CD like '%tp'	
 and rownum < 2;

select  'TMP_CO00100T' " ",  'ACTION_CD' " ",  rpad(ACTION_CD,20) " " 
from SFG.TMP_CO00100T@UMSP.WORLD where ACTION_CD like '%tp'	
 and rownum < 2;

select  'TMP_CO00100T' " ",  'CREDIT_EVENT_CD' " ",  rpad(CREDIT_EVENT_CD,20) " " 
from SFG.TMP_CO00100T@UMSP.WORLD where CREDIT_EVENT_CD like '%tp'	
 and rownum < 2;

select  'TMP_CO00400T' " ",  'SUBSYSTEM_ID' " ",  rpad(SUBSYSTEM_ID,20) " " 
from SFG.TMP_CO00400T@UMSP.WORLD where SUBSYSTEM_ID like '%tp'	
 and rownum < 2;

select  'TMP_CO00400T' " ",  'STATUS_CD' " ",  rpad(STATUS_CD,20) " " 
from SFG.TMP_CO00400T@UMSP.WORLD where STATUS_CD like '%tp'	
 and rownum < 2;

select  'TMP_RS00200M' " ",  'REQUEST_TP' " ",  rpad(REQUEST_TP,20) " " 
from SFG.TMP_RS00200M@UMSP.WORLD where REQUEST_TP like '%tp'	
 and rownum < 2;

select  'TMP_RS00200M' " ",  'ACTION_CD' " ",  rpad(ACTION_CD,20) " " 
from SFG.TMP_RS00200M@UMSP.WORLD where ACTION_CD like '%tp'	
 and rownum < 2;

select  'TMP_RS00200M' " ",  'ACTION_TP' " ",  rpad(ACTION_TP,20) " " 
from SFG.TMP_RS00200M@UMSP.WORLD where ACTION_TP like '%tp'	
 and rownum < 2;

select  'TMP_RS00200M' " ",  'SUBSYSTEM_CD' " ",  rpad(SUBSYSTEM_CD,20) " " 
from SFG.TMP_RS00200M@UMSP.WORLD where SUBSYSTEM_CD like '%tp'	
 and rownum < 2;

select  'TMP_RS00200M' " ",  'SOURCE_CD' " ",  rpad(SOURCE_CD,20) " " 
from SFG.TMP_RS00200M@UMSP.WORLD where SOURCE_CD like '%tp'	
 and rownum < 2;

select  'TMP_RS00200M' " ",  'GEO_AREA_CD' " ",  rpad(GEO_AREA_CD,20) " " 
from SFG.TMP_RS00200M@UMSP.WORLD where GEO_AREA_CD like '%tp'	
 and rownum < 2;

select  'TMP_RS00200M' " ",  'SERVICE_TP' " ",  rpad(SERVICE_TP,20) " " 
from SFG.TMP_RS00200M@UMSP.WORLD where SERVICE_TP like '%tp'	
 and rownum < 2;

select  'TMP_RS00200M' " ",  'RESOLUTION_CD' " ",  rpad(RESOLUTION_CD,20) " " 
from SFG.TMP_RS00200M@UMSP.WORLD where RESOLUTION_CD like '%tp'	
 and rownum < 2;

select  'TMP_RS00200M' " ",  'ASSET_TP' " ",  rpad(ASSET_TP,20) " " 
from SFG.TMP_RS00200M@UMSP.WORLD where ASSET_TP like '%tp'	
 and rownum < 2;

select  'TMP_RS00200M' " ",  'ACTION_STAT' " ",  rpad(ACTION_STAT,20) " " 
from SFG.TMP_RS00200M@UMSP.WORLD where ACTION_STAT like '%tp'	
 and rownum < 2;

select  'TMP_RS00200M' " ",  'DISTRIBUTION_OVRD' " ",  rpad(DISTRIBUTION_OVRD,20) " " 
from SFG.TMP_RS00200M@UMSP.WORLD where DISTRIBUTION_OVRD like '%tp'	
 and rownum < 2;

select  'TMP_RS50800C' " ",  'ASSET_TP' " ",  rpad(ASSET_TP,20) " " 
from SFG.TMP_RS50800C@UMSP.WORLD where ASSET_TP like '%tp'	
 and rownum < 2;

select  'TMP_RS50800C' " ",  'SET_DFLT_STAT' " ",  rpad(SET_DFLT_STAT,20) " " 
from SFG.TMP_RS50800C@UMSP.WORLD where SET_DFLT_STAT like '%tp'	
 and rownum < 2;

select  'TMP_RS50800C' " ",  'SERVICE_PURPOSE' " ",  rpad(SERVICE_PURPOSE,20) " " 
from SFG.TMP_RS50800C@UMSP.WORLD where SERVICE_PURPOSE like '%tp'	
 and rownum < 2;

select  'TMP_UM00111T' " ",  'HISTORY_CD' " ",  rpad(HISTORY_CD,20) " " 
from SFG.TMP_UM00111T@UMSP.WORLD where HISTORY_CD like '%tp'	
 and rownum < 2;

select  'TMP_UM00111T' " ",  'ASSET_TP' " ",  rpad(ASSET_TP,20) " " 
from SFG.TMP_UM00111T@UMSP.WORLD where ASSET_TP like '%tp'	
 and rownum < 2;

select  'TMP_UM00111T' " ",  'SERVICE_TP' " ",  rpad(SERVICE_TP,20) " " 
from SFG.TMP_UM00111T@UMSP.WORLD where SERVICE_TP like '%tp'	
 and rownum < 2;

select  'TMP_UM00111T' " ",  'STATUS' " ",  rpad(STATUS,20) " " 
from SFG.TMP_UM00111T@UMSP.WORLD where STATUS like '%tp'	
 and rownum < 2;

select  'TMP_UM53000C' " ",  'SERVICE_TP' " ",  rpad(SERVICE_TP,20) " " 
from SFG.TMP_UM53000C@UMSP.WORLD where SERVICE_TP like '%tp'	
 and rownum < 2;

select  'TMP_UM53000C' " ",  'LOCATION_CLASS' " ",  rpad(LOCATION_CLASS,20) " " 
from SFG.TMP_UM53000C@UMSP.WORLD where LOCATION_CLASS like '%tp'	
 and rownum < 2;

select  'TMP_UM53000C' " ",  'DEPOSIT_RULE_TP' " ",  rpad(DEPOSIT_RULE_TP,20) " " 
from SFG.TMP_UM53000C@UMSP.WORLD where DEPOSIT_RULE_TP like '%tp'	
 and rownum < 2;

select  'TMP_UM53000C' " ",  'INTEREST_CD' " ",  rpad(INTEREST_CD,20) " " 
from SFG.TMP_UM53000C@UMSP.WORLD where INTEREST_CD like '%tp'	
 and rownum < 2;

select  'UM00100M' " ",  'LOCATION_CLASS' " ",  rpad(LOCATION_CLASS,20) " " 
from SFG.UM00100M@UMSP.WORLD where LOCATION_CLASS like '%tp'	
 and rownum < 2;

select  'UM00100M' " ",  'FUTURE_LOC_CLASS' " ",  rpad(FUTURE_LOC_CLASS,20) " " 
from SFG.UM00100M@UMSP.WORLD where FUTURE_LOC_CLASS like '%tp'	
 and rownum < 2;

select  'UM00100M' " ",  'LOCATION_STAT' " ",  rpad(LOCATION_STAT,20) " " 
from SFG.UM00100M@UMSP.WORLD where LOCATION_STAT like '%tp'	
 and rownum < 2;

select  'UM00100M' " ",  'DISTRICT_CD' " ",  rpad(DISTRICT_CD,20) " " 
from SFG.UM00100M@UMSP.WORLD where DISTRICT_CD like '%tp'	
 and rownum < 2;

select  'UM00100M' " ",  'STREET_PFX_DIR' " ",  rpad(STREET_PFX_DIR,20) " " 
from SFG.UM00100M@UMSP.WORLD where STREET_PFX_DIR like '%tp'	
 and rownum < 2;

select  'UM00100M' " ",  'STREET_SFX_DIR' " ",  rpad(STREET_SFX_DIR,20) " " 
from SFG.UM00100M@UMSP.WORLD where STREET_SFX_DIR like '%tp'	
 and rownum < 2;

select  'UM00100M' " ",  'SEC_ADDR_ID' " ",  rpad(SEC_ADDR_ID,20) " " 
from SFG.UM00100M@UMSP.WORLD where SEC_ADDR_ID like '%tp'	
 and rownum < 2;

select  'UM00100M' " ",  'PROVINCE_CD' " ",  rpad(PROVINCE_CD,20) " " 
from SFG.UM00100M@UMSP.WORLD where PROVINCE_CD like '%tp'	
 and rownum < 2;

select  'UM00100M' " ",  'LIS_CD' " ",  rpad(LIS_CD,20) " " 
from SFG.UM00100M@UMSP.WORLD where LIS_CD like '%tp'	
 and rownum < 2;

select  'UM00100M' " ",  'LIS_VALIDAT_STAT' " ",  rpad(LIS_VALIDAT_STAT,20) " " 
from SFG.UM00100M@UMSP.WORLD where LIS_VALIDAT_STAT like '%tp'	
 and rownum < 2;

select  'UM00100M' " ",  'SC_OLD_LOC_CLASS' " ",  rpad(SC_OLD_LOC_CLASS,20) " " 
from SFG.UM00100M@UMSP.WORLD where SC_OLD_LOC_CLASS like '%tp'	
 and rownum < 2;

select  'UM00100M' " ",  'SC_NEW_LOC_CLASS' " ",  rpad(SC_NEW_LOC_CLASS,20) " " 
from SFG.UM00100M@UMSP.WORLD where SC_NEW_LOC_CLASS like '%tp'	
 and rownum < 2;

select  'UM00100M' " ",  'SELECT_CD' " ",  rpad(SELECT_CD,20) " " 
from SFG.UM00100M@UMSP.WORLD where SELECT_CD like '%tp'	
 and rownum < 2;

select  'UM00100M' " ",  'GENERIC_CD_1' " ",  rpad(GENERIC_CD_1,20) " " 
from SFG.UM00100M@UMSP.WORLD where GENERIC_CD_1 like '%tp'	
 and rownum < 2;

select  'UM00100M' " ",  'GENERIC_CD_2' " ",  rpad(GENERIC_CD_2,20) " " 
from SFG.UM00100M@UMSP.WORLD where GENERIC_CD_2 like '%tp'	
 and rownum < 2;

select  'UM00100M' " ",  'GENERIC_CD_3' " ",  rpad(GENERIC_CD_3,20) " " 
from SFG.UM00100M@UMSP.WORLD where GENERIC_CD_3 like '%tp'	
 and rownum < 2;

select  'UM00111T' " ",  'HISTORY_CD' " ",  rpad(HISTORY_CD,20) " " 
from SFG.UM00111T@UMSP.WORLD where HISTORY_CD like '%tp'	
 and rownum < 2;

select  'UM00111T' " ",  'ASSET_TP' " ",  rpad(ASSET_TP,20) " " 
from SFG.UM00111T@UMSP.WORLD where ASSET_TP like '%tp'	
 and rownum < 2;

select  'UM00111T' " ",  'SERVICE_TP' " ",  rpad(SERVICE_TP,20) " " 
from SFG.UM00111T@UMSP.WORLD where SERVICE_TP like '%tp'	
 and rownum < 2;

select  'UM00111T' " ",  'STATUS' " ",  rpad(STATUS,20) " " 
from SFG.UM00111T@UMSP.WORLD where STATUS like '%tp'	
 and rownum < 2;

select  'UM00111T' " ",  'SITUAT_CD' " ",  rpad(SITUAT_CD,20) " " 
from SFG.UM00111T@UMSP.WORLD where SITUAT_CD like '%tp'	
 and rownum < 2;

select  'UM00111T' " ",  'SUBSIT_CD' " ",  rpad(SUBSIT_CD,20) " " 
from SFG.UM00111T@UMSP.WORLD where SUBSIT_CD like '%tp'	
 and rownum < 2;

select  'UM00120T' " ",  'OWNER_STAT' " ",  rpad(OWNER_STAT,20) " " 
from SFG.UM00120T@UMSP.WORLD where OWNER_STAT like '%tp'	
 and rownum < 2;

select  'UM00120T' " ",  'OCCUPANT_TP' " ",  rpad(OCCUPANT_TP,20) " " 
from SFG.UM00120T@UMSP.WORLD where OCCUPANT_TP like '%tp'	
 and rownum < 2;

select  'UM00130T' " ",  'LOCATION_CLASS' " ",  rpad(LOCATION_CLASS,20) " " 
from SFG.UM00130T@UMSP.WORLD where LOCATION_CLASS like '%tp'	
 and rownum < 2;

select  'UM00130T' " ",  'FUTURE_LOC_CLASS' " ",  rpad(FUTURE_LOC_CLASS,20) " " 
from SFG.UM00130T@UMSP.WORLD where FUTURE_LOC_CLASS like '%tp'	
 and rownum < 2;

select  'UM00130T' " ",  'LOCATION_STAT' " ",  rpad(LOCATION_STAT,20) " " 
from SFG.UM00130T@UMSP.WORLD where LOCATION_STAT like '%tp'	
 and rownum < 2;

select  'UM00130T' " ",  'DISTRICT_CD' " ",  rpad(DISTRICT_CD,20) " " 
from SFG.UM00130T@UMSP.WORLD where DISTRICT_CD like '%tp'	
 and rownum < 2;

select  'UM00130T' " ",  'STREET_PFX_DIR' " ",  rpad(STREET_PFX_DIR,20) " " 
from SFG.UM00130T@UMSP.WORLD where STREET_PFX_DIR like '%tp'	
 and rownum < 2;

select  'UM00130T' " ",  'STREET_SFX_DIR' " ",  rpad(STREET_SFX_DIR,20) " " 
from SFG.UM00130T@UMSP.WORLD where STREET_SFX_DIR like '%tp'	
 and rownum < 2;

select  'UM00130T' " ",  'SEC_ADDR_ID' " ",  rpad(SEC_ADDR_ID,20) " " 
from SFG.UM00130T@UMSP.WORLD where SEC_ADDR_ID like '%tp'	
 and rownum < 2;

select  'UM00130T' " ",  'PROVINCE_CD' " ",  rpad(PROVINCE_CD,20) " " 
from SFG.UM00130T@UMSP.WORLD where PROVINCE_CD like '%tp'	
 and rownum < 2;

select  'UM00130T' " ",  'LIS_CD' " ",  rpad(LIS_CD,20) " " 
from SFG.UM00130T@UMSP.WORLD where LIS_CD like '%tp'	
 and rownum < 2;

select  'UM00130T' " ",  'LIS_VALIDAT_STAT' " ",  rpad(LIS_VALIDAT_STAT,20) " " 
from SFG.UM00130T@UMSP.WORLD where LIS_VALIDAT_STAT like '%tp'	
 and rownum < 2;

select  'UM00130T' " ",  'SC_OLD_LOC_CLASS' " ",  rpad(SC_OLD_LOC_CLASS,20) " " 
from SFG.UM00130T@UMSP.WORLD where SC_OLD_LOC_CLASS like '%tp'	
 and rownum < 2;

select  'UM00130T' " ",  'SC_NEW_LOC_CLASS' " ",  rpad(SC_NEW_LOC_CLASS,20) " " 
from SFG.UM00130T@UMSP.WORLD where SC_NEW_LOC_CLASS like '%tp'	
 and rownum < 2;

select  'UM00130T' " ",  'SELECT_CD' " ",  rpad(SELECT_CD,20) " " 
from SFG.UM00130T@UMSP.WORLD where SELECT_CD like '%tp'	
 and rownum < 2;

select  'UM00130T' " ",  'GENERIC_CD_1' " ",  rpad(GENERIC_CD_1,20) " " 
from SFG.UM00130T@UMSP.WORLD where GENERIC_CD_1 like '%tp'	
 and rownum < 2;

select  'UM00130T' " ",  'GENERIC_CD_2' " ",  rpad(GENERIC_CD_2,20) " " 
from SFG.UM00130T@UMSP.WORLD where GENERIC_CD_2 like '%tp'	
 and rownum < 2;

select  'UM00130T' " ",  'GENERIC_CD_3' " ",  rpad(GENERIC_CD_3,20) " " 
from SFG.UM00130T@UMSP.WORLD where GENERIC_CD_3 like '%tp'	
 and rownum < 2;

select  'UM00140T' " ",  'SERVICE_TP' " ",  rpad(SERVICE_TP,20) " " 
from SFG.UM00140T@UMSP.WORLD where SERVICE_TP like '%tp'	
 and rownum < 2;

select  'UM00140T' " ",  'SERV_DISTRICT_CD' " ",  rpad(SERV_DISTRICT_CD,20) " " 
from SFG.UM00140T@UMSP.WORLD where SERV_DISTRICT_CD like '%tp'	
 and rownum < 2;

select  'UM00141T' " ",  'SERVICE_TP' " ",  rpad(SERVICE_TP,20) " " 
from SFG.UM00141T@UMSP.WORLD where SERVICE_TP like '%tp'	
 and rownum < 2;

select  'UM00142T' " ",  'BILL_CD' " ",  rpad(BILL_CD,20) " " 
from SFG.UM00142T@UMSP.WORLD where BILL_CD like '%tp'	
 and rownum < 2;

select  'UM00143T' " ",  'SERVICE_TP' " ",  rpad(SERVICE_TP,20) " " 
from SFG.UM00143T@UMSP.WORLD where SERVICE_TP like '%tp'	
 and rownum < 2;

select  'UM00144T' " ",  'TAX_CD' " ",  rpad(TAX_CD,20) " " 
from SFG.UM00144T@UMSP.WORLD where TAX_CD like '%tp'	
 and rownum < 2;

select  'UM00145T' " ",  'CONTRACT_CD' " ",  rpad(CONTRACT_CD,20) " " 
from SFG.UM00145T@UMSP.WORLD where CONTRACT_CD like '%tp'	
 and rownum < 2;

select  'UM00145T' " ",  'ID_OVERRIDE_DISCNT' " ",  rpad(ID_OVERRIDE_DISCNT,20) " " 
from SFG.UM00145T@UMSP.WORLD where ID_OVERRIDE_DISCNT like '%tp'	
 and rownum < 2;

select  'UM00150T' " ",  'ASSET_TP' " ",  rpad(ASSET_TP,20) " " 
from SFG.UM00150T@UMSP.WORLD where ASSET_TP like '%tp'	
 and rownum < 2;

select  'UM00151T' " ",  'ASSET_TP' " ",  rpad(ASSET_TP,20) " " 
from SFG.UM00151T@UMSP.WORLD where ASSET_TP like '%tp'	
 and rownum < 2;

select  'UM00151T' " ",  'ASSET_STAT' " ",  rpad(ASSET_STAT,20) " " 
from SFG.UM00151T@UMSP.WORLD where ASSET_STAT like '%tp'	
 and rownum < 2;

select  'UM00155T' " ",  'UMS_ASSET_TP' " ",  rpad(UMS_ASSET_TP,20) " " 
from SFG.UM00155T@UMSP.WORLD where UMS_ASSET_TP like '%tp'	
 and rownum < 2;

select  'UM00160T' " ",  'METER_STAT' " ",  rpad(METER_STAT,20) " " 
from SFG.UM00160T@UMSP.WORLD where METER_STAT like '%tp'	
 and rownum < 2;

select  'UM00160T' " ",  'INST_LOC_1' " ",  rpad(INST_LOC_1,20) " " 
from SFG.UM00160T@UMSP.WORLD where INST_LOC_1 like '%tp'	
 and rownum < 2;

select  'UM00160T' " ",  'INST_LOC_2' " ",  rpad(INST_LOC_2,20) " " 
from SFG.UM00160T@UMSP.WORLD where INST_LOC_2 like '%tp'	
 and rownum < 2;

select  'UM00160T' " ",  'INST_LOC_3' " ",  rpad(INST_LOC_3,20) " " 
from SFG.UM00160T@UMSP.WORLD where INST_LOC_3 like '%tp'	
 and rownum < 2;

select  'UM00161T' " ",  'REGISTER_TP' " ",  rpad(REGISTER_TP,20) " " 
from SFG.UM00161T@UMSP.WORLD where REGISTER_TP like '%tp'	
 and rownum < 2;

select  'UM00162T' " ",  'BILL_CD' " ",  rpad(BILL_CD,20) " " 
from SFG.UM00162T@UMSP.WORLD where BILL_CD like '%tp'	
 and rownum < 2;

select  'UM00163T' " ",  'REGISTER_TP' " ",  rpad(REGISTER_TP,20) " " 
from SFG.UM00163T@UMSP.WORLD where REGISTER_TP like '%tp'	
 and rownum < 2;

select  'UM00163T' " ",  'RCT_SOURCE_CD' " ",  rpad(RCT_SOURCE_CD,20) " " 
from SFG.UM00163T@UMSP.WORLD where RCT_SOURCE_CD like '%tp'	
 and rownum < 2;

select  'UM00163T' " ",  'CYCLE_CD' " ",  rpad(CYCLE_CD,20) " " 
from SFG.UM00163T@UMSP.WORLD where CYCLE_CD like '%tp'	
 and rownum < 2;

select  'UM00163T' " ",  'READ_TP' " ",  rpad(READ_TP,20) " " 
from SFG.UM00163T@UMSP.WORLD where READ_TP like '%tp'	
 and rownum < 2;

select  'UM00163T' " ",  'READ_ENTRY_CD' " ",  rpad(READ_ENTRY_CD,20) " " 
from SFG.UM00163T@UMSP.WORLD where READ_ENTRY_CD like '%tp'	
 and rownum < 2;

select  'UM00163T' " ",  'METER_READER_CD' " ",  rpad(METER_READER_CD,20) " " 
from SFG.UM00163T@UMSP.WORLD where METER_READER_CD like '%tp'	
 and rownum < 2;

select  'UM00163T' " ",  'READ_EXCEPTION_CD' " ",  rpad(READ_EXCEPTION_CD,20) " " 
from SFG.UM00163T@UMSP.WORLD where READ_EXCEPTION_CD like '%tp'	
 and rownum < 2;

select  'UM00163T' " ",  'HILO_EXCEPTION_CD' " ",  rpad(HILO_EXCEPTION_CD,20) " " 
from SFG.UM00163T@UMSP.WORLD where HILO_EXCEPTION_CD like '%tp'	
 and rownum < 2;

select  'UM00163T' " ",  'HILO_ACTION_CD' " ",  rpad(HILO_ACTION_CD,20) " " 
from SFG.UM00163T@UMSP.WORLD where HILO_ACTION_CD like '%tp'	
 and rownum < 2;

select  'UM00163T' " ",  'ADJ_REASON_CD' " ",  rpad(ADJ_REASON_CD,20) " " 
from SFG.UM00163T@UMSP.WORLD where ADJ_REASON_CD like '%tp'	
 and rownum < 2;

select  'UM00163T' " ",  'TOU_PERIOD_CD' " ",  rpad(TOU_PERIOD_CD,20) " " 
from SFG.UM00163T@UMSP.WORLD where TOU_PERIOD_CD like '%tp'	
 and rownum < 2;

