
--	CREATE CONSTRAINT EXCEPTION TABLE

--	C:ORANT\SCRIPTS\AdrTable\TBLexcept.sql

--	@11-20-97


CREATE TABLE	Except_Table
		(
		row_id	ROWID,
		owner		VARCHAR2(30),
		table_name	VARCHAR2(30),
		constraint	VARCHAR2(30)
		)
	
		