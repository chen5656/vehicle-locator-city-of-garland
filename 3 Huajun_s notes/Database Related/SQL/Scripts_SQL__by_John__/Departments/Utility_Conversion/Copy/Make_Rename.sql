
--	select * from obj where object_name like 'UT%' and object_name like '%BKUP'
--	select * from tabs where table_name like 'UT%' and table_name like '%OLD';


	select ' rename ' || table_name || ' to ' || replace(table_name, '_BKUP', '_OLD') || ';'
	from tabs
	where table_name like 'UT%' and table_name like '%BKUP';


--------------------------------------------------------------------------------
 rename table UTELETVT_BKUP to UTELETVT_OLD;                                    
 rename table UTSANARW_BKUP to UTSANARW_OLD;                                    
 rename table UTSANFIT_BKUP to UTSANFIT_OLD;                                    
 rename table UTSANLAT_BKUP to UTSANLAT_OLD;                                    
 rename table UTSANLST_BKUP to UTSANLST_OLD;                                    
 rename table UTSANMH_BKUP to UTSANMH_OLD;                                      
 rename table UTSANPIP_BKUP to UTSANPIP_OLD;                                    
 rename table UTSTOARW_BKUP to UTSTOARW_OLD;                                    
 rename table UTSTOCOM_BKUP to UTSTOCOM_OLD;                                    
 rename table UTSTOCTY_BKUP to UTSTOCTY_OLD;                                    
 rename table UTSTOHDWL_BKUP to UTSTOHDWL_OLD;                                  
 rename table UTSTOINL_BKUP to UTSTOINL_OLD;                                    
 rename table UTSTOJUN_BKUP to UTSTOJUN_OLD;                                    
 rename table UTSTOMDU_BKUP to UTSTOMDU_OLD;                                    
 rename table UTSTOMH_BKUP to UTSTOMH_OLD;                                      
 rename table UTSTOOCH_BKUP to UTSTOOCH_OLD;                                    
 rename table UTSTOOUT_BKUP to UTSTOOUT_OLD;                                    
 rename table UTSTOPIP_BKUP to UTSTOPIP_OLD;                                    
 rename table UTSTOPON_BKUP to UTSTOPON_OLD;                                    
 rename table UTWATARW_BKUP to UTWATARW_OLD;                                    
 rename table UTWATFIT_BKUP to UTWATFIT_OLD;                                    
 rename table UTWATHYD_BKUP to UTWATHYD_OLD;                                    
 rename table UTWATMTR_BKUP to UTWATMTR_OLD;                                    
 rename table UTWATPIP_BKUP to UTWATPIP_OLD;                                    
 rename table UTWATPSTA_BKUP to UTWATPSTA_OLD;                                  
 rename table UTWATTNK_BKUP to UTWATTNK_OLD;                                    
 rename table UTWATVLV_BKUP to UTWATVLV_OLD;                                    
27 rows selected.