	set echo off;
--	=======================================================

--	see \\ scripts\verizon\VIEW_VERIZON

--	=================================================================================
--	phone number is unique

	select count(*) from garland.temp_view
	group by phone
	having count(*) > 1

--	=======================================================
--	remove header and trailer records

	delete from garland.temp_view  
	where phone like 'HL%' or phone like 'TL%';
	commit;

--	=======================================================
	set echo on;
