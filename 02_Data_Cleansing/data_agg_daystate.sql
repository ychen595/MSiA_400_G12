-- Agregate trnsact tbl by day and state 
drop table if exists agg_data2;
CREATE TABLE agg_data2 AS(
SELECT 
"SALEDATE" as saledate, 
"STATE" as state,
COUNT(DISTINCT "TRNSACT"."SKU") AS nsku,
SUM(CASE WHEN "STYPE" = 'R' THEN 1 ELSE 0 END) AS nreturns,
SUM(CASE WHEN "STYPE" = 'P' THEN 1 ELSE 0 END) AS npurchase,
SUM("QUANTITY") AS totalquantity, 
SUM("QUANTITY")/COUNT(DISTINCT "TRANNUM") AS avgquantity, 
MIN("QUANTITY") AS minquantity, 
MAX("QUANTITY") AS maxquantity,
SUM("AMT") AS totalincometrnsact, 
SUM("AMT")/COUNT(DISTINCT "TRANNUM") AS avgincometrnsact, 
MIN("AMT") AS minamt,
MAX("AMT") AS maxamt,
AVG("ORIGPRICE") AS avgorigprice, 
MIN("ORIGPRICE") AS minorigprice,
MAX("ORIGPRICE") AS maxorigprice,
AVG("RETAIL") AS avgretail, 
MIN("RETAIL") AS minretail,
MAX("RETAIL") AS maxretail,
SUM("COST"*"QUANTITY") AS totalcosttrnsact, 
SUM("COST"*"QUANTITY")/COUNT(DISTINCT "TRANNUM") AS avgcosttrnsact, 
MIN("COST") AS mincost,
MAX("COST") AS maxcost,
SUM("AMT" - "QUANTITY"*"ORIGPRICE") AS totaldiscount,
SUM("AMT" - "QUANTITY"*"ORIGPRICE")/COUNT(DISTINCT "TRANNUM") AS avgdiscount,
MIN("AMT" - "QUANTITY"*"ORIGPRICE") AS mindiscount, 
MAX("AMT" - "QUANTITY"*"ORIGPRICE") AS maxdiscount,
SUM("AMT" - "QUANTITY"*"RETAIL") AS totaldiscount2,
SUM("AMT" - "QUANTITY"*"RETAIL")/COUNT(DISTINCT "TRANNUM") AS avgdiscount2,
MIN("AMT" - "QUANTITY"*"RETAIL") AS mindiscount2, 
MAX("AMT" - "QUANTITY"*"RETAIL") AS maxdiscount2,
SUM("AMT"-"QUANTITY"*"COST") AS totalRevenue,
SUM("AMT"-"QUANTITY"*"COST")/COUNT(DISTINCT "TRANNUM") AS avgrevenue,
MIN("AMT"-"QUANTITY"*"COST") AS minrevenue,
MAX("AMT"-"QUANTITY"*"COST") AS maxrevenue,
COUNT(DISTINCT "TRNSACT"."STORE") AS nstore,
COUNT(DISTINCT "CITY") AS ncities,
COUNT(DISTINCT "DEPT") AS ndept,
COUNT(DISTINCT "VENDOR") AS nvendors,
COUNT(DISTINCT "VENDOR")/COUNT(DISTINCT "TRNSACT"."STORE") AS avgvendorsStore
FROM "TRNSACT"
LEFT JOIN "STRINFO" ON "TRNSACT"."STORE" = "STRINFO"."STORE"
LEFT JOIN "SKUINFO" ON "TRNSACT"."SKU" = "SKUINFO"."SKU"
LEFT JOIN "SKSTINFO" ON "TRNSACT"."SKU" = "SKSTINFO"."SKU" AND "TRNSACT"."STORE" = "SKSTINFO"."STORE"
GROUP BY "SALEDATE", "STATE"
);
