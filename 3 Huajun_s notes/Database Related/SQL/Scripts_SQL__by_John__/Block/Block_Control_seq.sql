
--	Block_Control Sequence

--	=================================================================================

--	D O   N O T   R E D E F I N E   B L O C K   C O N T R O L   S E Q U E N C E

--	=================================================================================


--	drop sequence		garland.block_control_seq;

	create sequence		garland.block_control_seq
		start with		0000001
		increment by	01
		minvalue		00001
		maxvalue		99999
		nocache			
		nocycle
		noorder;
