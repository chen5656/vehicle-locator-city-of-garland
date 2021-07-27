	set charwidth	240;
--	======================================================================================================
	drop synonym	gis_app_addr_syn;								
	create synonym	gis_app_addr_syn			for gis_app_addr_null;			--	change
--	create synonym	gis_app_addr_syn			for gis_app_addr;
--	======================================================================================================
	variable	 spec	varchar2;
	execute	:spec	:= '''1'',';
--	execute	:spec := '''N''';
--	execute	:spec := '''''';
--	======================================================================================================

	select '*** load Type A alter ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " " from dual;
	spool	c:\deacutis\scripts\address_resolve\alterations\Type_A_Name.sql;			--	change

	select	distinct

			rpad(
			'insert into adrAlter_vw	values ('	||
			rpad (digits, 08)			|| ''''	||
			id					||
--			'  #'					|| seq	||
			' ', 53)				" ",

			rpad(st_name, 12)			st_name, 	 	
			''','					|| chr(10)	||
			string ||	' );'			" " 
	from

(
/*
select	
	''''','''','					digits,
	''''',	'''', '''', '''', '''','	|| chr(10) ||
	''''',	'''', '''', '''', '''','	|| chr(10) ||
	''''',	'''', '''', '''', '''''		string,
	0							seq,
	' '							addr_name,

	'TYPE A'						id				--	change
	from dual
union all
*/

	select	digits,
			string,	
			rec_seq				seq,
			st_name,
			id
	from
(
select	distinct
		lower(r.form_name)			st_name,
		r.rec_seq,
		r.do_name					id,				--	change

	''''', '''','					digits,	

	''''',	'		||
	'''' ||	lower(rtrim(a.addr_pfx))	|| ''', ' ||
	'''' ||	lower(rtrim(a.addr_name))	|| ''', ' ||
	'''' ||	lower(rtrim(a.addr_type))	|| ''', ' ||
	'''' ||	lower(rtrim(a.addr_sfx))	|| ''', ' ||
			chr(10)	||


	ltrim(:spec)		||'  '||

	'''' ||	lower(rtrim(r.form_pfx))	|| ''', ' ||
	'''' ||	lower(rtrim(r.form_name))	|| ''', ' ||
	'''' ||	lower(rtrim(r.form_type))	|| ''', ' ||
	'''' ||	lower(rtrim(r.form_sfx))	|| ''', ' ||
			chr(10)	||


	''''',	'		||
	'''' ||	lower(rtrim(r.addr_pfx))	|| ''', ' ||
	'''' ||	lower(rtrim(r.addr_name))	|| ''', ' ||
	'''' ||	lower(rtrim(r.addr_type))	|| ''', ' ||
	'''' ||	lower(rtrim(r.addr_sfx))	|| '''	 ' 
								string

	from	adrResult		r,
		gis_app_addr_syn	a

	where	r.rec_rowid	= a.row_id
	and	r.do_name	> '0'

--	and	(
--		nvl(upper(rtrim(a.addr_name)),' ') <> some ( nvl(r.form_name,' '), nvl(r.addr_name,' ') )
--	or	nvl(upper(rtrim(a.addr_pfx )),' ') <> some ( nvl(r.form_pfx, ' '), nvl(r.addr_pfx, ' ') )
--	or	nvl(upper(rtrim(a.addr_sfx )),' ') <> some ( nvl(r.form_sfx, ' '), nvl(r.addr_sfx, ' ') )
--	or	nvl(upper(rtrim(a.addr_type)),' ') <> some ( nvl(r.form_type,' '), nvl(r.addr_type,' ') )
--		)

))

--	===============================================

	where		id	= 'A'
	and		seq	>  0		
									
	order by	st_name
;
--	======================================================================================================
/*												
			id	in	( '', '', '' )			--	do_name

			name	in	(	''	)			--	street name
			name	like	'%%'			

			seq	in	( 0	)				--	record sequence
			seq	between 0	and 999
*/
--	======================================================================================================

	spool off;




