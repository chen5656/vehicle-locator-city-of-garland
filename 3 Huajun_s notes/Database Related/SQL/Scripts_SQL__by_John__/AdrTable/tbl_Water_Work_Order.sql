--	===================================================================
--	Water dept Work Orders
--	Stored extract received from GIS Intranet
--	===================================================================

--	drop table		garland.water_work_order

	create table	garland.water_work_order
(
	job_id		varchar2(08),
	job_type		varchar2(05),

	map_page		varchar2(04),		-- alias map_id
	water_id		number  (05),
	sewer_id		number  (05),
	council_id		varchar2(01),

	addr_num		number  (05),
	addr_pfx		varchar2(02),
	addr_name		varchar2(20),
	addr_type		varchar2(04),
	addr_sfx		varchar2(02),

	completed_date	date,

	num_calls		number(2),
	reg_hours		number(4,2),
	overtime_hours	number(4,2),
	labor_cost		number(4,2),
	equip_cost		number(4,2),
	unit_prod		number(4),			--  unit of production

	employee		varchar2(20),
	employee_boss	varchar2(20),

	comments		varchar2(20),
	description		varchar2(40),
	address		varchar2(40)
)

	nologging
	tablespace		gis_data
	storage		(initial 50k  next 50k  pctincrease 0);

