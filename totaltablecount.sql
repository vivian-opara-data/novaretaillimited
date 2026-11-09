USE NovaRetail;
GO
SELECT COUNT(*) AS totalorders
FROM dbo.nrorderscsv;
SELECT COUNT(*) AS totalproducts
FROM dbo.nrproductscsv;
SELECT COUNT(*) AS totalcustomers
FROM dbo.nrcustomerscsv;
SELECT COUNT(*) AS totalbranches
FROM dbo.nrbranchescsv;
SELECT COUNT(*) AS totalinventoryrecords
FROM dbo.nrinventorycsv;

