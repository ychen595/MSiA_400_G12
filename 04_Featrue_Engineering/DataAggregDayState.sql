-- RenameColumns: INT and SEQ are inverted
ALTER TABLE "TRNSACT"
  RENAME COLUMN "SEQ" TO "INTID2";
ALTER TABLE "TRNSACT"
  RENAME COLUMN "INTID" TO "SEQ";
ALTER TABLE "TRNSACT"
  RENAME COLUMN "INTID2" TO "INTID";

-- RenameColumns: ORIGPRICE AND AMT are inverted
ALTER TABLE "TRNSACT" 
  RENAME COLUMN "ORIGPRICE" TO "AMT2";
ALTER TABLE "TRNSACT"
  RENAME COLUMN "AMT" TO "ORIGPRICE";
 ALTER TABLE "TRNSACT"
  RENAME COLUMN "AMT2" TO "AMT";

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
	SUM("COST"-"RETAIL") AS totalprofit,
	SUM("COST"-"RETAIL")/COUNT(DISTINCT "TRANNUM") AS avgprofittrnsact,
	MIN("COST"-"RETAIL") AS minprofit,
	MAX("COST"-"RETAIL") AS maxprofit,
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


