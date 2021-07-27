
	set charwidth	200;


	select	'create sequence ' || sequence_owner ||'.'|| sequence_name 			|| chr(10) ||

			'start with '	|| round (last_number / increment_by, 0)	||	

			'  increment by '	|| increment_by							|| chr(10) ||

			'minvalue   ' || min_value	|| '  maxvalue     '	|| max_value	|| chr(10) ||
			
			'cache      ' || cache_size	|| 

			'  '	|| decode (cycle_flag, 'N', 'nocycle', 'cycle')	||			

			'   ' || decode (order_flag, 'N', 'noorder', 'order')				|| chr(10) ||
			';'	" "

	from		dba_sequences

--	=================================================================================================

	where		sequence_owner	= 'GARLAND'

	and		sequence_name	in	( 'TMP_WORK_SEQ',			' ')

--	and		sequence_name	like '%'

	;
--	=================================================================================================

