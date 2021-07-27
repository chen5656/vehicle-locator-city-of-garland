	set echo		off;
	set timing		on;
	set serveroutput	on;

--	test processing time of SQL instructions

declare

	job		number	:= 04;
	cycles	number	:= 1000;

--	============================================================

	this_num		number		:= 901;
	this_pfx		varchar2(02)	:= '';
	this_name		varchar2(20)	:= 'AVENUE A';
	this_type		varchar2(04)	:= '';
	this_sfx		varchar2(02)	:= '';

	this_reduced	varchar2(20)	:= 'AVENUEA';
	this_compact	varchar2(20)	:= 'OVONO';

	aa			varchar2(80) 	:= 'xxxxx yyyyy zzzzz	';
	bb			varchar2(80)	:= '';
	cc			varchar2(80)	:= '';
	dd			varchar2(80)	:= '';
	ee			varchar2(80)	:= '';

	count1		number 		:= 0;
	count2		number 		:= 0;
	mm			number 		:= 0;
	nn			number 		:= 0;
	pp			number 		:= 0;
	qq			number 		:= 0;


	bool1			boolean;
begin

for x in 1..cycles		loop

--	============================================================================

	if	job = 0		then
		null;

	elsif	job = 1		then

		TST_alias_match (bb, this_num, this_pfx, this_name, this_type, this_sfx, this_reduced, this_compact);

	elsif	job = 2		then

		this_name := adr_compress_name (this_name, '3');
		this_name := adr_compress_name (this_name, '4');

	elsif	job = 3		then

		select count(*)	into count1 	from cdreladr
		where addr_name = this_name  and  addr_num = this_num;


	elsif	job = 4		then

	select /*+ cache (adrItem) */	
		count(*)
	into	count1
	from adrItem 
	where class in ('B', 'K');


	elsif	job = 20		then
		select	count(*)	into count1
		from		adrAlias

		where	(
			(	alias_name	like 'A'
		and		alias_compact = this_compact	)	

		or	(	alias_name	between '% ' and '%z'
		and		this_name	like	alias_name			)
			)

		and		alias_type	in	('*', this_type)
		and		alias_pfx	in	('*', this_pfx)
		and		alias_sfx	in	('*', this_sfx)
		and		alias_lo			<= this_num
		and		nvl (alias_hi, 999999)	>= this_num
		;
	end if;

--	============================================================================

end loop;

end;


