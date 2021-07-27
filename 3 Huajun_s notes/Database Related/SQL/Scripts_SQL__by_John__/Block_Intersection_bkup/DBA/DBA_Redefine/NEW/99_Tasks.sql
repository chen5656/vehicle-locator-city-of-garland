
TASKS
=====

1.	process object for specific tables or for all objects in schema
	(somewhat slower execution)

	where		owner		= schema_
	and	((	table_name	= key_
	and		'table'	= type_	)
	or  		'all'		= option1_	)
		

2.	Table Dependents

		Trigger					trigger is dropped when table is dropped
								trigger is dependent object 			(Concepts 15-4, 16-2)

		Privilege					privilege is dropped when table is dropped

								privileges on views are not dropped 	(SQL 4-273) 


.		Function, Procedure, Package		status = invalid					(SQL 4-273)
.		View 						status = invalid					(SQL 4-273)


		Snapshot					remains but cannot be refreshed  		(SQL 4-273)


		Cluster




3.	Table Column

		Check Option

		Data Default


