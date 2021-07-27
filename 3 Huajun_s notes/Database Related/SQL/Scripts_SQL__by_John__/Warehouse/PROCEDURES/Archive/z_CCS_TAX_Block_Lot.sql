--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	2000;
set pagesize	9999;
--	=====================================================================
--	Dissect Block and Lot from Tax_Legal_Desc in Common_TAX.
--	=====================================================================

--	=====================================================================

--	execute	garland.CCS_TAX_Block_Lot;

	create or replace procedure garland.CCS_TAX_Block_Lot		as

--	DECLARE

--	=====================================================================

	compile_only	integer := 0;
	do_update		integer := 0;

	total_update	integer := 0;
	locate11		integer;
	locate12		integer;
	locate21		integer;
	locate22		integer;
	locate23		integer;

	this_blk		varchar2(200);
	this_lot		varchar2(200);
	pattern		varchar2(200);
	title			varchar2(100);

cursor	Read_TAX_Legal	is 

	select 
		c.tax_account		Account, 
		g.legal1			Subdivision,
		' '||g.legal2||' '	Legal2, 
		g.rowid 			GDS_rowid,
		c.rowid 			TAX_rowid
	from	garland.GDS_ACCOUNT	G,
		garland.COMMON_TAX	C
	where	g.account	= c.tax_account+0
	and	acct_type 	= 'R'
--	AND	ROWNUM < 111
	;

BEGIN

	if	compile_only > 0	then
		return;
	end if;

--	=================================================================================
	title := '***  CCS TAX BLOCK and LOT  ***  ';
	dbms_output.put_line(title);
--	=================================================================================

for	read in Read_TAX_Legal		loop

	this_blk	:= null;
	this_lot	:= null;
	locate11	:= 0;
	locate12	:= 0;
	locate21	:= 0;
	locate22	:= 0;
	locate23	:= 0;

	pattern	:= translate (read.legal2,	'0123456789ABCDEFGHIJKLMNOPRSTUVWXZ',
								'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');

	locate11	:= instr(read.legal2, ' BLK ');

	if	locate11 > 0	then
		locate12	:= instr(pattern, 'x', locate11 + 05);
	end if;

	locate21	:= instr(read.legal2, ' LOT ', locate12);

	if	locate21 = 0	then
		locate21	:= instr(read.legal2, ' LT ', locate12);
	end if;

	if	locate21 > 0	then
		locate22	:= instr(pattern, 'x', locate21 + 04);
		locate23	:= instr(pattern, ' ', locate22);
	end if;

	if	locate11 > 0	then
		this_blk	:= ltrim(rtrim(substr(read.legal2, locate12, locate21 - locate12)));
	end if;

	if	locate21 > 0	then
		this_lot	:= ltrim(rtrim(substr(read.legal2, locate22, locate23 - locate22)));
	end if;

	if	locate11  > 0
	and	locate21  > 0
	and	translate(this_blk,'x1234567890','x') is null
	and	translate(this_lot,'x1234567890','x') is null	then
	
--		dbms_output.put_line ('LOCATE:     ' ||locate11||' '||locate12||' '||locate21||' '||locate22||' '||locate23);
--		dbms_output.put_line ('ACCT,LEGAL: ' || read.account	||','|| read.legal2 ||','|| read.subdivision);
--		dbms_output.put_line ('BLK,LOT:    ' || this_blk	||','|| this_lot);
--		dbms_output.put_line ('----');

		if	do_update > 0	then
			update	garland.Common_TAX
			set		blk		= this_blk,
					lot		= this_lot,
					subdivision = read.subdivision
			where		rowid 	= read.tax_rowid;
	
			total_update	:= total_update + 01;
		end if;
	end if;

end loop;

	COMMIT;

	dbms_output.put_line ( 'Total Updates = ' || total_update);

END;

--	=====================================================================
/*
	select legal1, legal2, legal3
	from	garland.GDS_ACCOUNT
	where	acct_type = 'R'
	AND	ROWNUM < 111;
*/
--	=====================================================================

