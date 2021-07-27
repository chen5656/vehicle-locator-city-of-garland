	set echo		off;
	set serveroutput	on;

declare

	this_result1	varchar2(80);

begin

	update	garland.adrName
	set		addr_reduced = 
(
	select	addr_compress
--	select	addr_reduced

	from
(
	select	distinct
			addr_reduced
	from		adrName
	where		addr_name = 'ACORN GREEN'
--	where		addr_name = 'ABBEY'

	with		READ ONLY
)
)
	where		addr_name = 'ACORN GREEN'

	returning	addr_reduced	into this_result1
	;


	dbms_output.put_line (this_result1);
	
	rollback;

end;
