
--	test processing time of SQL instructions

	set echo	off;
	set timing on;

declare

	aa	varchar2(80) := 'xxxxx yyyyy zzzzz	';
	bb	varchar2(80);
	cc	varchar2(80);

	ll	number := 0;
	mm	number := 0;
	nn	number := 0;

begin

for x in 1..1000000  loop

	bb	:= ltrim (aa,	'xyz ');

--	ll	:= ll + length(aa); - length(bb);

--	aa	:= instr (aa, 'n');

end loop;

end;
