  set echo off;
  set timing off;
--  ==========================================================================================
--  Make Code Rental Corrections in CODE_DISTRICT & CCS_ADDRESSES
--  ==========================================================================================

  select * from garland.cdreladr where addr_name = 'NORTH SHORE' and addr_num = 1014;

  update garland.code_district set is_rental = 0 where parcel_id = 5001033;

  select * from garland.code_district where parcel_id = 5001033;
  
  update garland.ccs_addresses set inspector_dist = 3 where parcel_id = '5001033.000';

  select * from garland.ccs_addresses where parcel_id = '5001033.000';

  ROLLBACK;

  COMMIT;

--  desc garland.code_district;
--  desc garland.ccs_addresses;

