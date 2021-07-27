{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl{\f0\fnil\fcharset0 Courier New;}{\f1\fswiss\fcharset0 Arial;}}
{\*\generator Msftedit 5.41.15.1503;}\viewkind4\uc1\pard\f0\fs20 --\tab =====================================================================\par
set\tab echo\tab\tab\tab off;\par
set\tab timing\tab\tab off;\par
set\tab sqlblanklines\tab on;\par
set\tab serveroutput\tab on\tab size 9999;\par
set\tab linesize\tab\tab 2000;\par
set\tab pagesize\tab\tab 9999;\par
--\tab =====================================================================\par
\par
--\tab include acct_use\par
--\tab include ssn\par
\par
--\tab =====================================================================\par
\par
\tab select '**** START CCS  **** ' || to_char(sysdate,'Mon dd hh24:mi') " "  from dual;\par
\par
--\tab =====================================================================\par
--\tab BACKUP\par
\par
\tab select to_char(sysdate,'Mon dd hh24:mi   ')|| 'BACKUP CCS' " " from dual;\par
\tab execute jdeacutis.CCS_BACKUP('WAIT');\par
\par
--\tab =====================================================================\par
--\tab INPUT\par
\par
\tab select to_char(sysdate,'Mon dd hh24:mi   ')|| 'INPUT GDS Account' " " from dual;\par
\tab execute garland.CCS_INPUT_GDS_ACCOUNT;\par
\par
\tab select to_char(sysdate,'Mon dd hh24:mi   ')|| 'INPUT GDS Exemption' " " from dual;\par
\tab execute garland.CCS_INPUT_GDS_EXEMPTION;\tab\par
\par
\tab select to_char(sysdate,'Mon dd hh24:mi   ')|| 'INPUT GDS Year' " " from dual;\par
\tab execute garland.CCS_INPUT_GDS_YEAR;\par
\par
--\tab =====================================================================\par
--\tab SCRUB ADDRESS\par
\par
\tab select to_char(sysdate,'Mon dd hh24:mi   ')|| 'COMPILE Scrub Address' " " from dual;\par
\tab execute garland.CCS_COMPILE_SCRUB_ADDRESS;\par
\par
\tab select to_char(sysdate,'Mon dd hh24:mi   ')|| 'VERIFY TAX Address' " " from dual;\par
\tab execute garland.CCS_VERIFY_TAX;\par
\par
\tab select to_char(sysdate,'Mon dd hh24:mi   ')|| 'COMPILE Scrub Address' " " from dual;\par
\tab execute garland.CCS_COMPILE_SCRUB_ADDRESS;\par
\par
\tab select to_char(sysdate,'Mon dd hh24:mi   ')|| 'VERIFY UMS Address' " " from dual;\par
\tab execute garland.CCS_VERIFY_UMS;\par
\par
\tab execute garland.CCS_COMPILE;\par
\par
--\tab =====================================================================\par
--\tab CCS_GIS\par
\par
\tab select to_char(sysdate,'Mon dd hh24:mi   ')|| 'GIS Build Common GIS' " " from dual;\par
\tab execute garland.CCS_GIS_Build_Common_GIS;\par
\par
--\tab =====================================================================\par
--\tab CCS_TAX\par
\par
\tab select to_char(sysdate,'Mon dd hh24:mi   ')|| 'TAX Format Tax Owner' " " from dual;\par
\tab execute garland.CCS_TAX_FORMAT_OWNER;\par
\par
\tab select to_char(sysdate,'Mon dd hh24:mi   ')|| 'TAX Build Exemption' " " from dual;\par
\tab execute garland.CCS_TAX_BUILD_EXEMPTION;\par
\par
\tab select to_char(sysdate,'Mon dd hh24:mi   ')|| 'TAX Build Common TAX' " " from dual;\par
\tab execute garland.CCS_TAX_BUILD_COMMON_TAX;\par
\par
--\tab =====================================================================\par
--\tab CCS_UMS\par
\par
\tab select to_char(sysdate,'Mon dd hh24:mi   ')|| 'UMS Get UMS Keys' " " from dual;\par
\tab execute garland.CCS_UMS_Get_Keys;\par
\par
\tab select to_char(sysdate,'Mon dd hh24:mi   ')|| 'UMS Build Basic UMS' " " from dual;\par
\tab execute garland.CCS_UMS_Build_Basic_UMS;\par
\par
\tab select to_char(sysdate,'Mon dd hh24:mi   ')|| 'UMS Get Basic Address' " " from dual;\par
\tab execute garland.CCS_UMS_Get_Address;\par
\par
\tab select to_char(sysdate,'Mon dd hh24:mi   ')|| 'UMS Remove Basic Dupe' " " from dual;\par
\tab execute garland.CCS_UMS_Remove_Dupe;\par
\par
\tab select to_char(sysdate,'Mon dd hh24:mi   ')|| 'UMS Build Common UMS' " " from dual;\par
\tab execute garland.CCS_UMS_Build_Common_UMS;\par
\par
--\tab =====================================================================\par
--\tab CCS_LINK\par
\par
\tab select to_char(sysdate,'Mon dd hh24:mi   ')|| 'LINK Build Common Keys' " " from dual;\par
\tab execute garland.CCS_LINK_Common_Keys;\par
\par
--\tab =====================================================================\par
--\tab CCS_LOAD\par
\par
\tab select to_char(sysdate,'Mon dd hh24:mi   ')|| 'LOAD View to Table' " " from dual;\par
\tab execute garland.CCS_LOAD_VIEW_TO_TABLE;\par
\par
\tab select to_char(sysdate,'Mon dd hh24:mi   ')|| 'LOAD Identifier' " " from dual;\par
\tab execute garland.CCS_LOAD_IDENTIFIER;\par
\par
--\tab =====================================================================\par
--\tab LOAD NEW TO PRODUCTION\par
\par
\tab select to_char(sysdate,'Mon dd hh24:mi   ')|| 'LOAD Production' " " from dual;\par
\par
--\tab WAIT  = Don't Load final extract to production CCS during working hours (Default)\par
--\tab STOP  = Don't Load final extract to production CCS  \par
--\tab GO    = Do Load final extract to production CCS if Quality Control checks out\par
--\tab FORCE = Do Load final extract to production CCS regardless of QC checks\par
\par
\tab execute garland.CCS_LOAD_PRODUCTION('GO');\par
--\tab execute garland.CCS_LOAD_PRODUCTION('STOP');\par
\par
--\tab =====================================================================\par
--\tab ANALYZE\par
\par
\tab select to_char(sysdate,'Mon dd hh24:mi   ')|| 'Analyze ' " " from dual;\par
\par
\tab Analyze table garland.CCS_ADDRESS compute statistics;\par
\par
\tab Analyze table garland.CCS_IDENTIFIER compute statistics;\par
\par
--\tab =====================================================================\par
\par
\tab select '**** STOP CCS  **** ' || to_char(sysdate,'Mon dd hh24:mi') " "  from dual;\par
\par
--\tab =================================================================================\par
\par
\par
\f1\par
}
 