	set echo	off;
--	================================================================================================
--	display block control
--	================================================================================================

--	S1

	select

		rpad(record_id,05)  ||' '|| rpad(nvl(block_id,0),6)||' '||
		rpad(action,03)	  ||' '|| rpad(differ,04)	   ||chr(10)||

		rpad(addr_block,05) ||' '|| rpad(addr_pfx,02) ||' '|| rpad(addr_name,20) ||' '|| 
		rpad(addr_type, 04) ||' '|| rpad(addr_sfx,02) 	   ||chr(10)||

		rpad(repl_block,05) ||' '|| rpad(repl_pfx,02) ||' '|| rpad(repl_name,20) ||' '|| 
		rpad(repl_type, 04) ||' '|| rpad(repl_sfx,02) 	   ||chr(10)||

		rpad(start_lo,05)   ||' '|| rpad(stop_lo,05)  ||' '|| rpad(stop_hi,05)	 ||' '|| 
		rpad(counter, 02)	  ||' '|| chr(10)||

		rpad(source,05)   ||' '|| to_char(add_date, 'mm-dd-yyyy')
		||chr(10)

		"Block Control "					

	from	garland.Block_Control_vw;

--	================================================================================================
	set echo	on;
