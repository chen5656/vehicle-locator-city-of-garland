--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================

create or replace function	garland.CCS_LOAD_QUALITY_CHECK (CCS_Control varchar2) 
					return Number
AS
	compile_only	integer	:= 0;

	title			varchar2(100);
	heading		varchar2(100);
	control		varchar2(100);
	result		number;

	old_ccs		integer;
	new_ccs		integer;
	old_adrid		integer;
	old_taxid		integer;
	old_umsid		integer;
	new_adrid		integer;
	new_taxid		integer;
	new_umsid		integer;
	code_differ		integer;

BEGIN

	if	compile_only > 0		then
		return 0;
	end if;

	control := ccs_control;

	if	control = 'FORCE'		then
		return +1;
	end if;

--	==============================================================================
--	CCS ADDRESS
--		first it holds the current CCS ADDRESS seen here)
--		then  it holds the newest  CCS ADDRESS 

	select count(*) 
	into	old_ccs
	from	garland.CCS_ADDRESS;

--	CCS ADDRESS COPY
--		first it holds of copy of the newest  CCS ADDRESS (seen here)
--		then  it holds of copy of the current CCS ADDRESS

	select count(*) 
	into	new_ccs
	from	garland.CCS_ADDRESS_NEW;
		
	dbms_output.put_line('$$$ 1. RECORDS: Old='||lpad(old_ccs,5)||' New='||lpad(new_ccs,5) );
		
--	==============================================================================
--	How many GIS, TAX, UMS Keys were populated

	select count(address_id), count(tax_id), count(ums_id)
	into	old_adrid, old_taxid, old_umsid
	from	garland.CCS_ADDRESS;

	select count(address_id), count(tax_id), count(ums_id)
	into	new_adrid, new_taxid, new_umsid
	from	garland.CCS_ADDRESS_NEW;

	dbms_output.put_line('$$$ 2. KEYS: GIS='||lpad(new_adrid,5)||' TAX='||lpad(new_taxid,5)
								||' UMS='||lpad(new_umsid,5) );

--	==============================================================================
--	How many <Address ID / Code Inspection District> combinations were lost

	select count(*)	into code_differ	from
	(	select address_id, inspector_dist from garland.ccs_address_NEW
		minus
		select address_id, inspector_dist from garland.ccs_address	);

	dbms_output.put_line('$$$ 3. CODE DISTRICT CHANGES ='||lpad(code_differ,5) );
		
--	==============================================================================
--	Look for Error conditions

--	What is percent change in size of Old and New CCS Address

	if	old_ccs = 0
	or	abs(old_ccs - new_ccs) / old_ccs > 0.10
		then	Result := -1;	

--	Are there enough GIS, TAX, UMS keys

	elsif	new_adrid < 65000
	or	new_taxid < 65000
	or	new_umsid < 60000		
		then	Result := -2;	

--	Were many Address/CodeDist changed or lost

	elsif	code_differ > 1000
		then	Result := -3;	
    
--	==============================================================================

	else	Result := +1;	
	end if;

	dbms_output.put_line('$$$ CCS Quality Control Result = ' || Result);

	return Result;

END;

