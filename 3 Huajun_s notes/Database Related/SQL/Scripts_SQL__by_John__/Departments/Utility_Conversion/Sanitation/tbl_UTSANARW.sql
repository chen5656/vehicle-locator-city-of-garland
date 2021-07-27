
	select 'UTSANARW  ' || to_char(sysdate, 'mon dd,yyyy hh24:mi') " " from dual;

--	drop table	UTSANARW;	

	explain plan set statement_id = 'SANARW'  into garland.plan_table  for

	Create table	UTSANARW
(
	mslink			number(8,0)	not null,
	mapid				number(8,0)
)
	nologging
	pctfree	20
	tablespace			gis_data
	storage			(initial 50K  next 50K  pctincrease 0);

--	===============================================================
