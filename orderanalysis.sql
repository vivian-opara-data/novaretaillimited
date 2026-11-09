USE NovaRetail;
GO
SELECT
	COUNT(*) AS totalorders,
	SUM(quantity) AS totalunitssold,
	SUM(quantity * unit_price) AS grosssales,
	SUM(quantity * unit_price * discount_pct) AS totaldiscount,
	SUM(quantity * unit_price * (1 - discount_pct)) AS netrevenue,
	SUM(quantity * unit_cost) AS costofgoodssold,
	SUM(quantity * unit_price * (1 - discount_pct) - quantity * unit_cost) AS grossprofit
FROM dbo.nrorderscsv
WHERE order_status = 'delivered';

SELECT product_id,
	COUNT(*) AS numberoforders,
	SUM(quantity) AS unitssold, 
	SUM(quantity * unit_price * (1 - discount_pct)) AS netrevenue,
	SUM(quantity * unit_price * (1 - discount_pct) - quantity * unit_cost) AS grossprofit
FROM dbo.nrorderscsv
WHERE order_status = 'delivered'
GROUP BY product_id
ORDER BY netrevenue DESC;

SELECT product_id,
	SUM(quantity * unit_price * (1 - discount_pct)) AS netrevenue,
	SUM(quantity * unit_price * (1 - discount_pct) - quantity * unit_cost) AS grossprofit,
	ROUND(100.0 * SUM(quantity * unit_price * (1 - discount_pct) - quantity * unit_cost) / NULLIF(SUM(quantity * unit_price * (1 - discount_pct)), 0), 2) AS profitmarginpercentage
FROM dbo.nrorderscsv
WHERE order_status = 'delivered'
GROUP BY product_id
ORDER BY profitmarginpercentage DESC;