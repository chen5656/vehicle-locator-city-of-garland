
	insert into garland.water_work_order
(

/*
	JOB_ID,                        --1
	ADDR_NUM,                      --2
	ADDR_NAME,                     --3
	ADDR_PFX,                      --4
	MAP_ID,                        --5
	SEWER_ID,                      --6
	UNIT_PROD,                     --7
	COMPLETED_DATE,                --8
	JOB_TYPE                       --9
*/

--	DESCRIPTION,                   --10


	EMPLOYEE,                      --11
	EMPLOYEE_BOSS,                 --12

--	REG_HOURS,                     --13
--	OVERTIME_HOURS,                --14
--	LABOR_COST,                    --15
--	EQUIP_COST,                    --16
--	WATER_ID,                      --17


--	COMMENTS,                      --18
	ADDRESS,                       --19

	NUM_CALLS,                     --20
	COUNCIL_ID                     --21



)

	select 

/*	
	item01,
	item02,
	item03,
	item04,
	item05,
	item06,
	item07,
	to_date(item08, 'mm/dd/yyyy'),
	item09
*/


--	item10,

	item11,
	item12,

--	item13,
--	item14,
--	item15,
--	item16,
--	item17,

--	item18,
	item19,
	item20,
	item21

	from garland.gis_objects;

