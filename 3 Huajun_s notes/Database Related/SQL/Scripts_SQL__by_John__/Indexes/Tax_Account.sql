

	create unique index	garland.tax_account
		on			garland.Tax (macctno)

	tablespace	gisindx
	storage	(initial 1m next 1m pctincrease 0);
