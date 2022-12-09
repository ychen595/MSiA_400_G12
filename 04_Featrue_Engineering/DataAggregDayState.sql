-- Create aggregated data
drop table if exists aggtrnsact;
CREATE TABLE aggtrnsact AS(
WITH purchases as(
	SELECT * 
	FROM "TRNSACT"
	WHERE "STYPE" = 'P'
)
SELECT 
	"SALEDATE" as saledate, 
	"STATE" as state,
	COUNT(DISTINCT purchases."SKU") AS nsku,
	SUM("QUANTITY") AS totalquantity, 
	SUM("QUANTITY") /COUNT(DISTINCT "TRANNUM") AS avgquantity, 
	SUM("AMT") AS totalamt, 
	SUM("AMT")/COUNT(DISTINCT "TRANNUM") AS avgamt, 
	MIN("AMT") AS minamt,
	MAX("AMT") AS maxamt,
	SUM("ORIGPRICE") AS totalorigprice,
	AVG("ORIGPRICE") AS avgorigprice, 
	MIN("ORIGPRICE") AS minorigprice,
	MAX("ORIGPRICE") AS maxorigprice,
	SUM("RETAIL") AS totalretail,
	AVG("RETAIL") AS avgretail, 
	MIN("RETAIL") AS minretail,
	MAX("RETAIL") AS maxretail,
	SUM("RETAIL")/COUNT(DISTINCT "TRANNUM") AS avgretailtrnsact,
	SUM("COST") AS totalcost, 
	AVG("COST") AS avgcost, 
	MIN("COST") AS mincost,
	MAX("COST") AS maxcost,
	SUM("COST")/COUNT(DISTINCT "TRANNUM") AS avgcosttrnsact, 
	SUM("RETAIL" - "ORIGPRICE") AS totaldiscount,
	SUM("RETAIL" - "ORIGPRICE")/COUNT(DISTINCT "TRANNUM") AS avgdiscounttrnsact,
	MIN("RETAIL"-"ORIGPRICE") AS mindiscount, 
	MAX("RETAIL"-"ORIGPRICE") AS maxdiscount,
	SUM("RETAIL"-"COST") AS totalprofit,
	SUM("RETAIL"-"COST")/COUNT(DISTINCT "TRANNUM") AS avgprofittrnsact,
	MIN("RETAIL"-"COST") AS minprofit,
	MAX("RETAIL"-"COST") AS maxprofit,
	COUNT(DISTINCT purchases."STORE") AS nstore,
	COUNT(DISTINCT "CITY") AS ncities,
	COUNT(DISTINCT "DEPT") AS ndept,
	COUNT(DISTINCT "VENDOR") AS nvendors,
	COUNT(DISTINCT "VENDOR")/COUNT(DISTINCT purchases."STORE") AS avgvendorsstore
FROM purchases
LEFT JOIN "STRINFO" ON purchases."STORE" = "STRINFO"."STORE"
LEFT JOIN "SKUINFO" ON purchases."SKU" = "SKUINFO"."SKU"
LEFT JOIN "SKSTINFO" ON purchases."SKU" = "SKSTINFO"."SKU" AND purchases."STORE" = "SKSTINFO"."STORE"
GROUP BY "SALEDATE", "STATE"
);

GRANT ALL ON TABLE public.aggtrnsact TO ali8110 WITH GRANT OPTION;

GRANT ALL ON TABLE public.aggtrnsact TO xst2267 WITH GRANT OPTION;

GRANT ALL ON TABLE public.aggtrnsact TO ycj6475 WITH GRANT OPTION;

GRANT ALL ON TABLE public.aggtrnsact TO ycm3076 WITH GRANT OPTION;


drop table if exists aggtrnsact2;
CREATE TABLE aggtrnsact2 AS(
	SELECT * 
	FROM aggtrnsact
);

UPDATE aggtrnsact2
SET totalprofit = 0
WHERE totalprofit<0;

UPDATE aggtrnsact2
SET avgprofittrnsact = 0
WHERE avgprofittrnsact<0;

UPDATE aggtrnsact2
SET minprofit = 0
WHERE minprofit<0;

UPDATE aggtrnsact2
SET maxprofit = 0
WHERE maxprofit<0;

 
GRANT ALL ON TABLE public.aggtrnsact2 TO ali8110 WITH GRANT OPTION;

GRANT ALL ON TABLE public.aggtrnsact2 TO xst2267 WITH GRANT OPTION;

GRANT ALL ON TABLE public.aggtrnsact2 TO ycj6475 WITH GRANT OPTION;

GRANT ALL ON TABLE public.aggtrnsact2 TO ycm3076 WITH GRANT OPTION;
