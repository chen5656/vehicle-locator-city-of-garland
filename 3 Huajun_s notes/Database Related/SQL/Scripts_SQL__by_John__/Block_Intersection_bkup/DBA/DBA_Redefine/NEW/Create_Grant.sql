

	select	'grant '	||


			ltrim  (
			decode (select_priv, 	 'Y', ',select ', 	   'G', ',select ', 	null )	||
			decode (insert_priv, 	 'Y', ',insert ', 	   'G', ',insert ', 	null )	||
			decode (delete_priv, 	 'Y', ',delete ', 	   'G', ',delete ', 	null )	||
			decode (update_priv, 	 'Y', ',update ', 	   'G', ',update ', 	null )	||
			decode (alter_priv,  	 'Y', ',alter ',  	   'G', ',alter ',  	null )	||
			decode (index_priv,	 'Y', ',index ',  	   'G', ',index ',  	null )	||
			decode (references_priv, 'Y', ',references ', 	   'G', ',references ',	null )
			, ',')		 ||

			' on ' || a.owner  ||'.'|| a.table_name || '    to '	|| a.grantee || '    '	||
			
			decode (grantable, 'YES', 'with grant option', null )	||
			';'

			" "

	from		table_privileges		a,
			dba_tab_privs		b
--			tmp_view

	where		a.owner		= b.owner
	and		a.table_name	= b.table_name

--	and		a.table_name	= key_
--	and		a.grantor		= schema_

	and		a.table_name	in
	(
		select table_name 	from table_privileges
		minus	
		select table_name		from dba_col_privs
	)	




--	and		insert_priv = 'Y'
--	and		grantable 	= 'YES'
	and		rownum 	< 11
	;


--	====================================================================================
--	====================================================================================






--	====================================================================================
