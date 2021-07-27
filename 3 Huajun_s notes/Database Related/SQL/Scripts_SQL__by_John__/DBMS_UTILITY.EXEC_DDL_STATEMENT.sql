

begin

	DBMS_UTILITY.EXEC_DDL_STATEMENT ( 'Truncate table  garland.GIS_  reuse storage' );

	DBMS_UTILITY.EXEC_DDL_STATEMENT ( 'analyze table garland.gis_temp2  compute statistics' );

end;

