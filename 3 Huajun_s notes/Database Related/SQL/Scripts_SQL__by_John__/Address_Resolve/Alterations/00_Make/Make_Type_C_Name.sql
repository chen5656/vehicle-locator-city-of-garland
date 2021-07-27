	set echo off;
	set charwidth	240;
--	======================================================================================================
	create or replace view garland.adrResult_vw	as select * from garland.adrResult_Part_vw;
--	create or replace view garland.adrResult_vw	as select * from garland.adrResult_Full_vw;
--	======================================================================================================
	variable	 spec1	varchar2;
	variable	 spec2	varchar2;

	execute	:spec1 := ''''', ';
--	execute	:spec1 := '''0'', ';

	execute	:spec2 := ''''', ';
--	execute	:spec2 := '''0'', ';
--	execute	:spec2 := '''N'', ';
--	======================================================================================================

	select '*** load Type C alter ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " " from dual;
	spool	c:\deacutis\scripts\address_resolve\alterations\Type_C_Name.sql;			--	change

	select	distinct
			rpad(
			'insert into garland.adrAlter_vw	values ('	||
			rpad (digits, 08)			|| ''''	||
			id					||
--			'  #'					|| seq	||
			' ', 53)				" ",

			rpad(st_name, 12)			st_name, 	 	
			''','					|| chr(10)	||
			string ||	' );'			" " 
	from

(

	select	digits,
			string,	
			rec_seq				seq,
			st_name,
			id
	from
(
select	distinct
		lower(form_name)				st_name,
		rec_seq,
		do_name					id,				--	change


	''''', '''','						digits,	
--	''''||addr_num ||''','''|| addr_num || ''','	digits,	

--	''''',	'		||
			ltrim(:spec1)			||'  '||
	'''' ||	lower(rtrim(appl_pfx ))		|| ''', ' ||
	'''' ||	lower(rtrim(appl_name))		|| ''', ' ||
	'''' ||	lower(rtrim(appl_type))		|| ''', ' ||
	'''' ||	lower(rtrim(appl_sfx ))		|| ''', ' ||
			chr(10)	||

			ltrim(:spec2)			||'  '||

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

	where	do_name	= 'C'			--	change

))

	where		seq	>  0					
									
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
