	set echo off;
	set charwidth	300;
--	======================================================================================================
	create or replace view garland.adrResult_vw	as select * from garland.adrResult_Part_vw;
--	create or replace view garland.adrResult_vw	as select * from garland.adrResult_Full_vw;
--	======================================================================================================

	select '*** load Non Correct alter ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " " from dual;
	spool	c:\deacutis\scripts\address_resolve\alterations\02_Non_Correct.sql;		--	change


	select	'insert into garland.adrAlter_vw	values ( '		||
			rpad (digits,20) 			|| 
			''''	 || ' =' || id		||
--			lpad ('#', 05)			|| seq	 	||'  '||
			''','					|| chr(10)		||
			string ||	' );'			" " 
	from

(
	select	digits,
			string,	
			rownum				seq,
			addr_name,
			id
	from
(
select	distinct
		lower(addr_name)				addr_name,
		verify_code					id,				--	change


	'''0'', ''999999'','				digits,	
--	''''||addr_num ||''','''|| addr_num || ''','	digits,	

	''''',	'		||
	'''' ||	lower(rtrim(appl_pfx ))		|| ''', ' ||
	'''' ||	lower(rtrim(appl_name))		|| ''', ' ||
	'''' ||	lower(rtrim(appl_type))		|| ''', ' ||
	'''' ||	lower(rtrim(appl_sfx ))		|| ''', ' ||
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

	where	verify_code = 02						--	change
	and	nvl(do_alias,' ') < '0' 

))

	where		seq > 0					

	order by	addr_name;

--	======================================================================================================
/*												
			id	in	( '', '', '' )			--	verify code

			addr_name	in	(	''	)		--	street name
			addr_name	like	'%%'			

			seq	in	( 0	)				--	display sequence
			seq	between 0	and 999
*/
--	======================================================================================================

	spool off;

