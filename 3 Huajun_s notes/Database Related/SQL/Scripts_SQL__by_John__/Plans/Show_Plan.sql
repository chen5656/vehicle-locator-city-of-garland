{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl{\f0\fmodern\fcharset0 Courier;}{\f1\fnil\fcharset0 Courier New;}{\f2\fnil\fprq1\fcharset0 Courier;}}
\viewkind4\uc1\pard\f0\fs15\tab set echo\tab off;\par
--\tab =================================================================================\par
\tab truncate table\tab garland.plan_table\tab reuse storage;\par
\par
\tab alter rollback segment rb1 online;\par
\tab commit;\tab\tab\par
\tab set transaction use rollback segment rb1;\par
\par
--\tab =================================================================================\par
\tab explain plan set statement_id = ' '\tab\tab into garland.plan_table\tab for\par
\par
\par
\tab\par
\tab ;\par
--\tab =================================================================================\par
\f1\fs20 --\tab insert into garland.plan_table (object_owner, object_name) values('GARLAND', '');\par
\f2\fs15\par
\tab execute  explain_More;\par
\tab select * from garland.explain_Plan;\par
--\tab select * from garland.explain_Indexed;\par
--\tab select * from garland.explain_Table;\par
--\tab select * from garland.explain_Index;\par
--\tab select * from garland.explain_Constraint;\par
--\tab select * from garland.explain_Column;\par
--\tab select * from garland.explain_Dependent;\par
--\tab select * from garland.explain_Analyze;\par
\par
\f0\tab savepoint\tab xxx;\tab\par
\tab ROLLBACK;\par
\tab Commit;\par
\tab alter rollback segment rb1 offline;\par
\par
--\tab =================================================================================\par
\tab set echo\tab on;\par
\par
}
 