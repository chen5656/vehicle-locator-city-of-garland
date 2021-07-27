--	======================================================================

( '$appl		/'||	appl.addr_num  ||'/'|| appl.addr_pfx ||'/'|| appl.addr_name
			||'/'||	appl.addr_type ||'/'|| appl.addr_sfx 
			||'/'||	appl.addr_code ||'/'|| appl.addr_unit||'/');

--	======================================================================

( '$alien	'  || alien_method   ||
		appl.addr_pfx  ||'/'|| appl.addr_name ||'/'|| 
		appl.addr_type ||'/'|| appl.addr_sfx  ||'/'|| 
		appl.addr_code ||'/'|| appl.addr_unit ||'/'|| 
					' ');

( '$alias	'  || new.addr_pfx  ||'/'|| new.addr_name ||'/'|| 
		new.addr_type ||'/'|| new.addr_sfx	||'/'	);

--	======================================================================

( '$work1		' || phase ||'/'|| work.permit   ||'/'|| work.rule_pfx ||'/'|| 
	work.rule_type ||'/'|| work.rule_sfx ||'/' ); 
( '$work2		'||prev_score||'/'||forbid_append||'/'||forbid_remove||'/'||forbid_change||'/');

--	======================================================================

('$unique1	/' ||read_pfx	||'/'||read_type	||'/'||read_sfx 	   ||'/' );
('$unique2	/' ||unique_prefix	||'/'||unique_type||'/'||unique_suffix ||'/'||
	  	    match_prefix 	||'/'||match_type ||'/'||match_suffix  ||'/');

<<end_fetch_loop>>

--	======================================================================

<<unique>>

( '$audit1	' ||this_audit );
( '$audit2	' ||lpad(new.addr_num,4) ||'/'||new.addr_pfx||'/'||new.addr_name||'/'||
		    new.addr_type||'/'||new.addr_sfx||'/'	);

--	======================================================================

('$match1	'||	lpad(this_weight,4) ||' /'|| read_pfx ||'/'||read_type||'/'||
			read_sfx ||'/');
('$match2	'||	lpad(best_weight,4) ||' /'|| best_pfx ||'/'||best_name||'/'||
			best_type||'/'|| best_sfx ||'/  ');

<<end_match_loop>>

--	======================================================================

('$phase1	' ||lpad(new.addr_num,4)  ||'/'||new.addr_pfx||'/'||new.addr_name||'/'||
		    new.addr_type ||'/'||new.addr_sfx||'/'	);
('$phase2	' ||work.fetch_count  ||'/'||work.match_count||'/'||
			this_audit  ||'/'||		  	
		    work.rule_type||'/'||work.rule_pfx||'/'||work.rule_sfx||'/' );
('$phase3	' ||str_score  ||'/'||blk_score||'/'||seg_score||'/'||adr_score||'/');

<<end_phase_loop>>

--	======================================================================

( '$verify1	'||	adr.fetch_count ||';'|| adr.match_count	||'  '||
			seg.fetch_count ||';'|| seg.match_count	||'  '||
			blk.fetch_count ||';'|| blk.match_count	||'  '||
			str.fetch_count ||';'|| str.match_count	);
( '$verify2	'||	street_count    ||'/'|| accept_count	);

--	======================================================================

( '$insert0	'   ||new.app_pfx  ||'/'||new.app_name ||'/'||
			new.app_type ||'/'||new.app_sfx  ||'/'||
			new.app_code ||'/'||new.app_unit ||'/'		);
( '$insert1	'   ||new.old_pfx  ||'/'||new.old_name ||'/'||
			new.old_type ||'/'||new.old_sfx  ||'/'||
			new.old_code ||'/'||new.old_unit ||'/'		);
( '$insert2	'   ||new.addr_num ||'/'||new.addr_pfx ||'/'||new.addr_name||'/'||
			new.addr_type||'/'||new.addr_sfx ||'/'||
			new.addr_code||'/'||new.addr_unit||'/'	);
( '$insert3	'   ||new.verify_code ||'/'||new.do_parse||'/'||new.do_alias||'/'||
			new.do_name	||'/'||new.do_qual ||'/'	);

--	======================================================================


--	======================================================================
--	======================================================================

( 'name		' || phase ||'/'|| best_addr_name   ||'/'|| best_name_chg ||'/'|| 
	verify_weight ||'/'|| verify_level ||'/'|| name_count||'/'	); 

--	======================================================================
--	======================================================================