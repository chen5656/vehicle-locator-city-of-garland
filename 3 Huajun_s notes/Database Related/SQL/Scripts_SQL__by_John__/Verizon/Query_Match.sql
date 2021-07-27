--	desc garland.verizon_info;


--	select count(*) from
--	select * from

(
	select ltrim(rpad(parcel_id,7),'0') parcel_id, addr_name, addr_num 	--,addr_pfx ,addr_type
	from	garland.adrResult_Verizon
	minus
	select parcel_id||'', streetname, streetnum||'' 				-- ,streetprefix ,streettype
	from	garland.Verizon_info
)

--	where rownum < 111

	;


