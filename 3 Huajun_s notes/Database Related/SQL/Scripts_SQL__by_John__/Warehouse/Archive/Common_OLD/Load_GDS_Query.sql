	set linesize 2000;

	SELECT

	rpad(account,		20)		account,
	rpad(pidn,		20)		pidn,
--	rpad(status_acct,	10)		status_acct,
--	rpad(status_inf,	10)		status_inf,
--	rpad(status_mail,	10)		status_mail,
	rpad(owner_name,	40)		owner_name,
	rpad(owner_addr1,	40)		owner_addr1,
	rpad(owner_addr2,	40)		owner_addr2,
	rpad(owner_addr3,	40)		owner_addr3,
	rpad(owner_addr4,	40)		owner_addr4,
	rpad(owner_zip,		10)		owner_zip,
--	rpad(mortgage_co,	20)		mortgage_co,
	rpad(addr_num,		10)		addr_num,
	rpad(addr_name,		40)		addr_name,
	rpad(legal1,		40)		legal1,
	rpad(legal2,		40)		legal2,
	rpad(legal3,		40)		legal3,
	rpad(acct_type,		10)		acct_type,
	rpad(acct_use,		10)		acct_use,
	rpad(legal4,		40)		legal4

	from jdeacutis.GDS_ACCOUNT_EXTERNAL
	where rownum < 11
	;
