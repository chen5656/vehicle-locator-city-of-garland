
	set fetchrows	111;


	select distinct
		 hscode, dvcode, exempt
	from	garland.TAX;


	select distinct
		 sptlnd, sptimp, sptprd, sptper		--  ZONING CODE
	from	garland.TAX;

	
	select distinct 
		mprptyp
	from	garland.TAX;


	set fetchrows;
