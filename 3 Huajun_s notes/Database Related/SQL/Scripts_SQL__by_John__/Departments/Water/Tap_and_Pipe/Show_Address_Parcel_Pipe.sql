	set echo off;
	set linesize 200;
    set pagesize 999999;

	select  addr_num    ||','|| addr_pfx ||','|| addr_name ||','|| addr_type ||','|| addr_sfx ||','|| 
    		a.parcel_id ||','|| pipe_id
    from	garland.WATER_IVR_PARCEL	P, 
    		garland.CDRELADR			A
    where	p.parcel_id = rtrim(a.parcel_id)
    and		a.parcel_id < 'A'
    order by addr_name, addr_type, addr_pfx, addr_sfx, addr_num        
            