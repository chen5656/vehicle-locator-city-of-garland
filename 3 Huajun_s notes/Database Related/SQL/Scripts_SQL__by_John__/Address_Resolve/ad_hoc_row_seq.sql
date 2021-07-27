	set echo		off;
	set charwidth	300;
--	=========================================================

	select

	rpad(r.appl_num||'\',5)	|| rpad(r.appl_pfx ||'\',03)	|| rpad(r.appl_name||'\',21)	|| rpad(r.appl_type ||'\',5) 		|| 
	rpad(r.appl_sfx||'\',3)	|| rpad(' ',5)			|| rpad(r.appl_code1||'\',10)	|| rpad(r.appl_unit1||'\',10) 	||

						'key= '			|| r.rec_key	 		|| chr(10)									||

	rpad(r.addr_num||'\',5)	|| rpad(r.form_pfx ||'\',03)	|| rpad(r.form_name||'\',21)	|| rpad(r.form_type||'\',5) || 
	rpad(r.form_sfx||'\',3)	||
	rpad(' ',15)		||	'          seq= '		|| r.rec_seq			|| chr(10)									||

	rpad(r.verify_code,5)	|| rpad(r.addr_pfx  ||'\',03) || rpad(r.addr_name ||'\',21)	|| rpad(r.addr_type ||'\',05)|| 
	rpad(r.addr_sfx  ||'\',03)	||
	rpad(' ',5)			|| rpad(r.addr_code1||'\',10) || rpad(r.addr_unit1||'\',10)	|| rpad(r.addr_code2||'\',10)|| rpad(r.addr_unit2||'\',10) 							

					||	'   alias= '	|| r.do_alias
					||	'   audit= '	|| r.do_qual				|| chr(10)	|| chr(10)
	" "
	from		garland.adrResult		r
--			,garland.gis_app_addr	a

	where		rownum	< 11

--	and		r.rec_rowid	= a.rowid

--	=========================================================

	and		r.rec_seq	= 72150

--	and		r.addr_num	= '4310'

--	and		r.addr_pfx	= upper( '' ) 

--	and		r.addr_name = upper( 'o''banion' )

--	and		r.addr_type	= upper( '' );


--	=========================================================
/*

	and		r.addr_num	= 3818

--	and		r.addr_pfx	= upper( '' ) 

	and		r.addr_name = upper( 'acorn green' )

	and		r.addr_type	= upper( 'cir' );


	and		r.form_name = upper( 'brand' )

	and		r.form_pfx	= upper( ' ' ) 

	and		r.form_type	= upper( ' ' );

	and		r.rec_seq = 7743
	and		r.rec_seq between 47606 and 47610

	and		a.addr_name like upper( '%5TH STR%' )

*/
--	=========================================================
	;

