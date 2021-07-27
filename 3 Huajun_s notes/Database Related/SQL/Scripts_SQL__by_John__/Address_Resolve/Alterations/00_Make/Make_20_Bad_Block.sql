	set echo off;
	set charwidth	200;
--	======================================================================================================
	create or replace view garland.adrResult_vw	as select * from garland.adrResult_Part_vw;
--	create or replace view garland.adrResult_vw	as select * from garland.adrResult_Full_vw;
--	======================================================================================================

	select '*** load Bad Block alter ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " " from dual;
	spool	c:\deacutis\scripts\address_resolve\alterations\20_Bad_Block.sql;			--	change

	select	distinct
			rpad(
			'insert into garland.adrAlter_vw	values ('	||
			rpad (digits, 20)			|| '''='	||
			verify_code				||
--			'  #'					|| seq	||
			' ', 60)				" ",

			rpad(st_name, 12)			st_name, 	 	
			''','					|| chr(10)	||
			string ||	' );'			" " 
	from

(
	select	digits,
			string,	
			st_name,
			rec_seq				seq,
			verify_code
	from
(
select	distinct
		lower(form_name)				st_name,
		rec_seq,
		verify_code,						--	change


	''''||addr_num ||''','''|| addr_num || ''','	digits,	

	''''',	'		||
	'''' ||	lower(rtrim(appl_pfx ))	|| ''', ' ||
	'''' ||	lower(rtrim(appl_name))	|| ''', ' ||
	'''' ||	lower(rtrim(appl_type))	|| ''', ' ||
	'''' ||	lower(rtrim(appl_sfx ))	|| ''', ' ||
			chr(10)	||


	''''',	'		||
	'''' ||	lower(rtrim(form_pfx ))		|| ''', ' ||
	'''' ||	lower(rtrim(form_name))		|| ''', ' ||
	'''' ||	lower(rtrim(form_type))		|| ''', ' ||
	'''' ||	lower(rtrim(form_sfx ))		|| ''', ' ||
			chr(10)	||


	''''',	'		||
	'''' ||	lower(rtrim(addr_pfx ))		|| ''', ' ||
	'''' ||	lower(rtrim(addr_name))		|| ''', ' ||
	'''' ||	lower(rtrim(addr_type))		|| ''', ' ||
	'''' ||	lower(rtrim(addr_sfx ))		|| '''	 ' 
								string

--	===============================================

	from	garland.adrResult_vw


	where	trunc (verify_code, -1) = 20			--	change

))

	where		seq	> 0	
									
	order by	st_name
;

--	======================================================================================================
/*												
			verify_code	in	( 0 )		

			name	in	(	''	)			--	street name
			name	like	'%%'			

			seq	in	( 0	)				--	display sequence
			seq	between 0	and 999
*/
--	======================================================================================================

	spool off;
