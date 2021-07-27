

begin

	DBMS_UTILITY.EXEC_DDL_STATEMENT ( 'truncate table garland.gis_temp2' );

	DBMS_UTILITY.EXEC_DDL_STATEMENT ( 'analyze table garland.gis_temp2  compute statistics' );

end;
