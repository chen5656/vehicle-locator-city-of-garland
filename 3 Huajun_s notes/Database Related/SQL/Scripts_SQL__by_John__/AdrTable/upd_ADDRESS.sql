--	================================================================
--	Update ADDRESS X,Y Coordinates
--	================================================================

declare

	compile_only		number := 01;
	script_address_view	varchar2(400);

begin
	if	compile_only > 0	then return; end if;

	select  'create or replace view jdeacutis.address_ftable as select * from gis.' || layer " "
	into script_address_view		from sde.showtable where table_name = 'ADDRESS';

	DBMS_UTILITY.EXEC_DDL_STATEMENT (Script_Address_View);

	update gis.address		A 
	set  ( xcoord, ycoord ) = 
(
	select eminx, eminy	  
	from	jdeacutis.address_ftable	F
	where	a.shape = f.fid
);
end;

--	================================================================



