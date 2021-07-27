
--	Block ID Sequence

--	=================================================================================

--	D O   N O T   R E D E F I N E   B L O C K   I D   S E Q U E N C E

--	=================================================================================


--	drop sequence		garland.block_id_seq;

	create sequence		garland.block_id_seq
		start with		3000000
		increment by	01
		minvalue		3000000
		maxvalue		3999999
		nocache			
		nocycle
		noorder;