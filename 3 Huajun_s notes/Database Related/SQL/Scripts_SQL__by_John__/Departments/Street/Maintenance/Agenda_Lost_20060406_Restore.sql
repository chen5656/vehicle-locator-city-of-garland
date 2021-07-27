
PROBLEM

	Problem on SDE with SEWER_PIPE	Apr 6 2006

	Restore back to APR 5,2006  8:00 am

	Did not save and restore STREETS


SOLUTION

	make COPY of streets on PRODUCTION for APR 10

	on TSTDBS:  RESTORE to APR 6 2006 5:00

	------------------------------------------------

	Compare COPY vs RESTORE tables as follows:
	
	Select COPY minus RESTORE

		PAVE CUST
		PAVE CUST ARCH
		PAVE PROJ
		PAVE PROJ ARCH

	Select RESTORE minus COPY

		PAVE TASK
	
	------------------------------------------------

	Truncate  PRODUCTION STREET tables

	Restore from TSTDBS  STREET tables

	
