
--		C:\ORANT\SCRIPTS\SQLtest\TSTprofile.sql



CREATE PROFILE		gis
LIMIT
CPU_PER_CALL		500			--  5 minute execution time
LOGICAL_READS_PER_CALL	100000		--  100,000 rows retrieved
;

COMMIT;