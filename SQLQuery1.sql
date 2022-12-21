SELECT DISTINCT propertyType FROM dbo.raw_sales$;

SELECT DISTINCT bedrooms FROM dbo.raw_sales$;

SELECT COUNT(*) FROM dbo.raw_sales$
WHERE bedrooms = 0;

SELECT * FROM dbo.raw_sales$
WHERE bedrooms = 0;

SELECT YEAR(datesold) AS Year, AVG(price) Revenue FROM dbo.raw_sales$
GROUP BY datesold
ORDER BY Revenue DESC;

SELECT propertyType, YEAR(datesold) AS Year, AVG(price) Revenue FROM dbo.raw_sales$
GROUP BY datesold, propertyType
ORDER BY Revenue;

SELECT propertyType, bedrooms, AVG(price) Revenue FROM dbo.raw_sales$
WHERE propertyType = 'house'
GROUP BY propertyType, bedrooms
ORDER BY Revenue DESC;

SELECT TOP 10 datesold AS Date_of_Purchase, COUNT(*) AS number_of_sales, AVG(price) 'Average_Price'
FROM raw_sales$
GROUP BY datesold
ORDER BY number_of_sales DESC;

SELECT TOP 10 postcode, AVG(price) AS 'Average_Price'
FROM dbo.raw_sales$
GROUP BY postcode
ORDER BY AVG(price) DESC

SELECT YEAR(datesold) as year, postcode, price,
         dense_rank() OVER (PARTITION BY YEAR(datesold), postcode ORDER BY price DESC) rnk
INTO #sales2
FROM dbo.raw_sales$

SELECT r.year, r.postcode, r.price
FROM(
    SELECT *,
    ROW_NUMBER() OVER (PARTITION BY year ORDER BY price DESC) row_num
    FROM #sales2
    WHERE rnk < 2) r
WHERE r.row_num BETWEEN 1 AND 6