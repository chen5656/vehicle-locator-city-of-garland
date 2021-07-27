	set echo off;


--	select count(*) VERIZON		from garland.phone_verizon;
--	select count(*) ATT		from garland.phone_sbc;

	select count(*) PHONE		from garland.phone;

	select count(*) PHONE_V		from garland.phone	where source = 'V';

	select count(*) PHONE_A		from garland.phone	where source = 'A';

	select count(zip_code) ZIP	from garland.phone;


	desc garland.Phone;
