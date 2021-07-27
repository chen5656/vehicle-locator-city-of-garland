	set echo		off;
	set serveroutput	on	size 9999;
--	================================================================================================
--	define intersection table
--	query for optimal partition ranges
--	================================================================================================

/*
	create table	intersection
(
	addr1_block		number		not null,
	addr1_pfx		varchar2(02)	not null,
	addr1_name		varchar2(30)	not null,
	addr1_type		varchar2(04)	not null,
	addr1_sfx		varchar2(02)	not null,

	addr2_block		number		not null,
	addr2_pfx		varchar2(02)	not null,
	addr2_name		varchar2(30)	not null,
	addr2_type		varchar2(04)	not null,
	addr2_sfx		varchar2(02)	not null,

	intersect_type	char,
	intersect_id	varchar2(10),	--	type + id1 + dot + id2  (see \\20_ID_Assignment)

	street1		number,		--	adrStreet (Street_ID)
	street2		number,

	segment1		number,		--	TRVEHRCL  (MSlink)
	segment2		number,

	compass		varchar2(02)	--	"N" corner, "NE" corner, etc

--	region ids	

)

	tablespace	gis_data
	nologging

	pctfree 05	pctused 90
	storage (initial 1m  next 1m  pctincrease 0)

	partition by range (addr1_name)
(
--	partition intersection_B	values less than ('BOB'),
--	partition intersection_D	values less than ('CEL'),
--	partition intersection_F	values less than ('DAI'),
--	partition intersection_H	values less than ('FUL'),
--	partition intersection_J	values less than ('HAW'),
--	partition intersection_L	values less than ('KIN'),
--	partition intersection_N	values less than ('MAR'),
--	partition intersection_P	values less than ('NOR'),
--	partition intersection_R	values less than ('RED'),
--	partition intersection_T	values less than ('SHO'),
--	partition intersection_V	values less than ('VIC'),
	partition intersection_Z	values less than (maxvalue)
);

*/

--	================================================================================================
--	determine optimal partition ranges
--	================================================================================================
--	good results

--	table = trvehrcl	spec lead = 03	spec size = 1200	spec margin = 1.05	parts = 06
--	table = trvehrcl	spec lead = 03	spec size = 0600	spec margin = 1.05	parts = 12
--	================================================================================================

declare

		do_compile		number	:= 0;

		spec_lead		number	:= 03;		--	# leading letters of name
		spec_size		number	:= 600;		--	partition size
		spec_margin		number	:= 1.05;		--	size tolerance
		spec_last		varchar2(8) := 'U';		--	last range

		max_size		number	:= spec_margin * spec_size;
		total_recds		number	:= 0;
		total_parts		number	:= 0;
		this_size		number	:= 0;

		lo_name		varchar2(20) := rpad ('A', spec_lead);
		hi_name		varchar2(20);

cursor	read_street_names		is
		
		select	rpad (addr_name, spec_lead)	addr_name,
				count(*)				counter
		from		trvehrcl
		group by	rpad(addr_name, spec_lead);

begin

	if	do_compile > 0		then
		return;
	end if;

	dbms_output.put_line ( ' ' );

for look in read_street_names		loop

	if	this_size + look.counter > max_size		then
		dbms_output.put_line (lo_name ||' - '|| hi_name ||'		'|| this_size);
		total_parts	:= total_parts + 01;
		lo_name	:= look.addr_name;		
		this_size	:= 0;
	end if;

	hi_name	:= look.addr_name;
	this_size	:= this_size   + look.counter;
	total_recds	:= total_recds + look.counter;

end loop;

	total_parts	:= total_parts + 01;
	hi_name	:= rpad ('Z', spec_lead, 'Z');
	dbms_output.put_line ( lo_name ||' - '|| hi_name ||'		'|| this_size);


/*
	select	count(*)
	into		this_size
	from		trvehrcl
	where		addr_name >= spec_last;

	dbms_output.put_line ( ' ' );
	dbms_output.put_line ( rpad(spec_last,spec_lead) ||' - '|| hi_name ||'		'|| this_size);
*/


	dbms_output.put_line ( ' ' );
	dbms_output.put_line ( 'part size:  ' || spec_size ||'	margin:  ' || spec_margin );
	dbms_output.put_line ( 'partitions: ' || total_parts	||'	records: ' ||total_recds);

end;
