

--	APPLICATION TABLE

	drop synonym	garland.temp_syn1;
	create synonym	garland.temp_syn1		for garland.UTSTOOUTF;



--	COPY TABLE

	drop synonym	garland.temp_syn2;
	create synonym	garland.temp_syn2		for garland.GIS_OBJECTS;
