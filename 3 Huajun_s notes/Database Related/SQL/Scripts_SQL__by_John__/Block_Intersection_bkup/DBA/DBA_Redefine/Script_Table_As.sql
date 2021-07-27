Statement processed.
select 'CREATE CDRELPAR' " " from dual;
create table   GARLAND.CDRELPAR
tablespace GIS_DATA   pctfree  10   pctused 40
           initrans 1 maxtrans 255
storage   (initial 6M next 1M  pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.CDRELPAR;
select count(*) "CDRELPAR" from GARLAND.CDRELPAR;
 
select 'CREATE PAVE_MAST' " " from dual;
create table   GARLAND.PAVE_MAST
tablespace GIS_DATA   pctfree  10   pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M  pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.PAVE_MAST;
select count(*) "PAVE_MAST" from GARLAND.PAVE_MAST;
 
select 'CREATE CDRELADR' " " from dual;
create table   GARLAND.CDRELADR
tablespace GIS_DATA   pctfree  10   pctused 40
           initrans 1 maxtrans 255
storage   (initial 7M next 1M  pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.CDRELADR;
select count(*) "CDRELADR" from GARLAND.CDRELADR;
 
Echo                            OFF
Server Output                   ON
Charwidth                       100
