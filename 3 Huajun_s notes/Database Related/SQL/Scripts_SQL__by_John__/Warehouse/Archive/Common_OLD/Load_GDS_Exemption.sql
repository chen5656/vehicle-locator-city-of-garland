
--   desc garland.gds_exemption;
--   desc jdeacutis.gds_exemption_external;

   truncate table garland.gds_exemption  reuse storage;

   insert --+ append
   into   garland.gds_exemption
   select * from jdeacutis.gds_exemption_external;

   commit;   

   select * from garland.gds_exemption  where tax_year = 2006 and rownum < 11;

