
--	==================================================================================
/*
	trace_work1	:= 0;			

	if	trace_data = 0							--	if scope failed
	and 	trace_focus	 = 0							--	and not in focus mode
	and	tr_trace	 > 0					then		--	and not in basic mode
		null;									--	then data tracking = off

	elsif	trace_option like trace_of_pick_only			--	if tracing only special items
	and	trace_level > 0							--	and not "pick"  step
	and	trace_lines	> 0							--	and not "basic" item
	and	trace_focus	= 0					then		--	and not "focus" item
		null;									--	then data tracking = off

--	elsif	tr_focus not like '%'|| lower(trace_whox) ||'%'	then
--		null;									--	then data tracking = off
		
	elsif	trace_who || show is not null					--	if there is something to show
	and	tr_show   <> 0							--	and data tracking is active
	and	trace_done = 1							--	and this display is being done
	and 	trace_put < abs(trace_lines)					--	and displayed lines < spec lines

	and ((tr_trace  > 0  and trace_lines <> 0)			--	and display = all   & spec = on
	or   (tr_trace  < 0  and trace_lines <  0))			--	or  display = basic & spec = basic

	and ((tr_show > 0	and	trace_level <= tr_show)			--	and valid scope for tr_show
	or   (tr_show < 0	and	trace_level >= tr_show
				and	trace_level < 0	))

	then	trace_work1 := 1;							--	then data tracking = on
	end if;

	if	trace_focus > 0
	and	tr_focus like '%'|| lower(trace_whox) ||'%'	then
		trace_work1 := 1;							
	end if;
*/
