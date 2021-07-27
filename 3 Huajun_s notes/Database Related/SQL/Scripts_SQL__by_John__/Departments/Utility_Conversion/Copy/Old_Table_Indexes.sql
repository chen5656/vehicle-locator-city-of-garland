 
select 'UTWAPIP_MSLINK' " " from dual;
create index   GARLAND.UTWAPIP_MSLINK
       on      GARLAND.UTWATPIP
(
 MSLINK
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 2M next 1M   pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;
 
 
select 'UTSTOPIP_X_MSLINK' " " from dual;
create unique index   GARLAND.UTSTOPIP_X_MSLINK
       on      GARLAND.UTSTOPIP
(
 MSLINK
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 6M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'UTSTOOCH_X_MSLINK' " " from dual;
create unique index   GARLAND.UTSTOOCH_X_MSLINK
       on      GARLAND.UTSTOOCH
(
 MSLINK
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 6M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'I_SANPIP_MSL' " " from dual;
create unique index   GARLAND.I_SANPIP_MSL
       on      GARLAND.UTSANPIP
(
 MSLINK
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 1M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 

